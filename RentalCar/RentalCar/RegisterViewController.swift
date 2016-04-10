//
//  RegisterViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 28/03/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import Alamofire

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputAddress: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword1: UITextField!
    @IBOutlet weak var inputPassword2: UITextField!
    @IBOutlet weak var signup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputEmail.delegate = self
        self.inputName.delegate = self
        self.inputPassword1.delegate = self
        self.inputPassword2.delegate = self
        
        self.signup.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case self.inputName:
            self.inputAddress.becomeFirstResponder()
        case self.inputAddress:
            self.inputEmail.becomeFirstResponder()
        case self.inputEmail:
            self.inputPassword1.becomeFirstResponder()
        case self.inputPassword1:
            self.inputPassword2.becomeFirstResponder()
        case self.inputPassword2:
            self.signUp(self)
        default:
            print("default")
            break
        }
        
        return true
    }
    
    //MARK: Actions
    @IBAction func signUp(sender: AnyObject) {
        autoreleasepool { 
            print("signUp")
            if self.inputName.text == "" || self.inputEmail.text == "" || self.inputPassword1.text == "" || self.inputPassword2.text == "" || self.inputAddress.text == "" {
                Util.alert(self,title: "Register Failed!", message: "Please put all information")
            } else if !self.isValidEmail(self.inputEmail.text!){
                Util.alert(self,title: "Register Failed!", message: "Please put a valid email")
            } else if self.inputPassword1.text != self.inputPassword2.text {
                Util.alert(self,title: "Register Failed!", message: "Please the passwords have to be the same!")
            } else {
                //Request...
                print("Registration...")
                let vc = ProgressViewController()
                vc.setLabelActivity("Checking information...")
                vc.showActivityIndicator(self.view)
                
                request(.POST, Global.APP_URL + "/register", parameters:
                    [
                        "name": self.inputName.text!,
                        "address": self.inputAddress.text!,
                        "email": self.inputEmail.text!,
                        "password": self.inputPassword1.text!
                    ]).responseJSON(completionHandler: { (response) in
                        print("RESPONSE :: \(response)")
                        vc.hideActivityIndicator()
                        if response.result.error == nil {
                            print(response.result.value)
                            if response.response?.statusCode == 200 {
                                self.performSegueWithIdentifier("AppSegue", sender: nil)
                            } else {
                                Util.alert(self, title: "Sign up", message: response.result.value!["error"] as! String)
                            }
                        } else {
                            Util.alert(self, title:"Sign up", message: response.result.error!.debugDescription)
                        }
                    })
            }
        }
    }
    
    @IBAction func exit(sender: AnyObject) {
        print("OKOK")
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    //MARK: util
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }
    
}
