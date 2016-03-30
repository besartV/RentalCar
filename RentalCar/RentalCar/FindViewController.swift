//
//  ViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 23/03/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {

    @IBOutlet weak var menu: UIBarButtonItem!
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


}

