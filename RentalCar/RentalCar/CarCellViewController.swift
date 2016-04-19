//
//  CarCellViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 13/04/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import QuartzCore

class CarCellViewController: UITableViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var sits: UILabel!
    @IBOutlet weak var model: UILabel!
    var picturePath: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func downloadImage() {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.layer.zPosition = 1000
        activityIndicator.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.center = self.picture.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        print("download image....")
        print(Global.APP_STORAGE + "/" + self.picturePath)
        if Util.isConnectedToNetwork() {
            request(.GET, Global.APP_STORAGE + "/" + self.picturePath).responseData { (response) in
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
    }
}