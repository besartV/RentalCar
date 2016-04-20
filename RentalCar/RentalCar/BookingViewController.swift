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
    
    var data: [Rental] = []
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
        print("COUNT :: \(self.data.count)")
        return self.data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BookingCellViewController = tableView.dequeueReusableCellWithIdentifier("BookingCell") as! BookingCellViewController
        let rental: Rental = self.data[indexPath.row]
        cell.id.text = "#\(indexPath.row + 1)"
        cell.car.text = rental.car
        cell.location.text = rental.location
        cell.dates.text = rental.days == 1 ? "\(rental.from) - \(rental.to) (\(rental.days) day)" : "\(rental.from) - \(rental.to) (\(rental.days) days)"
        cell.prices.text = "\(rental.priceDay)€/day - \(rental.totalPrice)€"
        return cell
    }
    
    //MARK: Data
    
    private func loadData() {
        autoreleasepool {
            print("BOOKING.......")
            print("URL :: \(Global.APP_URL + "/booking")")
            let pvc: ProgressViewController = ProgressViewController()
            pvc.setLabelActivity("Downloading...")
            pvc.showActivityIndicator(self.view)
            if Util.isConnectedToNetwork() {
                request(.GET, Global.APP_URL + "/booking", parameters: ["token": Global.token],headers: ["X-CSRF-TOKEN": Global.token]).responseJSON { (response) in
                    //print("RESPONSE :: \n\(response)")
                    if response.response?.statusCode == 200 {
                        self.data = []
                        let json: JSON = JSON(response.result.value!)
                        print(json["data"].array)
                        for rental in json["data"].array! {
                            let from: String = rental["from"].stringValue
                            let to: String = rental["to"].stringValue
                            let days: Int = rental["days"].intValue
                            
                            let carProperties = rental["car"].object
                            let model: String = carProperties.valueForKey("model") as! String
                            let type: String = carProperties.valueForKey("type") as! String
                            let price: Double = Double(carProperties.valueForKey("rental_price") as! String)!
                            let car: String = "\(model) - \(type)"
                            
                            let locationProperties = rental["location"].object
                            let place: String = locationProperties.valueForKey("address") as! String
                            let city: String = locationProperties.valueForKey("city") as! String
                            let location: String = "\(place) - \(city)"
                            //print(locationProperties)
                            self.data.append(Rental(dateFrom: from, dateTo: to, car: car, location: location, price: price, days: days))
                        }
                        self.tableView.reloadData()
                        pvc.hideActivityIndicator()
                    } else {
                        pvc.hideActivityIndicator()
                    }
                }
            } else {
                pvc.hideActivityIndicator()
                Util.alert(self, title: "Internet Network", message: "Please turn on your 3G or WIFI")
            }
        }
    }
}