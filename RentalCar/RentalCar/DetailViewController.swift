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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.text = self.car!.model + " - " + self.car!.type
        self.price.text = String(self.car!.price) + "/day"
        self.color.text = self.car!.color
        self.desc.text = self.car!.desc
        self.sits.text = String(self.car!.sits)
        self.fuel.text = self.car!.fuel
        
    }
    
    override func viewDidAppear(animated: Bool) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            activityIndicator.center = self.picture.center//CGPointMake(self.picture.frame.size.width / 2, self.picture.frame.size.height / 2);
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
            print("download image....")
            print(Global.APP_STORAGE + "/" + (self.car?.picture)!)
            if Util.isConnectedToNetwork() {
                request(.GET, Global.APP_STORAGE + "/" + (self.car?.picture)!).responseData { (response) in
                    if response.response?.statusCode == 200 {
                        if response.result.error == nil {
                            dispatch_async(dispatch_get_main_queue(),{
                                //self.picture.image = UIImage(data: response.result.value!)
                                //activityIndicator.stopAnimating()
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
    }
    
}