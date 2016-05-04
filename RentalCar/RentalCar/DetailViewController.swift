//
//  DetailViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 13/04/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    var car: Car?
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var sits: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.text = self.car!.model + " - " + self.car!.type
        self.detailTitle.text = self.car!.model + " - " + self.car!.type
        self.price.text = String(self.car!.price) + "/day"
        self.color.text = self.car!.color
        self.desc.text = self.car!.desc
        self.sits.text = String(self.car!.sits)
        self.fuel.text = self.car!.fuel
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityIndicator.center = self.picture.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            print("download image....")
            print(Global.APP_STORAGE + "/" + (self.car?.picture)!)
            if Util.isConnectedToNetwork() {
                request(.GET, Global.APP_STORAGE + "/" + (self.car?.picture)!).responseData { (response) in
                    if response.response?.statusCode == 200 {
                        if response.result.error == nil {
                            dispatch_async(dispatch_get_main_queue(),{
                                self.picture.image = UIImage(data: response.result.value!)
                                activityIndicator.stopAnimating()
                            })
                        } else {
                            print(response.result.error!.debugDescription)
                        }
                    } else {
                        print(response.result.error!.debugDescription)
                    }
                }
            }
        });
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func bookAction(sender: AnyObject) {
        print("BOOK ...")
        if Util.isConnectedToNetwork() {
            let pvc: ProgressViewController = ProgressViewController()
            pvc.showActivityIndicator(self.view)
            print(self.car!.from)
            request(.POST, Global.APP_URL + "/booked", parameters: [
                "from": self.car!.from,
                "to": self.car!.to,
                "user_id": Global.user_id,
                "car_id": self.car!.id
                ], headers: ["X-CSRF-TOKEN": Global.token]).responseJSON { (response) in
                    print(response)
                    pvc.hideActivityIndicator()
                    if response.response?.statusCode == 200 {
                        //Util.alert(self, title: "RentalCar", message: "Congratulation, you are booked a car!")
                        let alert = UIAlertController(title: "RentalCar", message:"Congratulation, you are booked a car!", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                            print("EZDZEDZD")
                            self.navigationController?.popToRootViewControllerAnimated(true)//.popViewControllerAnimated(true)
                            })
                        self.presentViewController(alert, animated: true){}

                    } else {
                        Util.alert(self, title: "RentalCar", message: "An error has occurred: \(response.result.error!.debugDescription)")
                                            }
                    //
            }
        } else {
            Util.alert(self, title: "Internet Network", message: "Please turn on your 3G or WIFI")
        }
    }
}