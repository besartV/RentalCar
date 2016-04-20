//
//  LoginViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 28/03/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var signin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signin.layer.cornerRadius = 0
        self.inputEmail.delegate = self
        self.inputPassword.delegate = self
        
        self.inputEmail.text = "user@car.com"
        self.inputPassword.text = "secret"
        
        self.signin.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.inputEmail {
            self.inputPassword.becomeFirstResponder()
        } else if textField == self.inputPassword {
            self.signIn(self)
        }
        return true
    }
    
    @IBAction func signIn(sender: AnyObject) {
        print("Sign In Button")
        autoreleasepool { 
            if self.inputEmail.text == "" || self.inputPassword.text == "" {
                Util.alert(self,title: "Login Failed!", message: "Please put all information")
            } else if !self.isValidEmail(self.inputEmail.text!) {
                Util.alert(self,title: "Login Failed!", message: "Please put a valid email")
            } else {
                let vc = ProgressViewController()
                vc.setLabelActivity("Checking information...")
                vc.showActivityIndicator(self.view)
                request(.GET, Global.APP_URL + "/login", parameters: ["email": self.inputEmail.text!, "password": self.inputPassword.text!]).responseJSON(completionHandler: { (response) in
                    print("RESPONSE :: \(response)")
                    vc.hideActivityIndicator()
                    if response.result.error == nil {
                        print(response.result.value)
                        if response.response?.statusCode == 200 {
                            let json = JSON(response.result.value!)
                            print("JSON :::::: \(json)")
                            Global.token = json["token"].stringValue
                            Global.user_id = (json["user"].object).valueForKey("id") as! Int
                            self.performSegueWithIdentifier("AppSegue", sender: nil)
                        } else {
                            Util.alert(self, title: "Sign in", message: response.result.value!["error"] as! String)
                        }
                    } else {
                        Util.alert(self, title: "Sign in", message: response.result.error!.debugDescription)
                    }
                })
            }
        }
    }
    
    @IBAction func exit(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }
}