//
//  ProgressViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 06/04/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit

class ProgressViewController {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var labelInfo : UILabel = UILabel()
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = Util.UIColorFromHex(0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRectMake(0, 0, 240, 150)
        loadingView.center = CGPoint(x: uiView.frame.width/2, y: uiView.frame.height/3)
        loadingView.backgroundColor = Util.UIColorFromHex(0x444444, alpha: 0.9)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height / 2);
        activityIndicator.transform = CGAffineTransformMakeScale(1.3, 1.3);
        
        labelInfo.frame = CGRectMake(0.0, 0.0, loadingView.frame.size.width, 20.0);
        labelInfo.center = CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height/1.2);
        labelInfo.textAlignment = NSTextAlignment.Center
        labelInfo.font = UIFont.boldSystemFontOfSize(20.0)
        labelInfo.textColor = UIColor.whiteColor()
        
        loadingView.addSubview(activityIndicator)
        loadingView.addSubview(labelInfo)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func setLabelActivity(s : String){
        labelInfo.text = s
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
}