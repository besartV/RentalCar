//
//  Util.swift
//  RentalCar
//
//  Created by Ysée Monnier on 27/03/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit

class Util: NSObject {
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    static func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    /**
     *  Function which display a alert
     */
    static func alert(viewController : UIViewController, title : String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}