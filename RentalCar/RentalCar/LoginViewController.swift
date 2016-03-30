//
//  LoginViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 28/03/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var signin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputEmail.delegate = self
        self.inputPassword.delegate = self
        
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
        if self.inputEmail.text == "" || self.inputPassword.text == "" {
            Util.alert(self,title: "Login Failed!", message: "Please put all information")
        } else if !self.isValidEmail(self.inputEmail.text!) {
            Util.alert(self,title: "Login Failed!", message: "Please put a valid email")
        } else {
            //Request
            
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