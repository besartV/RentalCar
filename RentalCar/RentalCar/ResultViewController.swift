//
//  ResultViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 12/04/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ResultViewController: UITableViewController {
    
    var cars: [Car]?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("cars")
        print(cars)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            print("SEGUE HERE")
            print(self.index)
            let destinationVC: DetailViewController = segue.destinationViewController as! DetailViewController
            destinationVC.car = self.cars![self.index!]
        }
    }
    
    
    
    //MARK: TableView Delegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.cars?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CarCellViewController = tableView.dequeueReusableCellWithIdentifier("CarCell") as! CarCellViewController
        let car: Car = self.cars![indexPath.row]
        cell.model.text = car.model + " - " + car.type
        cell.price.text = "\(car.price)€/day"
        cell.sits.text = String(car.sits)
        cell.picturePath = car.picture
        cell.downloadImage()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("select row \(indexPath.row)")
        self.index = indexPath.row
        self.performSegueWithIdentifier("DetailSegue", sender: self)
    }
}