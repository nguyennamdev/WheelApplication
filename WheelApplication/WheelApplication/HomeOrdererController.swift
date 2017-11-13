//
//  HomeOrdererController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/13/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class HomeOrdererController : UIViewController , UITextFieldDelegate {
    
    
    // layout contraints
    var addressSegmentHeightConstaint:NSLayoutConstraint?
    var entryViewHeightContraint:NSLayoutConstraint?
    var bookButtonBottomContaint:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        setupViews()
        // text fields delegate
        startAddressTextField.delegate = self
        endAddressTextField.delegate = self
        prepaymentTextField.delegate = self
        priceTextField.delegate = self
        phoneReceiverTextField.delegate = self
        descriptionTextField.delegate = self
        navigationController?.navigationBar.topItem?.title = "Đơn đặt hàng"
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(endEdit))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    func setupViews() {
        view.addSubview(entryViewContainner)
        view.addSubview(bookButton)
        view.addSubview(bottomEntryViewContainer)
        bottomEntrySetupViews()
        entryViewSetupViews()
        // contraint
        entryViewContainner.anchorWithConstants(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 12)
        
        entryViewHeightContraint = NSLayoutConstraint(item: entryViewContainner, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 110)
        view.addConstraint(entryViewHeightContraint!)
        
        bottomEntryViewContainer.anchorWithConstants(top: nil, left: view.leftAnchor, bottom: bookButton.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 12, rightConstant: 12)
        bottomEntryViewContainer.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        bookButton.anchorWithConstants(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 12)
        bookButtonBottomContaint = NSLayoutConstraint(item: bookButton, attribute: .bottom, relatedBy: .equal, toItem: bottomLayoutGuide, attribute: .top, multiplier: 1, constant:-8)
        bookButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addConstraint(bookButtonBottomContaint!)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            entryAddressAnimate(option: .transitionCurlDown, heightContraint: 140, heignContraint: 30, isHidden: false)
            startAddressImage.image = #imageLiteral(resourceName: "cursor")
        case 1:
            entryAddressAnimate(option: .transitionCurlUp, heightContraint: 110, heignContraint: 0, isHidden: true)
            endAddressImage.image = #imageLiteral(resourceName: "route-isselect")
        
        case 2:
            prepaymentImageView.image = #imageLiteral(resourceName: "coin-select")
            
        case 3:
            priceImageView.image = #imageLiteral(resourceName: "coin-select")
        case 4:
            callImageView.image = #imageLiteral(resourceName: "call-answer-select")
        case 5:
            descriptionImageView.image = #imageLiteral(resourceName: "edit-pencil-symbol-select")
        default:
            print("Don't have any text field")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            entryAddressAnimate(option: .transitionCurlUp, heightContraint: 110, heignContraint: 0, isHidden: true)
            startAddressImage.image = #imageLiteral(resourceName: "gps-fixed-indicator")
        case 1:
            endAddressImage.image = #imageLiteral(resourceName: "route")
        case 2:
            prepaymentImageView.image = #imageLiteral(resourceName: "coin")
            handleHeightBottomEntryContainerKeyboardShowing(notification: Notification(name:
            .UIKeyboardWillShow))
        case 3:
            priceImageView.image = #imageLiteral(resourceName: "coin")
        case 4:
            callImageView.image = #imageLiteral(resourceName: "call-answer")
        case 5:
            descriptionImageView.image = #imageLiteral(resourceName: "edit-pencil-symbol")
        default:
            print("Don't have any text field")
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        startAddressTextField.resignFirstResponder()
        endAddressTextField.resignFirstResponder()
        prepaymentTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
        phoneReceiverTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        return true
    }
    
    @objc func endEdit() {
        view.endEditing(true)
    }
    
  
    
    // views
    let entryViewContainner:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startAddressTextField:UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.layer.borderWidth = 0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.backgroundColor = UIColor.white
        textField.placeholder = " Địa chỉ nhận hàng"
        textField.tag = 0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let endAddressTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = " Địa chỉ chuyến hàng đến"
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .line
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.tag = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
   

    let addressSegmentControl:UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Hiện tại", "Khác"])
        segment.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        segment.selectedSegmentIndex = 0
        segment.isHidden = true
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    let startAddressImage:UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .center
        image.image = #imageLiteral(resourceName: "gps-fixed-indicator")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let endAddressImage:UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .center
        image.image = #imageLiteral(resourceName: "route")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let prepaymentTextField:UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.backgroundColor = UIColor.white
        textField.placeholder = " Giá tiền ứng trước "
        textField.tag = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let priceTextField:UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.backgroundColor = UIColor.white
        textField.placeholder = " Phí vận chuyển "
        textField.tag = 3
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    
    let phoneReceiverTextField:UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.backgroundColor = UIColor.white
        textField.placeholder = " Số điện thoại người nhận "
        textField.tag = 4
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let descriptionTextField:UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.backgroundColor = UIColor.white
        textField.placeholder = " Mô tả thêm "
        textField.tag = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let bottomEntryViewContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bookButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("OK", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let prepaymentImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "coin")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let priceImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "coin")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let callImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "call-answer")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let descriptionImageView:UIImageView =
    {
        let image = UIImageView()
        image.contentMode = .center
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "edit-pencil-symbol")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
}






































