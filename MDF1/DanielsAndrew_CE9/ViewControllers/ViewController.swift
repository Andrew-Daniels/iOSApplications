//
//  ViewController.swift
//  DanielsAndrew_CE9
//
//  Created by Andrew Daniels on 1/23/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit
import ContactsUI
import MessageUI

private let cellIdentifier = "Cell"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CNContactViewControllerDelegate, CNContactPickerDelegate, MFMailComposeViewControllerDelegate {
    //MARK: - Variables / IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    var contactStore = CNContactStore()
    var accessToMail = false
    var selectedEmail: String?
    var sentEmails: [sentEmail]?
    
    //MARK: - UITableViewDelegate
    
    //Returns the number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sentEmails = sentEmails {
            return sentEmails.count
        }
        return 0
    }
    
    //Returns the cell for the row at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 65
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        if let sentEmails = sentEmails {
            cell.emailAddress.text = sentEmails[indexPath.row].emailAddress
            cell.date.text = String(describing: sentEmails[indexPath.row].date)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Emails sent:"
    }
    
    //MARK: - View

    //Calls the functions to request access to contacts and mail from user.
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAccessToContacts()
        requestAccessToMail()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Developer Created Functions

    //Function that requests access to Contacts from user
    func requestAccessToContacts() {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .notDetermined {
            contactStore.requestAccess(for: .contacts, completionHandler: { (granted, error) in
                if let error = error {
                    print("Contact Store caused an error: \(error)")
                }
                if granted {
                    print("We've been granted access")
                } else {
                    //Disable UI
                    print("Access Denied")
                    DispatchQueue.main.async {
                        //disable search and add contact button
                        
                    }
                }
            })
        } else if status == .restricted || status == .denied {
            //disable UI
        } else if status == .authorized {
            print("Granted")
        }
    }
    
    //Function checks to see if the user has an email account and can send email
    func requestAccessToMail() {
        if MFMailComposeViewController.canSendMail() {
            accessToMail = true
        } else {
            accessToMail = false
        }
    }
    
    //Function that will bring up compose mail view controller
    //If user has an email account
    func mailToRecipient(email: String) {
        if accessToMail {
            let composer = MFMailComposeViewController()
            composer.setToRecipients([email])
            composer.mailComposeDelegate = self
            present(composer, animated: true, completion: nil)
        }
    }
    
    //MARK: - IBActions
    
    //When new contact button is pressed
    //Display ContactViewController
    //Allow user to create a new contact
    @IBAction func newContact(_ sender: UIBarButtonItem) {
        let newCon = CNContactViewController(forNewContact: nil)
        newCon.delegate = self
        newCon.contactStore = contactStore
        let nav = UINavigationController(rootViewController: newCon)
        present(nav, animated: true, completion: nil)
    }
    //When search button is pressed
    //Display ContactPickerViewController
    //Allow user to search through their contact list
    @IBAction func searchContacts(_ sender: UIBarButtonItem) {
        let newCon = CNContactPickerViewController()
        newCon.delegate = self
        present(newCon, animated: true, completion: nil)
    }
    

    //MARK: - CNContactViewControllerDelegate
    //Dismiss the ContactViewController when they have completed using it
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - CNContactPickerDelegate
    
    //Handle what happens when user clicks on an email address
    //In the ContactPickerViewController
    //Call mailToRecipient function
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        if contactProperty.key == "emailAddresses" {
            if let email = contactProperty.value as? String {
                dismiss(animated: true, completion: nil)
                mailToRecipient(email: email)
                selectedEmail = email
            }
        }
    }
    
    //MARK: - MFMailComposeViewControllerDelegate
    
    //Handle what happens when a user finished composing an email
    //If the result is sent, then sent the email
    //Add the email data to the tableview
    //Reload tableview data
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print("Mail compose failed with error: \(error)")
            return
        }
        if result == .sent {
            //add email address or first/last name and time stamp to data model
            let email = sentEmail(emailAddress: selectedEmail!)
            if sentEmails == nil {
                sentEmails = [email]
            } else {
                sentEmails?.insert(email, at: 0)
            }
            tableView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
}

