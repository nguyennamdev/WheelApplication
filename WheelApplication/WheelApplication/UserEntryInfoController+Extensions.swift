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
            saveUser()
        }
    }
    
    private func saveUser(){
        if userViewController != nil{
            let fetchUser:NSFetchRequest<User> = User.fetchRequest()
            // check user id exist or not
            fetchUser.predicate = NSPredicate(format: "userId = %@", (self.user?.userId!)!)
            if let fetchResults = try?context?.fetch(fetchUser){
                if fetchResults?.count != 0{
                    let managedObject = fetchResults![0]
                    managedObject.setValue(self.user?.phoneNumber, forKey: "phoneNumber")
                    managedObject.setValue(self.user?.regionActive, forKey: "regionActive")
                    managedObject.setValue(self.user?.typeOfUser, forKey: "typeOfUser")
                    let alert = UIAlertController(title: "Thay đổi thông tin", message: "Bạn có muốn thay đổi thông tin", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        self.restApiHandle.updateUserToDatabase(user: self.user!) // update user on api
                        do {
                            try self.context!.save()
                        }catch {
                            print("Error save entity")
                        }
                    })
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(cancelAction)
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
                }
                
            }
        }else{
            restApiHandle.insertUserToDatabase(user: self.user!) // save user on api
            do {
                try context!.save()
            }catch {
                print("Error save entity")
            }
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
    
}
