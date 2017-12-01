//
//  UserViewController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/27/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

struct DetailUser {
    var backgroundImage:UIColor
    var image:UIImage
    var title:String
    var valueText:String
}

class UserViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    let cellId = "cellId"
    var user:User?{
        didSet{
            guard let name = user?.name,
                let imageUrl = user?.imageUrl
            else {
                return
            }
            nameLabel.text = name
            do{
                let data = try!Data(contentsOf: URL(string: imageUrl)!)
                profileImageView.image = UIImage(data: data)
            }
        }
    }
    var context:NSManagedObjectContext?
    
    var listDetailUser:[DetailUser]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        // Do any additional setup after loading the view.
        setupViews()
        detailProfileTableView.delegate = self
        detailProfileTableView.dataSource = self
        detailProfileTableView.register(UserViewCell.self, forCellReuseIdentifier: cellId)
        initListDetailUser()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Cá nhân"
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDetailUser?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserViewCell
        cell.detailUser = listDetailUser?[indexPath.row]
        cell.tintColor = UIColor.white
        return cell
    }
    
    
    func setupViews(){
        view.addSubview(profileImageView)
        view.addSubview(detailProfileTableView)
        view.addSubview(nameLabel)
        view.addSubview(editUserButton)
        
        profileImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 12).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        profileImageView.layer.cornerRadius = 100
        
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        detailProfileTableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12).isActive = true
        detailProfileTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        detailProfileTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:12).isActive = true
        detailProfileTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-12).isActive = true
        
        editUserButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        editUserButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        editUserButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        editUserButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
    private func initListDetailUser(){
        guard let name = user?.name,
            let phone = user?.phoneNumber,
            let region = user?.regionActive,
            let typeOfUser = user?.typeOfUser
            else {
                return
        }
        listDetailUser = [
            DetailUser(backgroundImage: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), image: #imageLiteral(resourceName: "information-button"), title: "Tên người dùng", valueText:name),
            DetailUser(backgroundImage: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), image: #imageLiteral(resourceName: "telephone-receiver"), title: "Điện thoại", valueText: phone),
            DetailUser(backgroundImage: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), image: #imageLiteral(resourceName: "placeholder"), title: "Khu vực", valueText: region),
            DetailUser(backgroundImage: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), image: #imageLiteral(resourceName: "motorcycle"), title: "Loại người dùng", valueText: typeOfUser)
        ]
        
    }
    
    @objc private func handlerEditUser(){
        let userEntryInforController = UserEntryInforController()
        userEntryInforController.user = self.user
        userEntryInforController.context = self.context
        userEntryInforController.userViewController = self
        self.navigationController?.pushViewController(userEntryInforController, animated: true)
    }

    let nameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailProfileTableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableViewStyle.plain)
        tableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let profileImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.white.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let editUserButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Chỉnh sửa", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.addTarget(self, action: #selector(handlerEditUser), for: UIControlEvents.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius  = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
 
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
