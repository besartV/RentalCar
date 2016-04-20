//
//  BookingCellViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 19/04/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation
import UIKit

class BookingCellViewController: UITableViewCell {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var car: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var dates: UILabel!
    @IBOutlet weak var prices: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}