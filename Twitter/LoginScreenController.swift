
import UIKit

class LoginScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if(UserDefaults.standard.bool(forKey: "loggedIn")){
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let URL = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: URL, success: {
            
            UserDefaults.standard.set(true, forKey: "loggedIn")
            self.performSegue(withIdentifier: "loginToHome" , sender: self)
            
        }, failure: { (Error) in
            print("Could not login")
        })
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
