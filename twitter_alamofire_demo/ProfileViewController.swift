//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tavis Thompson on 7/7/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    var tweets: [Tweet] = []
    var user: User = User.current!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displaynameLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var descriptionTextView: UILabel!


    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        profileImageView.af_setImage(withURL: URL(string: user.profileImage)! )
        backgroundImageView.af_setImage(withURL: URL(string: user.backgroundURL)!)
        profileImageView.layer.borderWidth = 0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        displaynameLabel.text = user.name
        usernameLabel.text = "@" + user.screen_name
        followersCount.text = String(user.followers)
        followingCount.text = String(user.followings)
        descriptionTextView.text = user.description
        
        
        
        
        APIManager.shared.getUserTimeLine (user, completion: { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        })
        
    
    }
    

        // Do any additional setup after loading the view.
    func refreshControlAction (_ refreshControl: UIRefreshControl){
        
        // ... Create the URLRequest `myRequest` ...
        APIManager.shared.getUserTimeLine (user, completion: { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        })
        
        refreshControl.endRefreshing()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
