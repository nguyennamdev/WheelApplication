//
//  UserEntryInfoController+Extensions.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/14/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

extension UserEntryInforController {
    
    @objc func showRegionActivePicker(){
        heightRegionPickerViewConstaint?.constant = 100
        heightTypeOfUserPickerViewConstaint?.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func showTypeOfUserPicker(){
        heightTypeOfUserPickerViewConstaint?.constant = 100
        heightRegionPickerViewConstaint?.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func drawTitleLabel(view:UIView, title:String){
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant:12).isActive = true
    }
    
    func drawArrowDownLabel(view:UIView){
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "▼"
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
    }
    
    // func handles
    
    @objc func handleKeyboardNotification(notification:Notification){
        if notification.userInfo != nil{
            let isKeyboardShowing = notification.name == Notification.Name.UIKeyboardWillShow
            bottomViewButtonContainerConstraint?.constant = isKeyboardShowing ? -150 : 0
            contentQuestionTextView.isHidden = isKeyboardShowing ? true : false
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func handleLogin(){
        if regionLabel.text == nil || typeOfUserLabel.text == nil || phoneNumberTextField.text == nil
        {
            let alertDialog = UIAlertController(title: "Nhập dữ liệu", message: "Bạn đã chưa điền đầy đủ thông tin cần thiết . Vui lòng điền thông tin còn thiếu !", preferredStyle: .alert)
            let actionDialog = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertDialog.addAction(actionDialog)
            present(alertDialog, animated: true, completion: nil)
        }
        else{
            user?.phoneNumber = phoneNumberTextField.text!
            user?.regionActive = regionLabel.text!
            user?.typeOfUser = typeOfUserLabel.text!
            //save user by userdefault and islogged in
            UserDefaults.standard.setIsLoggedIn(value: true)
            saveUser(user: self.user!)
            //            restApiHandle.insertUserToDatabase(user: self.user!)
            let customTabbarController = CustomTabbarController()
            customTabbarController.context = self.context
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController
            guard let mainNavigation = rootViewController as? MainNavigationController else{
                return
            }
            mainNavigation.viewControllers = [customTabbarController]
            dismiss(animated: false, completion: nil)
        }
    }
    
    private func saveUser(user:User){
        let entity:User = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        entity.userId = user.userId
        entity.name = user.name
        entity.email = user.email
        entity.imageUrl = user.imageUrl
        entity.phoneNumber = user.phoneNumber
        entity.regionActive = user.regionActive
        entity.typeOfUser = user.typeOfUser
        do {
            try context!.save()
        }catch {
            print("Error save entity")
        }
    }
    
}
