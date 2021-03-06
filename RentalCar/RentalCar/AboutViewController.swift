//
//  AboutViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 20/04/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            self.menu.target = revealViewController()
            self.menu.action = #selector(SWRevealViewController.revealToggle(_:))
            
            revealViewController().rightViewRevealWidth = 150
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.navigationController!.navigationBar.barTintColor = Util.UIColorFromHex(0x4E83AA)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: user Popover
    @IBAction func userAction(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userMenuViewController: UserPopoverViewController = storyboard.instantiateViewControllerWithIdentifier("UserPopover") as! UserPopoverViewController
        
        userMenuViewController.modalPresentationStyle = .Popover
        
        let popoverMenuViewController = userMenuViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.barButtonItem = sender as! UIBarButtonItem
        
        self.presentViewController(userMenuViewController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle{
        return .None
    }
    
}