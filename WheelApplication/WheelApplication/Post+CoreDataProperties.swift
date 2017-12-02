//
//  Post+CoreDataProperties.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 12/2/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var addressDestination: String?
    @NSManaged public var addressStart: String?
    @NSManaged public var date: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var isShipper: Bool
    @NSManaged public var latitudeEnd: Double
    @NSManaged public var latitudeStart: Double
    @NSManaged public var longtitudeEnd: Double
    @NSManaged public var longtitudeStart: Double
    @NSManaged public var phoneOrderer: String?
    @NSManaged public var phoneReceiver: String?
    @NSManaged public var postId: String?
    @NSManaged public var prepayment: Double
    @NSManaged public var price: Double
    @NSManaged public var isSave: Bool
    @NSManaged public var address: Address?
    @NSManaged public var user: User?

}
