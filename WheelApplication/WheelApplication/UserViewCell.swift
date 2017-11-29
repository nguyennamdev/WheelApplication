//
//  UserViewCell.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/27/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class UserViewCell:UITableViewCell {
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    var detailUser:DetailUser?{
        didSet{
            guard let image = detailUser?.image,
                let color = detailUser?.backgroundImage,
                let title = detailUser?.title,
                let value = detailUser?.valueText
            else {
                return
            }
            iconImageView.image = image
            iconImageView.backgroundColor = color
            titleTextLabel.text = title
            detailLabel.text = value
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupViews() {
        addSubview(iconImageView)
        addSubview(titleTextLabel)
        addSubview(detailLabel)
        
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        
        titleTextLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 12).isActive = true
        titleTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant:-12).isActive = true
        
    }
    
    let iconImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let titleTextLabel:UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailLabel:UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Xin chao"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
