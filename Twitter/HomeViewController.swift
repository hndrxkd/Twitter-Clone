//
//  HomeViewController.swift
//  Twitter
//
//  Created by Kevin Denis on 11/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numTweets: Int!
    let refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadTweets()
        refreshController.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = refreshController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.loadTweets()
    }
    
    @objc func loadTweets(){
        numTweets = 20
       
        let URL  = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": numTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: URL, parameters: params as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.refreshController.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not retrieve Tweets")
        })
        
    }
    
    
    func loadMoreTweets(){
        
    numTweets += 20
        
         let URL  = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": numTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: URL, parameters: params as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Could not retrieve Tweets")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    
    

    @IBAction func onLogOutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "loggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    
    func configure_button(){
        
    }


    func loadImage(user: NSDictionary , cell: tweetCell){
    
        var profilePicAddress = user["profile_image_url_https"] as? String
        
        //removes "normal" from the url to get the original size picture as .jpg
        while profilePicAddress?.last != "_" {
            profilePicAddress?.removeLast()
        }
        profilePicAddress?.removeLast()
        
        profilePicAddress? += ".jpg"
        
        let profilePicURL = URL(string: profilePicAddress!)!
        let data = try? Data(contentsOf: profilePicURL)
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
            cell.profileImageView.layer.masksToBounds = true
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.bounds.width / 2
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell" , for: indexPath) as! tweetCell
        
        let user = tweetArray[indexPath.row]["user"] as? NSDictionary
      
        loadImage(user: user!, cell: cell)
        cell.usernameLabel.text = user?["name"] as? String
        cell.handleLabel.text = user?["screen_name"] as? String
        cell.tweetLabel.text = tweetArray[indexPath.row]["text"] as? String
        cell.tweetID = tweetArray[indexPath.row]["id"] as! Int
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.setRetweet(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        
        return cell
       
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }

}
