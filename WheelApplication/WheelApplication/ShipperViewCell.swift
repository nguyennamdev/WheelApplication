//
//  ShipperViewCell.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/29/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ShipperViewCell:BaseCell {
    
    var shipperDelegate:ShipperDelegate?
    
    var post:Post?{
        didSet{
            
            guard let addressStart = post?.addressStart,
                let addressDestination = post?.addressDestination,
                let prepayment = post?.prepayment,
                let price = post?.price,
                let phoneReceiver = post?.phoneReceiver,
                let date = post?.date
            else {
                return
            }
            timeLabel.text = date
            setAttributeForLabel(title: "Địa chỉ bắt đầu ", value: addressStart, label: addressStartContentLabel)
            setAttributeForLabel(title: "Địa chỉ người nhận ", value: addressDestination, label: addressDestinationContentLabel)
            setAttributeForLabel(title: "Tiền ứng trước ", value: "\(prepayment)", label: prepaymentContentLabel)
            setAttributeForLabel(title: "Phí vận chuyển ", value: "\(price)", label: priceContentLabel)
            setAttributeForLabel(title: "SĐT người nhận ", value: phoneReceiver, label: phoneReceiverContentLabel)
            setAttributeForLabel(title: "Mô tả thêm ", value: post?.descriptionText ?? "", label: descriptionContentLabel)
        }
    }
    var user:User?{
        didSet{
            guard let name = user?.name ,
                let imageUrl = user?.imageUrl
                else {
                    return
            }
            do{
                let data = try Data(contentsOf: URL(string: imageUrl)!)
                profileImageView.image =  UIImage(data: data)
            }catch {
                profileImageView.image = nil
                profileImageView.backgroundColor = UIColor.red
            }
            nameProfileLabel.text = name
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
        backgroundColor = UIColor.white
        callButton.addTarget(self, action: #selector(callOrderer), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(savePost), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupSubViews(){
        addSubview(dividerLine)
        addSubview(actionContainerView)
        addSubview(speratorView)
        actionContainerView.addSubview(callButton)
        actionContainerView.addSubview(saveButton)
        
        dividerLine.topAnchor.constraint(equalTo: descriptionImageView.bottomAnchor, constant: 4).isActive = true
        dividerLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        dividerLine.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        actionContainerView.anchorWithConstants(top: dividerLine.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant:0, rightConstant: 12)
        actionContainerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        callButton.topAnchor.constraint(equalTo: actionContainerView.topAnchor, constant: 0).isActive = true
        callButton.bottomAnchor.constraint(equalTo: actionContainerView.bottomAnchor, constant: 0).isActive = true
        callButton.widthAnchor.constraint(equalTo: actionContainerView.widthAnchor, multiplier: 0.5).isActive = true
        callButton.leftAnchor.constraint(equalTo: actionContainerView.leftAnchor, constant: 12).isActive = true
        
        saveButton.rightAnchor.constraint(equalTo: actionContainerView.rightAnchor, constant: -12).isActive = true
        saveButton.topAnchor.constraint(equalTo: actionContainerView.topAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: actionContainerView.bottomAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalTo: actionContainerView.widthAnchor, multiplier: 0.5).isActive = true
        speratorView.anchorWithConstants(top: actionContainerView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    
    
    // Mark : Views

    let dividerLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let actionContainerView:UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let callButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("  Gọi", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.setImage(#imageLiteral(resourceName: "call-answer"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let saveButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("  Lưu lại", for: .normal)
        button.setImage(#imageLiteral(resourceName: "save"), for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let speratorView:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}
// actions of cell
extension ShipperViewCell {
    
    @objc func callOrderer(sender:UIButton) {
        guard let phoneOrderer = post?.phoneOrderer else {
            print("phone is null")
            return
        }
        shipperDelegate?.didCallOrderer(phoneNumber: phoneOrderer)
    }
    
    func savePost(sender:UIButton){
        guard let post = self.post else {
            return
        }
        shipperDelegate?.didSavePost(post: post, sender:sender)
    }
}


