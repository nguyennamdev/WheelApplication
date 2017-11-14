//
//  Address.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/14/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class Address{
    var name:String
    var city:String
    var state:String
    var country:String
    var street:String
    
    init() {
        self.name = ""
        self.city = ""
        self.state = ""
        self.country = ""
        self.street = ""
    }
    
    init(name:String,street:String, city:String, state:String , country:String) {
        self.name = name
        self.street = street
        self.city = city
        self.state = state
        self.country = country
    }
}
