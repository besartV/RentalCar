//
//  Car.swift
//  RentalCar
//
//  Created by Ysée Monnier on 12/04/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import Foundation

class Car {
    var id: Int
    var model: String
    var type: String
    var desc: String
    var color: String
    var fuel: String
    var sits: Int
    var price: Double
    var picture: String
    var location_id: Int
    var from: String
    var to: String
    
    init(id: Int, model: String, type: String, description: String, color: String, fuel: String, sits: Int, price: Double, picture: String, loc_id: Int, from: String, to: String) {
        self.id = id
        self.from = from
        self.to = to
        self.model = model
        self.type = type
        self.desc = description
        self.color = color
        self.fuel = fuel
        self.sits = sits
        self.price = price
        self.picture = picture
        self.location_id = loc_id
    }
}