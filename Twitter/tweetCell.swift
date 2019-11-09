//
//  tweetCell.swift
//  Twitter
//
//  Created by Kevin Denis on 11/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var retweeted:Bool = false
    var favorited:Bool = false
    var tweetID: Int = -1
    
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func retweetButton(_ sender: Any) {
        let toBeRetweeted = !retweeted
        if(toBeRetweeted){
            TwitterAPICaller.client?.retweet(tweetid: tweetID, success: {
                self.setRetweet(true)
            }, failure: { (Error) in
                print("Retweeting failed: \(Error)")
            })
        }else{
            TwitterAPICaller.client?.unretweet(tweetid: tweetID, success: {
                    self.setRetweet(false)
                }, failure: { (Error) in
                 print("Retweeting failed: \(Error)")
                })
        }
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetid: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetid: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    func setFavorite(_ isFavorite:Bool){
        favorited = isFavorite
        if(favorited){
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweet(_ isRetweeted:Bool){
        retweeted = isRetweeted
        if(retweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
        }else{
             retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
        }
    }
    

}
