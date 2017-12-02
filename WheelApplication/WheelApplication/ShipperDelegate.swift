//
//  ShipperDelegate.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 12/1/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

@objc protocol ShipperDelegate {
    func didCallOrderer(phoneNumber:String)
    @objc optional func didSavePost(post:Post, sender:UIButton)
}
