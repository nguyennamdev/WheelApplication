//
//  HistoryCell.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/20/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    var post:Post?{
        didSet{
            guard let addressStart = post?.addressStart,
                let addressDestination = post?.addressDestination,
                let prepayment = post?.prepayment,
                let price = post?.price,
                let phone = post?.phoneReceiver,
                let description = post?.descriptionText
            else {
                return
            }          
            setAttributeForLabel(title: "Địa chỉ bắt đầu ", value: addressStart, label: addressStartContentLabel)
            setAttributeForLabel(title: "Địa chỉ người nhận ", value: addressDestination, label: addressDestinationContentLabel)
            setAttributeForLabel(title: "Tiền ứng trước ", value: "\(prepayment)", label: prepaymentContentLabel)
            setAttributeForLabel(title: "Phí vận chuyển ", value: "\(price)", label: priceContentLabel)
            setAttributeForLabel(title: "SĐT người nhận ", value: phone, label: phoneReceiverContentLabel)
            setAttributeForLabel(title: "Mô tả thêm ", value: description, label: descriptionContentLabel)
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
        setupViews()
        setupImageViews()
        setupContentViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(profileImageView)
        addSubview(nameProfileLabel)
        addSubview(timeLabel)
//        addSubview(optionButton)
        // constaints
        profileImageView.anchorWithWidthHeightConstant(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        profileImageView.layer.cornerRadius = 20
        nameProfileLabel.anchorWithConstants(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0)
        timeLabel.anchorWithConstants(top: nameProfileLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0)
//        optionButton.anchorWithConstants(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 12)
        
    }
    
    func setupImageViews(){
        addSubview(addressStartImageView)
        addSubview(addressDestinationImageView)
        addSubview(prepaymentImageView)
        addSubview(priceImageView)
        addSubview(phoneImageView)
        addSubview(descriptionImageView)
        
        addressStartImageView.anchorWithWidthHeightConstant(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        addressDestinationImageView.anchorWithWidthHeightConstant(top: addressStartImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        prepaymentImageView.anchorWithWidthHeightConstant(top: addressDestinationImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        priceImageView.anchorWithWidthHeightConstant(top: prepaymentImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        phoneImageView.anchorWithWidthHeightConstant(top: priceImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant:12, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        descriptionImageView.anchorWithWidthHeightConstant(top: phoneImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
    }
    
    func setupContentViews(){
        // add views content
        addSubview(addressStartContentLabel)
        addSubview(addressDestinationContentLabel)
        addSubview(prepaymentContentLabel)
        addSubview(priceContentLabel)
        addSubview(phoneReceiverContentLabel)
        addSubview(descriptionContentLabel)
        // views content constaint
        
        addressStartContentLabel.anchorWithCenter(centerY: addressStartImageView.centerYAnchor, centerX: nil)
        addressStartContentLabel.anchorWithConstants(top: nil, left: addressStartImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 6, bottomConstant: 0, rightConstant: 6)
        addressDestinationContentLabel.anchorWithCenter(centerY: addressDestinationImageView.centerYAnchor, centerX: nil)
        addressDestinationContentLabel.anchorWithConstants(top: nil, left: addressDestinationImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 6, bottomConstant: 0, rightConstant: 6)
        
        prepaymentContentLabel.anchorWithCenter(centerY: prepaymentImageView.centerYAnchor, centerX: nil)
        prepaymentContentLabel.anchorWithConstants(top: nil, left: prepaymentImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 6, bottomConstant: 0, rightConstant: 6)
        
        priceContentLabel.anchorWithCenter(centerY: priceImageView.centerYAnchor, centerX: nil)
        priceContentLabel.anchorWithConstants(top: nil, left: priceImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 6, bottomConstant: 0, rightConstant: 6)
        phoneReceiverContentLabel.anchorWithCenter(centerY: phoneImageView.centerYAnchor, centerX: nil)
        phoneReceiverContentLabel.anchorWithConstants(top: nil, left: phoneImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 6, bottomConstant: 0, rightConstant: 6)
        descriptionContentLabel.anchorWithCenter(centerY: descriptionImageView.centerYAnchor, centerX: nil)
        descriptionContentLabel.anchorWithConstants(top: nil, left: descriptionImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 6, bottomConstant: 0, rightConstant: 6)
        
        
    }
    
    func setAttributeForLabel(title:String, value:String , label:UILabel){
        let attributeString = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13), NSForegroundColorAttributeName:UIColor.black])
        attributeString.append(NSAttributedString(string: value, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13), NSForegroundColorAttributeName:#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]))
        label.attributedText = attributeString
    }

    
    ///////////////// MARK : Views //////////////////////////////
    
    let profileImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    let nameProfileLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.text = Date().description
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        return label
    }()
//    
//    
//    let optionButton:UIButton = {
//        let button = UIButton(type:UIButtonType.system)
//        button.setTitle("⋮", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.addTarget(self, action: #selector(showOption(button:)), for: .touchUpInside)
//        return button
//    }()
//    
    let addressStartImageView:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "gps-fixed-indicator"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    let addressDestinationImageView:UIImageView = {
        let image = UIImageView(image:#imageLiteral(resourceName: "route"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    let prepaymentImageView:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "coin"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    let priceImageView:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "coin"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    
    let phoneImageView:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "call-answer"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    
    let descriptionImageView:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "edit-pencil-symbol"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    let addressStartContentLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let addressDestinationContentLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let prepaymentContentLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let priceContentLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let phoneReceiverContentLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let descriptionContentLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
}






