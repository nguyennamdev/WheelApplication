//
//  Post+CoreDataClass.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/20/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData


public class Post: NSManagedObject {
    
    func setValueWithDictionary(dictionary:NSDictionary){
        self.postId = dictionary.value(forKey: "postId") as? String
        self.addressStart = dictionary.value(forKey: "addressStart") as? String
        self.addressDestination = dictionary.value(forKey: "addressDestination") as? String
        self.prepayment = (dictionary.value(forKey: "prepayment") as? Double)!
        self.price = (dictionary.value(forKey: "price") as? Double)!
        self.date = dictionary.value(forKey: "date") as? String
        self.phoneReceiver = dictionary.value(forKey: "phoneReceiver") as? String
        self.descriptionText = dictionary.value(forKey: "description") as? String
        self.latitudeStart = dictionary.value(forKeyPath: "locationStart.latitude") as! Double
        self.longtitudeStart = dictionary.value(forKeyPath: "locationStart.longtitude") as! Double
        self.latitudeEnd = dictionary.value(forKeyPath: "locationEnd.latitude") as! Double
        self.longtitudeEnd = dictionary.value(forKeyPath: "locationEnd.longtitude") as! Double
        self.phoneOrderer = dictionary.value(forKey: "phoneOrderer") as? String
    }
}
