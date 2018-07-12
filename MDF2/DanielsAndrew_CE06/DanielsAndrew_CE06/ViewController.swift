//
//  ViewController.swift
//  DanielsAndrew_CE06
//
//  Created by Andrew Daniels on 3/13/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate {

    var session: MCSession!
    var peerID: MCPeerID!
    var browser: MCBrowserViewController!
    var advertiser: MCAdvertiserAssistant!
    
    let serviceID = "RPS-1"
    
    
    @IBOutlet weak var opponentSelectionView: UIView!
    @IBOutlet weak var opponentSelectionLabel: UILabel!
    @IBOutlet weak var playerSelectionView: UIView!
    @IBOutlet weak var playerSelectionLabel: UILabel!
    @IBOutlet weak var rockView: UIView!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperView: UIView!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsView: UIView!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var winsTextField: UITextField!
    @IBOutlet weak var opponentNameTextField: UITextField!
    @IBOutlet weak var lossesTextField: UITextField!
    @IBOutlet weak var tiesTextField: UITextField!
    @IBOutlet weak var startButton: UIBarButtonItem!
    @IBOutlet weak var statusIndicatorLabel: UILabel!
    
    var selectedOption: UIView!
    let main = DispatchQueue.main
    var opponentIsReady = false
    var playerIsReady = false
    var gameOptions = ["Rock", "Paper", "Scissors"]
    var opponentsChoice: String!
    var gameOptionsDict = [5: "Rock", 10: "Paper", 15: "Scissors"]
    var counter = 0
    var timer = Timer()
    var noResponse: Data! = "No Response".data(using: .utf8)
    var playerChoice: String!
    var wins = 0
    var losses = 0
    var ties = 0
    var scoreMessage: String!
    
    
    //Establish peerID for the user
    //Start a session
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        opponentSelectionView.layer.cornerRadius = 5
        playerSelectionView.layer.cornerRadius = 5
        rockView.layer.cornerRadius = 5
        paperView.layer.cornerRadius = 5
        scissorsView.layer.cornerRadius = 5
        
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        
        //Use PeerID to setup a session
        session = MCSession(peer: peerID)
        session.delegate = self
        
        //Setup and start advertising immediately
        advertiser = MCAdvertiserAssistant(serviceType: serviceID, discoveryInfo: nil, session: session)
        advertiser.start()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Whenever the timer is active call this function every second
    @objc func timerAction() {
        counter += 1
        switch (counter) {
        case 1:
        main.async {
            self.statusIndicatorLabel.text = "Rock.."
            }
        case 2:
        main.async {
            self.statusIndicatorLabel.text = "Paper.."
            }
        case 3:
        main.async {
            self.statusIndicatorLabel.text = "Scissors.."
            }
        case 4:
        main.async {
            if let _ = self.selectedOption {
                //do nothing
            } else {
                self.determineWinner()
                self.disableEnableOptionViews()
                self.startButton.isEnabled = true
                return
            }
                self.determineWinner()
                self.startButton.isEnabled = true
                return
            }
        default:
            print("Switch error")
        }
    }
    
    //MARK: - IBActions
    
    //When start button is pressed
    //Mark user as ready
    //Wait for opponent to be ready
    //If opponent was ready before user
    //Start timer and game
    @IBAction func startPress(_ sender: Any) {
        let data = String("Ready").data(using: .utf8)
        if let data = data {
            do { try session.send(data, toPeers: session.connectedPeers, with: .reliable)
                startButton.isEnabled = false
            }
            catch {print("Error sending ready message.")}
        }
        playerIsReady = true
        if let _ = selectedOption {
            selectedOption.layer.borderWidth = 0
            selectedOption = nil
        }
        if !opponentIsReady {
            statusIndicatorLabel.text = "Waiting for opponent.."
        } else {
            //Call counter method that will countdown
            disableEnableOptionViews()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
        opponentSelectionLabel.text = nil
        playerSelectionLabel.text = nil
        //Change label text to waiting for opponent to start
        
        //Once opponent presses start also
        //Make buttons look clickable
        //Then start countdown Rock, Paper, Scissors, SHOOT
        
    }
    //Whenever the player selects rock, paper, or scissors
    //Send their selection to their opponent
    //If both player and opponent have selected their choice, then determine the winner
    @IBAction func playerSelection(_ sender: Any) {
        if playerIsReady && opponentIsReady {
            let selection = sender as! UIButton
            if let selectedView = view.viewWithTag(selection.tag) {
                selectedView.layer.borderWidth = 2
                selectedView.layer.borderColor = UIColor.black.cgColor
                selectedOption = selectedView
                let data = gameOptionsDict[selection.tag]?.data(using: .utf8)
                playerChoice = gameOptionsDict[selection.tag]
                if let data = data {
                    do {try session.send(data, toPeers: session.connectedPeers, with: .reliable)
                        playerSelectionLabel.text = gameOptionsDict[selection.tag]
                        disableEnableOptionViews()
                        if let _ = playerChoice, let _ = opponentsChoice {
                            determineWinner()
                        }
                    }
                    catch {statusIndicatorLabel.text = "Error sending player's move."}
                }
            }
        }
    }
    //When the find opponent button is pressed
    //Launch the browserviewcontroller to allow the player to find and connect to an opponent
    @IBAction func findOpponentPress(_ sender: Any) {
        //Our browser will look for advertisers that share the same serviceID
        browser = MCBrowserViewController(serviceType: serviceID, session: session)
        browser.delegate = self
        present(browser, animated: true, completion: nil)
        
    }
    
    

    //MARK: - MCBrowserViewControllerDelegate
    //Dismiss the viewcontroller when the done button is pressed
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true, completion: nil)
    }
    //dismiss the viewcontroller when the cancel button is pressed
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -  MCSessionDelegate
    
    // Remote peer changed state.
    //Whenever connected to an opponent, let player know the game is ready to be played
    //When disconnected from opponent, let player know
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        if state == .connected {
            main.async {
                self.statusIndicatorLabel.text = "Press Start"
                self.startButton.isEnabled = true
                self.opponentNameTextField.text = peerID.displayName
                self.dismiss(animated: true, completion: nil)
            }
        }
        if state == .notConnected {
            main.async {
                self.statusIndicatorLabel.text = "Find Opponent"
                self.startButton.isEnabled = false
                self.opponentNameTextField.text = "Opponent"
            }
        }
    }
    
    
    // Received data from remote peer.
    //This function handles recieving data from the opponent
    //If the opponent sends his/her choice, check for winner when either time is up or the user pressed their choice, whichever comes first
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let stringData = String(data: data, encoding: .utf8) {
            if gameOptions.contains(stringData) {
                //String Data is the opponents move
                main.async {
                    self.opponentsChoice = stringData
                    //Call function to decide who won.
                    if let _ = self.playerChoice, let _ = self.opponentsChoice {
                        self.determineWinner()
                    }
                    //Function must wait for users answer, or timeout, before displaying anything
                    //
                }
            } else if stringData == "Ready" {
                main.async {
                    self.opponentIsReady = true
                    if self.playerIsReady {
                        self.disableEnableOptionViews()
                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
                    }
                }
            } else {
                main.async {
                    self.opponentsChoice = stringData
                }
            }
        }
    }
    
    
    // Received a byte stream from remote peer.
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    
    // Start receiving a resource from remote peer.
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    
    // Finished receiving a resource from remote peer and saved the content
    // in a temporary location - the app is responsible for moving the file
    // to a permanent location within its sandbox.
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    //This function will disable or enable the views that hold the game choices
    func disableEnableOptionViews() {
        rockView.isUserInteractionEnabled = !rockView.isUserInteractionEnabled
        paperView.isUserInteractionEnabled = !paperView.isUserInteractionEnabled
        scissorsView.isUserInteractionEnabled = !scissorsView.isUserInteractionEnabled
    }
    
    //This function will determine the winner whenever time is up, or when both players selected their choice
    //whichever comes first
    func determineWinner() {
        if let _ = opponentsChoice, let _ = playerChoice {
            opponentSelectionLabel.text = opponentsChoice
            if opponentsChoice == playerChoice {
                ties += 1
                scoreMessage = "You tie!"
                tiesTextField.text = "Ties: " + String(ties)
                resetForNewGame()
                return
            } else if opponentsChoice == "Rock" {
                if playerChoice == "Paper" {
                    wins += 1
                    scoreMessage = "You win!"
                    winsTextField.text = "Wins: " + String(wins)
                    resetForNewGame()
                    return
                }
                if playerChoice == "Scissors" {
                    losses += 1
                    scoreMessage = "You lose :("
                    lossesTextField.text = "Losses: " + String(losses)
                    resetForNewGame()
                    return
                }
            } else if opponentsChoice == "Paper" {
                if playerChoice == "Rock" {
                    losses += 1
                    scoreMessage = "You lose :("
                    lossesTextField.text = "Losses: " + String(losses)
                    resetForNewGame()
                    return
                }
                if playerChoice == "Scissors" {
                    wins += 1
                    scoreMessage = "You win!"
                    winsTextField.text = "Wins: " + String(wins)
                    resetForNewGame()
                    return
                }
            } else if opponentsChoice == "Scissors" {
                if playerChoice == "Rock" {
                    wins += 1
                    scoreMessage = "You win!"
                    winsTextField.text = "Wins: " + String(wins)
                    resetForNewGame()
                    return
                }
                if playerChoice == "Paper" {
                    losses += 1
                    scoreMessage = "You lose :("
                    lossesTextField.text = "Losses: " + String(losses)
                    resetForNewGame()
                    return
                }
            }
        }
        if playerChoice == nil && opponentsChoice == nil {
            playerSelectionLabel.text = "No Response"
            opponentSelectionLabel.text = "No Response"
            losses += 1
            scoreMessage = "Too slow! :("
            lossesTextField.text = "Losses: " + String(losses)
            resetForNewGame()
            return
        }
        if playerChoice == nil {
            losses += 1
            playerSelectionLabel.text = "No Response"
            opponentSelectionLabel.text = opponentsChoice
            scoreMessage = "Too slow! :("
            lossesTextField.text = "Losses: " + String(losses)
            resetForNewGame()
            return
        }
        if opponentsChoice == nil {
            wins += 1
            opponentSelectionLabel.text = "No Response"
            scoreMessage = "You win!"
            winsTextField.text = "Wins: " + String(wins)
            resetForNewGame()
            return
        }
    }
    
    //This function will reset the board and prepare the player for the next game
    func resetForNewGame() {
        timer.invalidate()
        counter = 0
        playerIsReady = false
        opponentIsReady = false
        startButton.isEnabled = true
        opponentsChoice = nil
        playerChoice = nil
        statusIndicatorLabel.text = scoreMessage + " Press Start"
    }

}

