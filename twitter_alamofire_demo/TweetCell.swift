//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var NameLabel: UILabel!
   
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        
        didSet {
            
            profileImage.layer.borderWidth = 0
            profileImage.layer.masksToBounds = false
            profileImage.layer.cornerRadius = profileImage.frame.height/2
            profileImage.clipsToBounds = true
            
            profileImage.af_setImage(withURL: URL(string:tweet.user.profileImage)!)
            tweetTextLabel.text = tweet.text
            NameLabel.text = tweet.user.name
            UsernameLabel.text = "@" + tweet.user.screen_name
            DateLabel.text = tweet.createdAtString
            retweetCountLabel.text = String(tweet.retweetCount)
            favoriteCountLabel.text = String(describing: tweet.favoriteCount!)
            
        }
    }
    
    @IBAction func didRetweetPress(_ sender: Any) {
        if retweetButton.isSelected {
            retweetButton.isSelected = false
        } else {
            retweetButton.isSelected = true
        }
    }
    

    @IBAction func didFavPress(_ sender: Any) {
        if favoriteButton.isSelected{
        favoriteButton.isSelected = false
        
    } else {
        favoriteButton.isSelected = true
    }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
