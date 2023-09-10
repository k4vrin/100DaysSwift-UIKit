//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Mostafa Hosseini on 9/4/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var scoreTxt: UITextView!
    
    @IBOutlet var sdasd: UITextView!
    var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(rewindTapped))
        
        scoreTxt.text = "Score: \(score)"
        askQuestion()
    }
    
    @objc func rewindTapped() {
        let message = "Your score is \(score)"
        let ac = UIAlertController(title: "Score", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in}))
        
        present(ac, animated: true)
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        questionsAsked += 1
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        scoreTxt.text = "Score: \(score)"
        
        if questionsAsked >= 10 {
            let ac = UIAlertController(title: "Game finnished", message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: { action in
                self.score = 0
                self.questionsAsked = 0
                self.scoreTxt.text = "Score: \(self.score)"
                self.askQuestion()
                
            }))
            
            present(ac, animated: true)
        } else {
            let message = title == "Wrong" ? "Wrong! That's the flag of \(countries[sender.tag].capitalized)" : "Your score is \(score)"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        }
    }
    
    
    
}

