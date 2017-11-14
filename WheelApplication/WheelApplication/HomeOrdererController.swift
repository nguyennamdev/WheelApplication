//
//  HomeOrdererController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/13/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreLocation

class HomeOrdererController : UIViewController , UITextFieldDelegate, CLLocationManagerDelegate  {
   
    var address:Address?
    var locationManager:CLLocationManager?
    // layout contraints
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
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(endEdit))
        view.addGestureRecognizer(tapGesture)
        // set up location manager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        DispatchQueue.main.async {
            self.locationManager?.startUpdatingLocation()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Đơn đặt hàng"
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
    }
    
    func setupViews() {
        view.addSubview(entryViewContainner)
        view.addSubview(bookButton)
        view.addSubview(bottomEntryViewContainer)
        bottomEntrySetupViews()
        entryViewSetupViews()
        // contraint
        entryViewContainner.anchorWithConstants(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 12, bottomConstant: 0, rightConstant: 12)
        entryViewContainner.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
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
            startAddressImage.image = #imageLiteral(resourceName: "cursor")
            handleHeightBottomEntryContainerKeyboardHide()
            if self.addressSegmentControl.selectedSegmentIndex == 0 {
                if self.address != nil{
                    self.startAddressTextField.text = (self.address?.name)! + ", " + (self.address?.city)! + ", " + (self.address?.country)!
                }
            }
            else{
                self.startAddressTextField.text = ""
            }
        case 1:
    
            endAddressImage.image = #imageLiteral(resourceName: "route-isselect")
            handleHeightBottomEntryContainerKeyboardHide()
        case 2:
            prepaymentImageView.image = #imageLiteral(resourceName: "coin-select")
            handleHeightBottomEntryContainerKeyboardShowing()

        case 3:
            priceImageView.image = #imageLiteral(resourceName: "coin-select")
            handleHeightBottomEntryContainerKeyboardShowing()
        case 4:
            callImageView.image = #imageLiteral(resourceName: "call-answer-select")
            handleHeightBottomEntryContainerKeyboardShowing()
        case 5:
            descriptionImageView.image = #imageLiteral(resourceName: "edit-pencil-symbol-select")
            handleHeightBottomEntryContainerKeyboardShowing()
        default:
            print("Don't have any text field")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            startAddressImage.image = #imageLiteral(resourceName: "gps-fixed-indicator")
        case 1:
            endAddressImage.image = #imageLiteral(resourceName: "route")
        case 2:
            prepaymentImageView.image = #imageLiteral(resourceName: "coin")
            handleHeightBottomEntryContainerKeyboardHide()
        case 3:
            priceImageView.image = #imageLiteral(resourceName: "coin")
            handleHeightBottomEntryContainerKeyboardHide()
        case 4:
            callImageView.image = #imageLiteral(resourceName: "call-answer")
            handleHeightBottomEntryContainerKeyboardHide()
        case 5:
            descriptionImageView.image = #imageLiteral(resourceName: "edit-pencil-symbol")
            handleHeightBottomEntryContainerKeyboardHide()
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
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        let geocoder = CLGeocoder()
        self.address = Address()
        geocoder.reverseGeocodeLocation(location) { (placeMarks, err) in
            let addressDictionary = placeMarks?[0].addressDictionary
            self.address?.name = (addressDictionary?["Name"] as? String)!
            self.address?.city = (addressDictionary?["City"] as? String)!
            self.address?.country = (addressDictionary?["Country"] as? String)!
            self.address?.state = (addressDictionary?["State"] as? String)!
            self.address?.street = (addressDictionary?["SubLocality"] as? String)!
            
            if self.addressSegmentControl.selectedSegmentIndex == 0 {
                self.startAddressTextField.text = (self.address?.name)! + ", " + (self.address?.city)! + ", " + (self.address?.country)!
            }
        }
        
    }
    
    @objc func endEdit() {
        view.endEditing(true)
    }
    
    @objc func segmentChange(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            if self.address != nil{
                self.startAddressTextField.text = (self.address?.name)! + ", " + (self.address?.city)! + ", " + (self.address?.country)!
            }
        case 1:
            self.startAddressTextField.text = ""
        default:
            print("Don't change value")
        }
    }
    
    //////////////////////////////////////////
    
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
        segment.addTarget(self, action: #selector(segmentChange(sender:)), for: UIControlEvents.valueChanged)
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






































