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
            let users = try!context?.fetch(fetchUserResult)
//            for u in users!{
//                print(u)
//            }
            self.user = users?[0]
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
        // user controller is view controller common
        let userController = UserViewController()
        userController.tabBarItem = customTabbarItem(image: UIImage(named: "user")!)
        userController.user = self.user!
        userController.context = self.context!
        
        if user?.typeOfUser == "Orderer"{
            let homeOrdererController = HomeOrdererController()
            homeOrdererController.tabBarItem = customTabbarItem(image: UIImage(named: "home")!)
            homeOrdererController.context = self.context!
            homeOrdererController.user = self.user!
            
            let historyController = HistoryController()
            historyController.tabBarItem = customTabbarItem(image: UIImage(named: "list")!)
            historyController.context = self.context!
            historyController.user = self.user!
            viewControllers = [homeOrdererController,historyController,userController]
        }else{
            let homeShipperTableViewController = HomeShipperTableViewController()
            homeShipperTableViewController.tabBarItem = customTabbarItem(image: #imageLiteral(resourceName: "home"))
            homeShipperTableViewController.user = self.user!
            homeShipperTableViewController.context = self.context!
            
            let libraryTableViewController = LibraryTableViewController()
            libraryTableViewController.context = self.context!
            libraryTableViewController.tabBarItem = customTabbarItem(image: #imageLiteral(resourceName: "folder"))
            
           
            viewControllers = [homeShipperTableViewController, libraryTableViewController, userController]
        }
    }
    
    
    
    
}
