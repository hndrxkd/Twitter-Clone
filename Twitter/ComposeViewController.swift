//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Kevin Denis on 11/5/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextField!
    @IBOutlet weak var userProfileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        

        // Do any additional setup after loading the view.
    }
         
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweet(_ sender: Any) {
        if(!tweetTextView.text!.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text!, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                print("\(Error)")
            })
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
