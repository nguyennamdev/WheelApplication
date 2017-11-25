//
//  Address+CoreDataProperties.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/20/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var name: String?
    @NSManaged public var state: String?
    @NSManaged public var street: String?

}
