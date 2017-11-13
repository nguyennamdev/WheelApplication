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
    
    
    var context:NSManagedObjectContext?
    var user:User?{
        didSet{
            print(user?.name)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        UITabBar.appearance().tintColor = UIColor.black
        let HomeController = UIViewController()
        let HomeNavigationController = UINavigationController(rootViewController: HomeController)
        HomeController.tabBarItem = customTabbarItem(image: UIImage(named: "home")!)
        HomeController.view.backgroundColor = UIColor.blue
       
        let NotificationController = UIViewController()
        let NotificationNavigationController = UINavigationController(rootViewController: NotificationController)
        NotificationController.tabBarItem = customTabbarItem(image: UIImage(named: "bell")!)
        NotificationController.view.backgroundColor = UIColor.brown
        
        let HistoryController = UIViewController()
        let HistoryNavigationController = UINavigationController(rootViewController: HistoryController)
        HistoryController.tabBarItem = customTabbarItem(image: UIImage(named: "list")!)
        HistoryController.view.backgroundColor = UIColor.cyan
        

        let UserController = UIViewController()
        let UserNavigationController = UINavigationController(rootViewController: UserController)
        UserController.tabBarItem = customTabbarItem(image: UIImage(named: "user")!)
        viewControllers = [HomeNavigationController,NotificationNavigationController,HistoryNavigationController,UserNavigationController]
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let fetchUserResult:NSFetchRequest<User> = User.fetchRequest()
        do{
            let user = try!context?.fetch(fetchUserResult)
            self.user = user?[0]
        }
    }
    
    func customTabbarItem(image:UIImage) -> UITabBarItem {
        let tabbarItem = UITabBarItem(title: nil, image: image, selectedImage: nil)
        tabbarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return tabbarItem
    }
    
}
