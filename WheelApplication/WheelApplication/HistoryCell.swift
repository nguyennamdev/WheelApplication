//
//  HistoryCell.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/20/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class HistoryCell: BaseCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
}






