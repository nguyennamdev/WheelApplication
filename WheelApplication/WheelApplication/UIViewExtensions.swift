//
//  UIViewExtensions.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/6/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

extension UIView{
    func anchorWithConstants(top:NSLayoutYAxisAnchor?, left:NSLayoutXAxisAnchor? , bottom:NSLayoutYAxisAnchor? , right:NSLayoutXAxisAnchor? , topConstant : CGFloat = 0, leftConstant:CGFloat = 0, bottomConstant:CGFloat = 0, rightConstant:CGFloat = 0){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let topViewAnchor = top{
            topAnchor.constraint(equalTo: topViewAnchor, constant: topConstant).isActive = true
        }
        if let bottomViewAnchor = bottom{
            bottomAnchor.constraint(equalTo: bottomViewAnchor, constant: -bottomConstant).isActive = true
        }
        if let leftViewAnchor = left{
            leftAnchor.constraint(equalTo: leftViewAnchor, constant: leftConstant).isActive = true
        }
        if let rightViewAnchor = right
        {
            rightAnchor.constraint(equalTo: rightViewAnchor, constant: -rightConstant).isActive = true
        }
    }
    
    func anchorWithWidthHeightConstant(top:NSLayoutYAxisAnchor?, left:NSLayoutXAxisAnchor? , bottom:NSLayoutYAxisAnchor? , right:NSLayoutXAxisAnchor? , topConstant : CGFloat = 0, leftConstant:CGFloat = 0, bottomConstant:CGFloat = 0, rightConstant:CGFloat = 0, widthConstant:CGFloat = 0, heightConstant:CGFloat = 0){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let topViewAnchor = top{
            topAnchor.constraint(equalTo: topViewAnchor, constant: topConstant).isActive = true
        }
        if let bottomViewAnchor = bottom{
            bottomAnchor.constraint(equalTo: bottomViewAnchor, constant: -bottomConstant).isActive = true
        }
        if let leftViewAnchor = left{
            leftAnchor.constraint(equalTo: leftViewAnchor, constant: leftConstant).isActive = true
        }
        if let rightViewAnchor = right
        {
            rightAnchor.constraint(equalTo: rightViewAnchor, constant: -rightConstant).isActive = true
        }
        
        if widthConstant > 0{
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
        if heightConstant > 0
        {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
    }
    
  
    func anchorWithCenter(centerY:NSLayoutYAxisAnchor?, centerX:NSLayoutXAxisAnchor?, centerYContant:CGFloat = 0, centerXContant:CGFloat = 0){
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = centerY{
            centerYAnchor.constraint(equalTo: centerY, constant:centerYContant).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX ,constant:centerXContant).isActive = true
        }
    }
    
    

}
