//
//  LibraryViewCell.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 12/2/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class LibraryViewCell:ShipperViewCell{
    
    
    override func setupSubViews() {
        addSubview(dividerLine)
        addSubview(actionContainerView)
        addSubview(speratorView)
        addSubview(phoneOrdererLabel)
        actionContainerView.addSubview(callButton)
        
        phoneOrdererLabel.anchorWithConstants(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 8)
        
        dividerLine.topAnchor.constraint(equalTo: descriptionImageView.bottomAnchor, constant: 4).isActive = true
        dividerLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        dividerLine.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
       
        actionContainerView.anchorWithConstants(top: dividerLine.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant:0, rightConstant: 12)
        actionContainerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        callButton.anchorWithConstants(top: actionContainerView.topAnchor, left: actionContainerView.leftAnchor, bottom: actionContainerView.bottomAnchor, right: actionContainerView.rightAnchor)
        
        speratorView.anchorWithConstants(top: actionContainerView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
}
