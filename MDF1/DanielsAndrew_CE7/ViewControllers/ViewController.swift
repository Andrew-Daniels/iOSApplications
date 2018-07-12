//
//  ViewController.swift
//  DanielsAndrew_CE7
//
//  Created by Andrew Daniels on 1/18/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI



class ViewController: UIViewController, EKEventEditViewDelegate, EKCalendarChooserDelegate {
    
    
    //Create IBOutlets and variables
    @IBOutlet weak var printAllEvents: UIButton!
    @IBOutlet weak var changeDefault: UIButton!
    var eventStore = EKEventStore()
    var eventCalendar: EKCalendar?
    var selectedCal: EKCalendar?
    var tempSelection: EKCalendar?
    @IBOutlet weak var newCalendar: UIButton!
    @IBOutlet weak var deleteCalendar: UIButton!
    @IBOutlet weak var removeAllEvents: UIButton!
    @IBOutlet weak var addEvent: UIButton!
    var dummyCal: EKCalendar?
    var status: EKAuthorizationStatus?
    var calendarSource: EKSource?
    
    //Get access to the eventStore
    //If granted allow the user
    override func viewDidLoad() {
        super.viewDidLoad()
        status = EKEventStore.authorizationStatus(for: .event)
        if status == .notDetermined || status == .authorized {
            //request access
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if let error = error {
                    print("Request failed with error: \(error)")
                    return
                }
                if granted {
                    print("Authorized")
                    self.status = .authorized
                    self.eventCalendar = EKCalendar(for: .event, eventStore: self.eventStore)
                    for source in self.eventStore.sources {
                        if source.sourceType == EKSourceType.local {
                            //We found our local source
                            self.eventCalendar?.source = source
                            self.calendarSource = source
                            self.eventCalendar?.title = "Andrew's Calendar"
                            self.eventCalendar?.cgColor = UIColor.purple.cgColor
                            break;
                        }
                    }
                } else {
                    //disable UI
                    DispatchQueue.main.async {
                        self.deleteCalendar.isEnabled = false
                        self.removeAllEvents.isEnabled = false
                        self.addEvent.isEnabled = false
                        self.changeDefault.isEnabled = false
                        self.printAllEvents.isEnabled = false
                    }
                }
            })}
        if status == .restricted || status == .denied {
            deleteCalendar.isEnabled = false
            removeAllEvents.isEnabled = false
            addEvent.isEnabled = false
            changeDefault.isEnabled = false
            printAllEvents.isEnabled = false
        }
    }

    
    // MARK: - IBActions
    
    //Allows user to change their default calender
    @IBAction func changeDefault(_ sender: UIButton) {
        let choose = EKCalendarChooser(selectionStyle: .single, displayStyle: .allCalendars, entityType: .event, eventStore: eventStore)
        choose.delegate = self
        choose.showsDoneButton = true
        choose.showsCancelButton = true
        let nav = UINavigationController(rootViewController: choose)
        present(nav, animated: true, completion: nil)
    }
    //Allows developer to print the amount of events that inside the selected calender
    //For debugging purposes
    @IBAction func printAllEvents(_ sender: Any) {
        if let selectedCal = selectedCal {
        let predicate = eventStore.predicateForEvents(withStart: Date(), end: Date(timeIntervalSinceNow: 24 * 60 * 60), calendars: [selectedCal])
        let events = eventStore.events(matching: predicate)
        print(events.count)
        }
    }
    
    //Allows the user to create a new calendar
    //Checks if calendar has already been created first
    //Create new one if there isn't one created yet
    @IBAction func newCalendar(_ sender: UIButton) {
        
        if let status = status {
            if status == .authorized {
                let calendars = eventStore.calendars(for: .event)
                for calendar in calendars {
                    print(calendar.title)
                    if calendar.title == "Andrew's Calendar" {
                        selectedCal = calendar
                        return
                    }
                }
                createNewCalendar()
                do {
                    try self.eventStore.saveCalendar(dummyCal!, commit: true)
                    selectedCal = dummyCal!
                    return
                } catch {
                    print(error)
                }
            }
        }
        let alert = UIAlertController(title: "Error", message: "You have not authorized this application to access your calendar.", preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(button)
        present(alert, animated: true, completion: nil)
        
    }
    //Allows user to add an event to their calender
    @IBAction func addEvent(_ sender: UIButton) {
        let eventVC = EKEventEditViewController()
        eventVC.eventStore = eventStore
        eventVC.editViewDelegate = self
        if let selectedCal = selectedCal {
            eventVC.event?.calendar = selectedCal
        }
        present(eventVC, animated: true, completion: nil)
    }
    
    //Allows user to delete the calendar selected
    @IBAction func deleteCalendar(_ sender: UIButton) {
        if let selectedCal = selectedCal {
            do{ try eventStore.removeCalendar(selectedCal, commit: true)
            }
            catch {print(error)}
        }
    }
    //Allows the user to remove all events from the calendar selected
    @IBAction func removeAllEvents(_ sender: UIButton) {
        if let selectedCal = selectedCal {
            removeEvents(calendar: selectedCal)
        } else if let defaultCal = eventStore.defaultCalendarForNewEvents {
            removeEvents(calendar: defaultCal)
        }
    }
    //Dismiss the editeventview whenever the cancel or add button is pressed
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - EKCalendarChooser Functions
    
    //Dismisses the view when cancel button is clicked
    func calendarChooserDidCancel(_ calendarChooser: EKCalendarChooser) {
        dismiss(animated: true, completion: nil)
    }
    //Dismisses the view when the done button is clicked
    //Changes the selected calendar to the tempSelection
    func calendarChooserDidFinish(_ calendarChooser: EKCalendarChooser) {
        if let tempSelection = tempSelection {
            selectedCal = tempSelection
        }
        dismiss(animated: true, completion: nil)
    }
    //Changes the tempSelection variable to hold the selected calendar is case the user decides to change it officially
    func calendarChooserSelectionDidChange(_ calendarChooser: EKCalendarChooser) {
        tempSelection = calendarChooser.selectedCalendars.first
    }
    //MARK: - Developer Created Functions
    //Removes all the events from the EKCalendar variable passed in as an argument
    func removeEvents(calendar: EKCalendar) {
        let predicate = eventStore.predicateForEvents(withStart: Date(), end: Date(timeIntervalSinceNow: 24 * 60 * 60), calendars: [calendar])
        let events = eventStore.events(matching: predicate)
        print(events.count)
        for event in events {
            do {
                try eventStore.remove(event, span: .thisEvent)
            } catch {
                print(error)
            }
        }
    }
    //creates a new instantiation of dummycalendar, this EKCalendar is what gets added to the user's calendar
    func createNewCalendar() {
        dummyCal = EKCalendar(for: .event, eventStore: self.eventStore)
        dummyCal?.title = "Andrew's Calendar"
        dummyCal?.cgColor = UIColor.purple.cgColor
        dummyCal?.source = calendarSource
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    
}

