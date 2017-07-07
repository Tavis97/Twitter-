//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tavis Thompson on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//
protocol ComposeViewControllerDelegate: class {
    
    func did(post: Tweet)
    
}

import UIKit
import RSKPlaceholderTextView
import AlamofireImage

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    var user: User = User.current!
    
//
           //
    
//        }
//    }
    
    weak var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var ProfileImage: UIImageView!
 
    @IBOutlet weak var CompsoeTextView: RSKPlaceholderTextView!
    @IBOutlet weak var TweetCountLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
      CompsoeTextView.delegate = self
    ProfileImage.af_setImage(withURL: URL(string: user.profileImage)! )
    ProfileImage.layer.borderWidth = 0
    ProfileImage.layer.masksToBounds = false
    ProfileImage.layer.cornerRadius = ProfileImage.frame.height/2
    ProfileImage.clipsToBounds = true
        
    
    
        // Change the place holder so the user can tap the inside of the area
    }

    func textViewDidChange(_ ComposeTextView: UITextView) {
        let text = ComposeTextView.text!
        let newcount = 140 - CompsoeTextView.text.characters.count
        TweetCountLabel.text = String(newcount)
        if newcount <= 20 {
            TweetCountLabel.textColor = UIColor.red
        }else{
            TweetCountLabel.textColor = UIColor.gray
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func XonTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapTweet(_ sender: Any) {
        print("The tweet text is: \(CompsoeTextView.text)")
        APIManager.shared.composeTweet(with: CompsoeTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                //self.performSegue(withIdentifier: "TimelineViewController", sender: nil)
                print("Compose Tweet Success!")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    /*
//
//    */

