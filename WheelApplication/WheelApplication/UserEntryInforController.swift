//
//  LoginExtendController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/6/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

class UserEntryInforController : UIViewController, UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource{
    
    var user:User?
    var context:NSManagedObjectContext?
    let restApiHandle = RestApiHandle.getInstance()
    let regionActives = ["Hà Nội", "TP. HCM ", "Khác"]
    let typeOfUsers = ["Shipper","Orderer"]
    
    var heightRegionPickerViewConstaint:NSLayoutConstraint?
    var bottomViewButtonContainerConstraint:NSLayoutConstraint?
    var heightTypeOfUserPickerViewConstaint:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Nhập Thông Tin"
        // add subviews
        view.addSubview(topViewContainer)
        view.addSubview(bottomViewContainer)
        view.backgroundColor = UIColor.white
        setupTopViewContainer()
        setupBottomViewContainer()
        
        // delegate and datasource of uiviews
        phoneNumberTextField.delegate = self
        regionActivePickerView.delegate = self
        regionActivePickerView.dataSource = self
        typeOfUserPickerView.delegate = self
        typeOfUserPickerView.dataSource = self
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func setupTopViewContainer(){
        topViewContainer.addSubview(imageQuestion)
        topViewContainer.addSubview(contentQuestionTextView)
        topViewContainer.anchorWithConstants(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        topViewContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        // make bottom constaint bottom container
        
        imageQuestion.topAnchor.constraint(equalTo: topViewContainer.topAnchor, constant: 4).isActive = true
        imageQuestion.centerXAnchor.constraint(equalTo: topViewContainer.centerXAnchor).isActive = true
        imageQuestion.heightAnchor.constraint(equalTo: topViewContainer.heightAnchor, multiplier: 0.3).isActive = true
        imageQuestion.widthAnchor.constraint(equalTo: topViewContainer.heightAnchor, multiplier: 0.3).isActive = true
        contentQuestionTextView.anchorWithConstants(top: imageQuestion.bottomAnchor, left: topViewContainer.leftAnchor, bottom: topViewContainer.bottomAnchor, right: topViewContainer.rightAnchor, topConstant: 4, leftConstant: 24, bottomConstant: 0, rightConstant: 24)
    }
    
    
    
    func setupBottomViewContainer() {
        bottomViewContainer.addSubview(phoneNumberTextField)
        bottomViewContainer.addSubview(regionActiveViewContainer)
        bottomViewContainer.addSubview(regionActivePickerView)
        bottomViewContainer.addSubview(typeOfUserViewContainer)
        bottomViewContainer.addSubview(typeOfUserPickerView)
        bottomViewContainer.addSubview(okButton)
        
        bottomViewContainer.anchorWithConstants(top: topViewContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        bottomViewContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        // make button contraint bottom container
        bottomViewButtonContainerConstraint = NSLayoutConstraint(item: bottomViewContainer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomViewButtonContainerConstraint!)
        // subviews contraint
        phoneNumberTextField.anchorWithConstants(top: bottomViewContainer.topAnchor, left: bottomViewContainer.leftAnchor, bottom: nil, right: bottomViewContainer.rightAnchor, topConstant: 4, leftConstant: 24, bottomConstant: 0, rightConstant: 24)
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        setupRegionActiveView()
        setupTypeOfUserView()
        
        okButton.anchorWithConstants(top: typeOfUserPickerView.bottomAnchor, left: bottomViewContainer.leftAnchor, bottom: nil, right: bottomViewContainer.rightAnchor, topConstant: 12, leftConstant: 24, bottomConstant: 0, rightConstant: 24)
        okButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupRegionActiveView(){
        regionActiveViewContainer.anchorWithConstants(top: phoneNumberTextField.bottomAnchor, left: bottomViewContainer.leftAnchor, bottom: nil, right: bottomViewContainer.rightAnchor, topConstant: 12, leftConstant: 24, bottomConstant: 0, rightConstant: 24)
        regionActiveViewContainer.heightAnchor.constraint(equalToConstant: 35).isActive = true
        drawArrowDownLabel(view: regionActiveViewContainer)
        drawTitleLabel(view: regionActiveViewContainer, title: "Khu vực ")
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(showRegionActivePicker))
        regionActiveViewContainer.addGestureRecognizer(tapGesture)
        //
        regionActiveViewContainer.addSubview(regionLabel)
        // region label constraint
        regionLabel.centerXAnchor.constraint(equalTo: regionActiveViewContainer.centerXAnchor).isActive = true
        regionLabel.centerYAnchor.constraint(equalTo: regionActiveViewContainer.centerYAnchor).isActive = true
        //picker view constraint
        regionActivePickerView.anchorWithConstants(top:regionActiveViewContainer.bottomAnchor, left: bottomViewContainer.leftAnchor, bottom: nil, right: bottomViewContainer.rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 24)
        // make height constaint region picker view
        heightRegionPickerViewConstaint = NSLayoutConstraint(item: regionActivePickerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        bottomViewContainer.addConstraint(heightRegionPickerViewConstaint!)
    }
    
    func setupTypeOfUserView() {
        typeOfUserViewContainer.anchorWithConstants(top: regionActivePickerView.bottomAnchor, left: bottomViewContainer.leftAnchor, bottom: nil, right: bottomViewContainer.rightAnchor, topConstant: 12, leftConstant: 24, bottomConstant: 0, rightConstant: 24)
        typeOfUserViewContainer.heightAnchor.constraint(equalToConstant: 35).isActive = true
        drawArrowDownLabel(view: typeOfUserViewContainer)
        drawTitleLabel(view: typeOfUserViewContainer, title: "Người dùng ")
        typeOfUserViewContainer.addSubview(typeOfUserLabel)
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(showTypeOfUserPicker))
        typeOfUserViewContainer.addGestureRecognizer(tapGesture)
        
        // type of user label constraint
        typeOfUserLabel.centerYAnchor.constraint(equalTo: typeOfUserViewContainer.centerYAnchor).isActive = true
        typeOfUserLabel.centerXAnchor.constraint(equalTo: typeOfUserViewContainer.centerXAnchor).isActive = true
        
        typeOfUserPickerView.anchorWithConstants(top: typeOfUserViewContainer.bottomAnchor, left: bottomViewContainer.leftAnchor, bottom: nil, right: bottomViewContainer.rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 24)
        // make height constaint type of user picker view
        heightTypeOfUserPickerViewConstaint = NSLayoutConstraint(item: typeOfUserPickerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        bottomViewContainer.addConstraint(heightTypeOfUserPickerViewConstaint!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        heightRegionPickerViewConstaint?.constant = 0
        heightTypeOfUserPickerViewConstaint?.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        if textField.isEqual(phoneNumberTextField){
            let pattern = "^(01[2689]|09)[0-9]{8}$"
            let predicate = NSPredicate(format: "self MATCHES [c] %@", pattern)
            if !predicate.evaluate(with: phoneNumberTextField.text) {
                let alertDialog = UIAlertController(title: "Nhập số điện thoại", message: "Số điện thoại của bạn nhập không hợp lệ", preferredStyle: .alert)
                let actionAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertDialog.addAction(actionAlert)
                present(alertDialog, animated: true, completion: {
                    self.phoneNumberTextField.text = ""
                })
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return regionActives[row]
        case 1:
            return typeOfUsers[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return regionActives.count
        case 1:
            return typeOfUsers.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            regionLabel.text = regionActives[row]
        case 1:
            typeOfUserLabel.text = typeOfUsers[row]
        default:
            return
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumberTextField.resignFirstResponder()
        return true
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
        heightRegionPickerViewConstaint?.constant = 0
        heightTypeOfUserPickerViewConstaint?.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .beginFromCurrentState, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    // MARK : Views
    
    let regionActiveViewContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    
    let typeOfUserViewContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    let regionLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let typeOfUserLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let okButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("OK", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let regionActivePickerView:UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tag = 0
        picker.backgroundColor = #colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253799319, alpha: 1)
        return picker
    }()
    
    let typeOfUserPickerView:UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tag = 1
        picker.backgroundColor = #colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253799319, alpha: 1)
        return picker
    }()
    
    let phoneNumberTextField:UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Nhập số điện thoại của bạn"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.clearButtonMode = .always
        return textField
    }()
    
    let contentQuestionTextView:UITextView = {
        let textView = UITextView()
        let attributed = NSMutableAttributedString(string: "Bạn hãy nhập đầy đủ các thông tin dưới đây !\n", attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16)])
        attributed.append(NSAttributedString(string: "1. Nhập số điện thoại : Mọi người có thể liên hệ nếu họ đã có số điện thoại của bạn.\n2. Chọn thành phố : Nhắm mục đích tìm đơn đặt hàng (hoặc người vận chuyện hàng ) nhanh hơn.\n3. Chọn người dùng : Nhắm xác định rõ bạn muốn đặt đơn hàng hay là bạn muốn vẩn chuyển hàng", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13), NSForegroundColorAttributeName:UIColor.gray]))
        textView.attributedText = attributed
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isSelectable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let topViewContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomViewContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageQuestion:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "question")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
}

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
            // push navigation cusomtabbar controller
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController
            guard let mainNavagtionController = rootViewController as? MainNavigationController else {
                return
            }
            //save user by userdefault and islogged in
            UserDefaults.standard.setIsLoggedIn(value: true)
            saveUser(user: self.user!)
            restApiHandle.insertUserToDatabase(user: self.user!)
            // push navigation to home
            let customTabbarController = CustomTabbarController()
            customTabbarController.context = self.context!
            mainNavagtionController.viewControllers = [customTabbarController]
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
