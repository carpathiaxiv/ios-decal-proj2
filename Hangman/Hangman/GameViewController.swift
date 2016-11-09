//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//
import UIKit
import Foundation

var deathCount=0
var myPhrase=String()
var incorrectGuesses=[String]()
var underscores=""
class GameViewController: UIViewController {
    func replace(myString: String, index: Int, newChar: Character) -> String {
        var chars = Array(myString.characters)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    @IBAction func startOver(_ sender: AnyObject) {
        incorrectGuesses=[String]()
        underscores=""
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        myPhrase=phrase!
        printUnderScores(phrase!)
        self.incorrectLabel.text="Incorrect guesses thus far: "
        UserGuess.isUserInteractionEnabled = true
        UserGuess.text=""
        guessButton.isEnabled=true
        img1.isHidden=false
        img2.isHidden=true
        img3.isHidden=true
        img4.isHidden=true
        img5.isHidden=true
        img6.isHidden=true
        img7.isHidden=true
        deathCount=0
    }
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var incorrectLabel: UILabel!
    func checkWin(){
        if underscores.range(of:"_") == nil{
            let alertController = UIAlertController(title: "Congrats!", message:
                "You Won!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            UserGuess.isUserInteractionEnabled = false
            guessButton.isEnabled=false
        }
    }
    @IBAction func Guess(_ sender: AnyObject) {
        
        
        if UserGuess.text!.characters.count>1 || UserGuess.text!.uppercased() != UserGuess.text!{
            let alertController = UIAlertController(title: "Gentle Reminder", message:
                "Please input one upper case letter and hit Guess", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else{
            if myPhrase.range(of :UserGuess.text!) != nil{
                print("succeed")
                for index in 0..<myPhrase.characters.count{
                    if myPhrase[myPhrase.index(myPhrase.startIndex, offsetBy: index)]==Character(UserGuess.text!){
                        underscores=replace(myString: underscores, index: index*2, newChar: Character(UserGuess.text!))
                    }
                }
                checkWin()
            }else{
                deathCount+=1
                if deathCount==1{
                    img2.isHidden=false
                    img1.isHidden=true
                }
                if deathCount==2{
                    img3.isHidden=false
                    img2.isHidden=true
                }
                if deathCount==3{
                    img4.isHidden=false
                    img3.isHidden=true
                }
                if deathCount==4{
                    img5.isHidden=false
                    img4.isHidden=true
                }
                if deathCount==5{
                    img6.isHidden=false
                    img5.isHidden=true
                }
                if deathCount==6{
                    img7.isHidden=false
                    img6.isHidden=true
                    let alertController = UIAlertController(title: "Sorry!", message:
                        "You Lost!", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    UserGuess.isUserInteractionEnabled = false
                    guessButton.isEnabled=false

                }
                incorrectGuesses.append(UserGuess.text!)
                self.incorrectLabel.text=self.incorrectLabel.text!+" "+UserGuess.text!
            }
        }
        print (incorrectGuesses)
        print (myPhrase)
        
        self.underscoreLabel.text=underscores
        
    }
    @IBOutlet weak var underscoreLabel: UILabel!
    @IBOutlet weak var UserGuess: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        myPhrase=phrase!
        printUnderScores(phrase!)
        print(phrase)
        img1.isHidden=false
        img2.isHidden=true
        img3.isHidden=true
        img4.isHidden=true
        img5.isHidden=true
        img6.isHidden=true
        img7.isHidden=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printUnderScores(_ phrase: String){
        
        for i in phrase.characters{
            if i==" "{
                underscores+="  "
            }else{
                underscores+="_ "
            }
        }
        self.underscoreLabel.text=underscores
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
