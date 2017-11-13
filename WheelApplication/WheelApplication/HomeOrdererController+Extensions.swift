//
//  HomeOrdererController+Extensions.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/13/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit


extension HomeOrdererController{
    // animate
    func entryAddressAnimate(option:UIViewAnimationOptions,  heightContraint entry:CGFloat,  heignContraint address: CGFloat ,isHidden: Bool){
        entryViewHeightContraint?.constant = entry
        addressSegmentHeightConstaint?.constant = address
        addressSegmentControl.isHidden = isHidden
        UIView.animate(withDuration: 0.5, delay: 0, options: option, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func handleHeightBottomEntryContainerKeyboardShowing(notification:Notification){
        if let userInfo = notification.userInfo{
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            bookButtonBottomContaint?.constant = -(keyboardFrame.height - bottomLayoutGuide.length + 8)
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    func handleHeightBottomEntryContainerKeyboardHide(){
        bookButtonBottomContaint?.constant = -8
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// setup views
extension HomeOrdererController{
    
    func entryViewSetupViews(){
        entryViewContainner.addSubview(startAddressTextField)
        entryViewContainner.addSubview(endAddressTextField)
        entryViewContainner.addSubview(addressSegmentControl)
        entryViewContainner.addSubview(startAddressImage)
        entryViewContainner.addSubview(endAddressImage)
        
        // set contraint
        addressSegmentControl.anchorWithConstants(top: entryViewContainner.topAnchor, left: entryViewContainner.leftAnchor, bottom: nil, right: entryViewContainner.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12)
        addressSegmentHeightConstaint = NSLayoutConstraint(item: addressSegmentControl, attribute: .height, relatedBy: .equal , toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        entryViewContainner.addConstraint(addressSegmentHeightConstaint!)
        
        startAddressImage.anchorWithWidthHeightConstant(top: addressSegmentControl.bottomAnchor, left: entryViewContainner.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        
        endAddressImage.anchorWithWidthHeightConstant(top: startAddressTextField.bottomAnchor, left: entryViewContainner.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        
        startAddressTextField.anchorWithConstants(top: addressSegmentControl.bottomAnchor, left: startAddressImage.rightAnchor, bottom: nil, right: entryViewContainner.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 12)
        startAddressTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        endAddressTextField.anchorWithConstants(top: startAddressTextField.bottomAnchor, left: endAddressImage.rightAnchor, bottom: nil, right: entryViewContainner.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 12)
        endAddressTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
    func bottomEntrySetupViews(){
        bottomEntryViewContainer.addSubview(prepaymentTextField)
        bottomEntryViewContainer.addSubview(phoneReceiverTextField)
        bottomEntryViewContainer.addSubview(priceTextField)
        bottomEntryViewContainer.addSubview(descriptionTextField)
        bottomEntryViewContainer.addSubview(prepaymentImageView)
        bottomEntryViewContainer.addSubview(priceImageView)
        bottomEntryViewContainer.addSubview(callImageView)
        bottomEntryViewContainer.addSubview(descriptionImageView)
        
        
        prepaymentTextField.anchorWithConstants(top: bottomEntryViewContainer.topAnchor, left: prepaymentImageView.rightAnchor, bottom: nil, right: bottomEntryViewContainer.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 12)
        prepaymentTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        priceTextField.anchorWithConstants(top: prepaymentTextField.bottomAnchor, left: priceImageView.rightAnchor, bottom: nil, right: bottomEntryViewContainer.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 12)
        priceTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        phoneReceiverTextField.anchorWithConstants(top: priceTextField.bottomAnchor, left: callImageView.rightAnchor, bottom: nil, right: bottomEntryViewContainer.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 12)
        phoneReceiverTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        descriptionTextField.anchorWithConstants(top: phoneReceiverTextField.bottomAnchor, left: descriptionImageView.rightAnchor, bottom: nil, right: bottomEntryViewContainer.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 12)
        descriptionTextField.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        prepaymentImageView.anchorWithWidthHeightConstant(top: bottomEntryViewContainer.topAnchor, left: bottomEntryViewContainer.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        
        priceImageView.anchorWithWidthHeightConstant(top: prepaymentImageView.bottomAnchor, left: bottomEntryViewContainer.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        callImageView.anchorWithWidthHeightConstant(top: priceImageView.bottomAnchor, left: bottomEntryViewContainer.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        descriptionImageView.anchorWithWidthHeightConstant(top: callImageView.bottomAnchor, left: bottomEntryViewContainer.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
    }
}

