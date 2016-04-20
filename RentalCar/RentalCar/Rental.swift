//
//  Rental.swift
//  RentalCar
//
//  Created by Ysée Monnier on 19/04/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation

class Rental {
    var from: String
    var to: String
    var car: String
    var location: String
    var priceDay: Double
    var days: Int
    var totalPrice: Double {
        get {
            return priceDay * Double(days)
        }
    }
    
    init(dateFrom: String, dateTo: String, car: String, location: String, price: Double, days: Int) {
        self.from = dateFrom
        self.to = dateTo
        self.car = car
        self.location = location
        self.priceDay = price
        self.days = days
    }
}