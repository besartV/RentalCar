//
//  HomeViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 23/03/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var userMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menu.target = revealViewController()
            menu.action = #selector(SWRevealViewController.revealToggle(_:))
            
            revealViewController().rightViewRevealWidth = 150
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.navigationController!.navigationBar.barTintColor = Util.UIColorFromHex(0x4E83AA)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userMenu(sender: AnyObject) {
        if !Global.auth {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let noUserMenuViewController: NoUserPopoverViewController = storyboard.instantiateViewControllerWithIdentifier("NoUserPopover") as! NoUserPopoverViewController
            
            noUserMenuViewController.modalPresentationStyle = .Popover
            
            let popoverMenuViewController = noUserMenuViewController.popoverPresentationController
            popoverMenuViewController?.permittedArrowDirections = .Any
            popoverMenuViewController?.delegate = self
            popoverMenuViewController?.barButtonItem = sender as! UIBarButtonItem
            
            self.presentViewController(noUserMenuViewController, animated: true, completion: nil)
        } else {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let userMenuViewController: UserPopoverViewController = storyboard.instantiateViewControllerWithIdentifier("UserPopover") as! UserPopoverViewController
            
            userMenuViewController.modalPresentationStyle = .Popover
            
            let popoverMenuViewController = userMenuViewController.popoverPresentationController
            popoverMenuViewController?.permittedArrowDirections = .Any
            popoverMenuViewController?.delegate = self
            popoverMenuViewController?.barButtonItem = sender as! UIBarButtonItem
            
            self.presentViewController(userMenuViewController, animated: true, completion: nil)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle{
        return .None
    }
}