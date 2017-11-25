//
//  HomeOrdererController+Extensions.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/13/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

extension HomeOrdererController{
    // animate
    func handleHeightBottomEntryContainerKeyboardShowing(){
        bookButtonBottomContaint?.constant = -100
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
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
        addressSegmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        startAddressImage.anchorWithWidthHeightConstant(top: addressSegmentControl.bottomAnchor, left: entryViewContainner.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        
        endAddressImage.anchorWithWidthHeightConstant(top: startAddressTextField.bottomAnchor, left: entryViewContainner.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        
        startAddressTextField.anchorWithConstants(top: addressSegmentControl.bottomAnchor, left: startAddressImage.rightAnchor, bottom: nil, right: entryViewContainner.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4)
        startAddressTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        endAddressTextField.anchorWithConstants(top: startAddressTextField.bottomAnchor, left: endAddressImage.rightAnchor, bottom: nil, right: entryViewContainner.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4)
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
        
        prepaymentTextField.anchorWithConstants(top: bottomEntryViewContainer.topAnchor, left: prepaymentImageView.rightAnchor, bottom: nil, right: bottomEntryViewContainer.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4)
        prepaymentTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        priceTextField.anchorWithConstants(top: prepaymentTextField.bottomAnchor, left: priceImageView.rightAnchor, bottom: nil, right: bottomEntryViewContainer.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4)
        priceTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        phoneReceiverTextField.anchorWithConstants(top: priceTextField.bottomAnchor, left: callImageView.rightAnchor, bottom: nil, right: bottomEntryViewContainer.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4)
        phoneReceiverTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        descriptionTextField.anchorWithConstants(top: phoneReceiverTextField.bottomAnchor, left: descriptionImageView.rightAnchor, bottom: nil, right: bottomEntryViewContainer.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4)
        descriptionTextField.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        prepaymentImageView.anchorWithWidthHeightConstant(top: bottomEntryViewContainer.topAnchor, left: bottomEntryViewContainer.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        
        priceImageView.anchorWithWidthHeightConstant(top: prepaymentImageView.bottomAnchor, left: bottomEntryViewContainer.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        callImageView.anchorWithWidthHeightConstant(top: priceImageView.bottomAnchor, left: bottomEntryViewContainer.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        descriptionImageView.anchorWithWidthHeightConstant(top: callImageView.bottomAnchor, left: bottomEntryViewContainer.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
    }
}
extension HomeOrdererController{
    // handle address
    func convertAddressToLocation(address:String, completeHandle:@escaping (_ location:CLLocation) -> ()){
        let geocoder = CLGeocoder()
        var loca:CLLocation?
        geocoder.geocodeAddressString(address) { (placeMarks, err) in
            if err != nil {
                loca = nil
                return
            }
            loca = CLLocation()
            loca = placeMarks?[0].location
            DispatchQueue.main.async {
                completeHandle(loca!)
            }
            geocoder.cancelGeocode()
        }
    }
}

extension HomeOrdererController{
    
    @objc func uploadPost(){
        if startAddressTextField.text == "" || endAddressTextField.text == "" || prepaymentTextField.text == "" || priceTextField.text == "" || phoneReceiverTextField.text == ""{
            let alert = UIAlertController(title: "Nhập dữ liệu", message: "Bạn hãy nhập đầy đủ thông tin !", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else{
            guard let locationStart = self.locationStart,
                let locationEnd = self.locationEnd,
                let user = self.user
                else { return  }
            let post:Post = NSEntityDescription.insertNewObject(forEntityName: "Post", into: self.context!) as! Post
            post.address = self.address
            post.user = user
            post.addressStart = startAddressTextField.text!
            post.addressDestination = endAddressTextField.text!
            post.prepayment = Double(prepaymentTextField.text!)!
            post.price = Double(priceTextField.text!)!
            post.phoneReceiver = phoneReceiverTextField.text
            post.isComplete = false
            post.date = Date().description
            post.descriptionText = descriptionTextField.text != nil ? descriptionTextField.text : ""
            // if user edit is true then change method and path of api
            var method:String = ""
            var path:String = ""
            var messageAlert = ""
            if historyController != nil{
                post.postId = self.postHistory?.postId // can't change post id if editing post
                method = "PUT"
                path = "update_a_post"
                messageAlert = "Bài đăng của bạn đã được chỉnh sửa ."
            }else{ // else then insert new post
                method = "POST"
                path = "insert_new_post"
                post.postId = String().randomString()
                messageAlert = "Bài đăng của bạn đã được đăng tải lên ."
            }
            // insert to server
            restApiHandler.insertEditPost(method:method, path: path, post: post, locationStart: locationStart, locationEnd: locationEnd, completeHandler: { (isComplete) in
                let alert:UIAlertController?
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                if isComplete {
                    alert = UIAlertController(title: "Thành công", message: messageAlert, preferredStyle: .alert)
                    alert?.addAction(okAction)
                    if self.historyController != nil{
                        self.savePost(postOld: self.postHistory!)
                    }
                    do{
                        try!self.context?.save()
                    }
                    self.locationManager?.stopUpdatingLocation()
                }else{
                    alert = UIAlertController(title: "Lỗi", message: "Bài đăng của bạn đã không thể đăng tải lên vui lòng kiểm tra dữ liệu .", preferredStyle: .alert)
                    alert?.addAction(okAction)
                }
                self.present(alert!, animated: true, completion: nil)
            })
        }
    }
    
    func savePost(postOld:Post){
        let fetchRequest:NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "postId = %@", postOld.postId!)
        do{
            let fetchResults = try self.context?.fetch(fetchRequest)
            if fetchResults?.count != 0{
                let managedObjectOld = fetchResults?.last
                context?.delete(managedObjectOld!)
            }
        }catch let err{
            print(err)
        }
    }
    
}



















