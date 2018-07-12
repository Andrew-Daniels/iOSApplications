//
//  ViewController.swift
//  DanielsAndrew_CE04
//
//  Created by Andrew Daniels on 3/6/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    //Create the IBOutlets and Variables
    var arrayOfImages = [UIImage]()
    var flippedTiles = 0
    var firstTile: Tile?
    var secondTile: Tile?
    var imageViews = [UIImageView]()
    var buttons = [UIButton]()
    var matches = 0
    var images = [#imageLiteral(resourceName: "buttons do"), #imageLiteral(resourceName: "buttons add"), #imageLiteral(resourceName: "buttons feed"), #imageLiteral(resourceName: "buttons skip"), #imageLiteral(resourceName: "buttons cancel"), #imageLiteral(resourceName: "buttons remove"), #imageLiteral(resourceName: "buttons facebook"), #imageLiteral(resourceName: "buttons share"), #imageLiteral(resourceName: "buttons upload upgrade"), #imageLiteral(resourceName: "casino dice"), #imageLiteral(resourceName: "casino token"), #imageLiteral(resourceName: "casino party on"), #imageLiteral(resourceName: "casino horse shoe"), #imageLiteral(resourceName: "chess black pawn"), #imageLiteral(resourceName: "chess white horse"), #imageLiteral(resourceName: "construction earth"), #imageLiteral(resourceName: "construction column"), #imageLiteral(resourceName: "construction helmet"), #imageLiteral(resourceName: "construction bricks"), #imageLiteral(resourceName: "construction asphalt"), #imageLiteral(resourceName: "drawing pen"), #imageLiteral(resourceName: "drawing colors"), #imageLiteral(resourceName: "drawing eraser"), #imageLiteral(resourceName: "drawing eyedropper"), #imageLiteral(resourceName: "drawing large brush"), #imageLiteral(resourceName: "dressup eye"), #imageLiteral(resourceName: "dressup ear"), #imageLiteral(resourceName: "dressup ring"), #imageLiteral(resourceName: "dressup lips"), #imageLiteral(resourceName: "dressup wash"), #imageLiteral(resourceName: "dressup brows"), #imageLiteral(resourceName: "dressup skirt"), #imageLiteral(resourceName: "dressup brush"), #imageLiteral(resourceName: "dressup lipstick"), #imageLiteral(resourceName: "dressup earrings"), #imageLiteral(resourceName: "dressup feminine shoe"), #imageLiteral(resourceName: "elements fire"), #imageLiteral(resourceName: "emoticons good"), #imageLiteral(resourceName: "emoticons crush"), #imageLiteral(resourceName: "emoticons happy"), #imageLiteral(resourceName: "emoticons crying"), #imageLiteral(resourceName: "emoticons glasses"), #imageLiteral(resourceName: "emoticons confused"), #imageLiteral(resourceName: "emoticons little kiss"), #imageLiteral(resourceName: "emoticons broken heart"), #imageLiteral(resourceName: "emoticons crying out loud"), #imageLiteral(resourceName: "emoticons laughing out loud"), #imageLiteral(resourceName: "farm tree"), #imageLiteral(resourceName: "food corn"), #imageLiteral(resourceName: "food grape"), #imageLiteral(resourceName: "food lemon"), #imageLiteral(resourceName: "food garlic"), #imageLiteral(resourceName: "food corn"), #imageLiteral(resourceName: "food banana")]
    var imageViewIndexes = [Int]()
    var imageIndexes = [Int]()
    var counter = 5
    var timer = Timer()
    var background = DispatchQueue(label: "Serial1")
    var main = DispatchQueue.main
    var checkForMatchTimer = Timer()
    var activeGame = false
    var gameTimer = Timer()
    var gameCounter = 0
    var arrayOfViews = [UIView]()
    var moves = 0
    var name = "Default"
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var gameTimerLabel: UILabel!
    
    
    

    //ManagedObjectContext - Our notepad, we write on the notepad, then save the notepad to the device
    //It's our data middleman, between our code and the harddrive.
    var managedObjectContext: NSManagedObjectContext!
    
    //NSEntityDescription - Used to help build our Entity by describing a specific entity from our .xcdatamodel file.
    private var entityDescription: NSEntityDescription!
    
    //NSManagedObject - Used to represent the entity Type 'Leaderboard' that we created in our xcdatamodelid file
    //Use the EntityDescription to help us build the right kind of entity
    //This is where our Data lives, everything else is just setup.
    private var leaderBoard: NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Fill out our EntityDescription
        
        entityDescription = NSEntityDescription.entity(forEntityName: "Leaderboard", in: managedObjectContext)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function will tag all the controls with a integer for a tag
    //This function also adds all the UIViews, Buttons, and ImageViews to separate arrays
    func tagControls() {
        var tag = 0
        let views = self.view.subviews
        for subview in views {
            if subview.subviews.count > 1 {
                arrayOfViews.append(subview)
                if let imageView = subview.subviews[0] as? UIImageView {
                    imageView.tag = tag
                    imageViews.append(imageView)
                }
                if let button = subview.subviews[1] as? UIButton {
                    button.tag = tag
                    buttons.append(button)
                }
                tag += 1
            }
        }
    }
    
    //This function will set a random image to two different imageviews
    //Until all imageViews have an image
    func setImagesArray() {
        var iterations = 0
        while iterations < imageViews.count / 2 {
            let randomImage = images[getRandomNum(imageCount: images.count)]
            imageViews[getRandomNum(imageViewIndex: imageViews.count)].image = randomImage
            imageViews[getRandomNum(imageViewIndex: imageViews.count)].image = randomImage
            iterations += 1
        }
    }
    
    //This function creates a random integer within the scope of the amount of images the image array has
    //Makes sure that integer hasn't already been used previously
    //That way double pictures aren't used
    //return the integer
    func getRandomNum(imageCount: Int) -> Int {
        var randomNumber = Int(arc4random_uniform(
            UInt32(imageCount)))
        while imageIndexes.contains(randomNumber) {
            randomNumber = Int(arc4random_uniform(
                UInt32(imageCount)))
        }
        imageIndexes.append(randomNumber)
        return randomNumber
    }
    //This function creates a random integer within the scope of the amount of imageViews the imageView array has
    //Makes sure that imageView hasn't set an image already, that way imageViews don't get set twice for no reason
    //return the integer
    func getRandomNum(imageViewIndex: Int) -> Int {
        var randomNumber = Int(arc4random_uniform(
            UInt32(imageViewIndex)))
        while imageViewIndexes.contains(randomNumber) {
            randomNumber = Int(arc4random_uniform(
                UInt32(imageViewIndex)))
        }
        imageViewIndexes.append(randomNumber)
        return randomNumber
    }
    
    //IBAction for play button
    //Starts game and timers
    @IBAction func play(_ sender: UIButton) {
        sender.isHidden = true
        tagControls()
        setImagesArray()
        activationSwitchTiles()
        showHideTiles()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        /*let newGameButton = UIAlertAction(title: "New Game", style: .default, handler: { (newGame) in
            self.newGame(self)
        })
        let alert = UIAlertController(title: "Congratulations", message: "You beat the game with a score of \(gameCounter) seconds!", preferredStyle: .alert)
        alert.addAction(newGameButton)
        alert.addTextField(configurationHandler: { (initialsTextField) in
            initialsTextField.placeholder = "Type your Initials"
        })
        present(alert, animated: true, completion: nil)*/
    }
    
    //This timer action starts the countdown for 5 seconds before the user can interact with the cards
    //After timer hits 0, all views are flipped face down.
    @objc func timerAction() {
        counter -= 1
        main.async {
            self.navItem.title = self.counter.description
        }
        if counter == 0 {
            //hide pieces
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.gameTimerAction), userInfo: nil, repeats: true)
            main.async {
                self.showHideTiles()
                self.navItem.title = ""
                self.timer.invalidate()
                self.activeGame = true
                for button in self.buttons {
                    button.isUserInteractionEnabled = true
                }
            }
        }
    }
    //This timer action handles the game time score
    @objc func gameTimerAction() {
        gameCounter += 1
            main.async {
                self.gameTimerLabel.text = String("\(self.gameCounter)s")
            }
    }
    //This timer allows the user to see the second flipped card for a second before they both flip back
    //Also checks for a match between the cards. If there was a match then they card remove themselves from board.
    @objc func checkForMatchTimerAction() {
        counter += 2
        if counter % 2 == 0 {
            //hide pieces
            main.async {
                self.checkForMatchTimer.invalidate()
                self.checkForMatch()
            }
        }
    }
    
    //If a view is clicked then flip the card
    //Check if the card matches the other flipped card if there is one.
    @IBAction func buttonClicked(_ sender: UIButton) {
        flipTile(tag: sender.tag)
    }
    //IBAction for starting a new game
    //Resets timers
    //Makes sure all cards are back on the board
    //Activates all buttons once the game has started
    //Makes sure all images are visible for 5 seconds
    @IBAction func newGame(_ sender: Any) {
        imageViewIndexes = [Int]()
        imageIndexes = [Int]()
        setImagesArray()
        activationSwitchTiles()
        if activeGame {
            for view in arrayOfViews {
                view.isHidden = false
            }
            for imageView in imageViews {
                imageView.isHidden = false
            }
        }
        activeGame = false
        timer.invalidate()
        gameTimer.invalidate()
        gameCounter = 0
        counter = 5
        self.navItem.title = self.counter.description
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
    }
    //This function switches the buttons interaction from on to off or off to on
    func activationSwitchTiles() {
            for button in buttons {
                button.isUserInteractionEnabled = !button.isUserInteractionEnabled
            }
    }
    
    
    //This function shows or hides the cards
    func showHideTiles() {
            for imageView in imageViews {
                imageView.isHidden = !imageView.isHidden
            }
    }
    
    //This function checks the flipped cards for an image match
    //Removes matches from board
    //Flips back cards if there isn't a match
    //Also checks if the game is finished
    func checkForMatch() {
        if let firstTile = firstTile,
            let secondTile = secondTile {
            if firstTile.checkForMatch(image: secondTile.image!) {
                firstTile.view?.isHidden = true
                secondTile.view?.isHidden = true
                matches += 1
            } else {
                firstTile.imageView?.isHidden = true
                secondTile.imageView?.isHidden = true
            }
        }
        firstTile = nil; secondTile = nil; flippedTiles = 0
        if matches == buttons.count / 2 {
            //end game here
            gameTimer.invalidate()
            let storedMoves = moves
            let storedTime = gameCounter.description + "s"
            let newGameButton = UIAlertAction(title: "New Game", style: .default, handler: { (newGame) in
                self.newGame(self)
                //Save the object
                let newScore = NSManagedObject(entity: self.entityDescription, insertInto: self.managedObjectContext)
                newScore.setValue(self.name, forKey: "name")
                newScore.setValue(storedMoves, forKey: "moves")
                newScore.setValue(NSDate(), forKey: "date")
                newScore.setValue(storedTime, forKey: "time")
                //Save context here
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print("Error saving context")
                }
            })
            let alert = UIAlertController(title: "Congratulations", message: "You beat the game with a score of \(gameCounter) seconds!", preferredStyle: .alert)
            alert.addAction(newGameButton)
            alert.addTextField(configurationHandler: { (initialsTextField) in
                initialsTextField.placeholder = "Your name goes here."
                initialsTextField.tag = 5
                initialsTextField.delegate = self
            })
            present(alert, animated: true, completion: nil)
            gameCounter = 0
            matches = 0
            moves = 0
        }
    }
    //This function flips the tiles
    //And makes sure more than 2 tiles aren't flipped at the same time.
    func flipTile(tag: Int) {
        //check how many tiles are flipped
        if flippedTiles < 2 {
            let views = self.view.subviews
            for subview in views {
                if subview.subviews.count > 0 {
                    if let imageView = subview.subviews[0] as? UIImageView {
                        if imageView.tag == tag {
                            if imageView.isHidden != false {
                                imageView.isHidden = !imageView.isHidden
                                flippedTiles += 1
                                if let _ = firstTile {
                                    secondTile = Tile(image: imageView.image!, view: subview, imageView: imageView)
                                } else {
                                    firstTile = Tile(image: imageView.image!, view: subview, imageView: imageView)
                                }
                                if flippedTiles == 2 {
                                    //check for match
                                    moves += 1
                                    self.checkForMatchTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.checkForMatchTimerAction), userInfo: nil, repeats: true)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    //MARK: - UITextField Delegate
    //Set the name variable whenever the user stops editing the name textField
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if let text = textField.text {
            name = text
        }
    }
    //Pass the managedObjectContext to the leaderboardViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lVC = segue.destination as! LeaderboardViewController
        lVC.managedObjectContext = managedObjectContext
    }
}

