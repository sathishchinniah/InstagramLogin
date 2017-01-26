//
//  ViewController.swift
//  InstagramLogin
//
//  Created by Sathish Chinniah on 25/01/17.
//  Copyright © 2017 Sathish chinniah. All rights reserved.
//

import UIKit

class HomeController: UIViewController,WebLoginControllerDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    let loadingView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        contentView.isHidden = true
        btnLogin.setTitleColor(UIColor.blue, for: UIControlState())
        loadingView.activityIndicatorViewStyle = .whiteLarge
        loadingView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        loadingView.color = UIColor.black
        self.view.addSubview(loadingView)
    }
    

    @IBAction func loginTap(_ sender: AnyObject) {
        
        if btnLogin.tag == 0 {
        
        self.performSegue(withIdentifier: "Login", sender: self)
            
        }
        
        else {
            
            btnLogin.setTitle("Login", for: UIControlState())
            btnLogin.setTitleColor(UIColor.blue, for: UIControlState())
            btnLogin.tag = 0
            contentView.isHidden = true
            let storage = HTTPCookieStorage.shared
            for cookie in storage.cookies! {
                storage.deleteCookie(cookie)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destVC = segue.destination as? WebLoginController {
            
            destVC.delegate = self
        
        }
    }
    
    
    //MARK: - WebLoginController Delegate
    func webLoginController(didFinishLogin userDict: NSDictionary) {
        
        if userDict.count > 0 {
            
            contentView.isHidden = false
            lblFullName.text = userDict["full_name"] as? String
            lblLastName.text = userDict["username"] as? String
            lblFirstName.text = ""
            lblEmail.text = ""
            let picture = userDict["profile_picture"] as? String
            let pictureUrl = URL(string: picture!)!
            if let data = try? Data(contentsOf: pictureUrl) {
                
                self.imageView.image = UIImage(data: data)
            }
            
            btnLogin.tag = 1
            btnLogin.setTitle("Logout", for: UIControlState())
            btnLogin.setTitleColor(UIColor.red, for: UIControlState())
            
            
        }
    }

}

