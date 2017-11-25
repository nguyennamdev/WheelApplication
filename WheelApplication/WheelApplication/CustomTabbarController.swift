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
        UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let homeOrdererController = HomeOrdererController()
        homeOrdererController.tabBarItem = customTabbarItem(image: UIImage(named: "home")!)
        homeOrdererController.context = self.context!
        homeOrdererController.user = self.user!
        
        let historyController = HistoryController()
        historyController.tabBarItem = customTabbarItem(image: UIImage(named: "list")!)
        historyController.context = self.context!
        historyController.user = self.user!
        
        let UserController = UIViewController()
        UserController.tabBarItem = customTabbarItem(image: UIImage(named: "user")!)
        
//        viewControllers = [homeOrdererController,historyController,UserController]
        viewControllers = [homeOrdererController,historyController]
    }
    
    
    
    
}
