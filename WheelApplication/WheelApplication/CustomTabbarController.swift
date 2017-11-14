//
//  CustomTabbarController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/6/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

class CustomTabbarController : UITabBarController{
    
    var user:User?{
        didSet{
            print(user?.name ?? "")
        }
    }
    var context:NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = " "
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let fetchUserResult:NSFetchRequest<User> = User.fetchRequest()
        do{
            let user = try!context?.fetch(fetchUserResult)
            self.user = user?[0]
        }
        setViewControllers()
    }
    
    
    func customTabbarItem(image:UIImage) -> UITabBarItem {
        let tabbarItem = UITabBarItem(title: nil, image: image, selectedImage: nil)
        tabbarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return tabbarItem
    }
    
    
    func setViewControllers(){
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        let homeOrdererController = HomeOrdererController()
        homeOrdererController.tabBarItem = customTabbarItem(image: UIImage(named: "home")!)
        homeOrdererController.navigationItem.title = "Đơn đặt hàng"
        
        let NotificationController = UIViewController()
        NotificationController.tabBarItem = customTabbarItem(image: UIImage(named: "bell")!)
        NotificationController.view.backgroundColor = UIColor.brown
        
        let HistoryController = UIViewController()
        HistoryController.tabBarItem = customTabbarItem(image: UIImage(named: "list")!)
        HistoryController.view.backgroundColor = UIColor.cyan
        
        let UserController = UIViewController()
        UserController.tabBarItem = customTabbarItem(image: UIImage(named: "user")!)
        
        viewControllers = [homeOrdererController,NotificationController,HistoryController,UserController]
    }
    
    
    
    
}
