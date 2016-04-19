//
//  BookingViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 19/04/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class BookingViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Navigation Controller
    
    @IBAction func backButton(sender: AnyObject) {
        print("TEST...")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: TableView Delegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //MARK: Data
    
    private func loadData() {
        print("BOOKING.......")
        print("URL :: \(Global.APP_URL + "/booking")")
        
        request(.GET, Global.APP_URL + "/booking", parameters: ["token": Global.token],headers: ["X-CSRF-TOKEN": Global.token]).responseJSON { (response) in
            print("RESPONSE :: \n\(response)")
            if response.response?.statusCode == 200 {
                let json: JSON = JSON(response.result.value!)
                print(json)
            }
        }
    }
}