//
//  MainNavigationController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/6/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

class MainNavigationController : UINavigationController{
    
    let fetchUserResult:NSFetchRequest<User> = User.fetchRequest()
    var context:NSManagedObjectContext?
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        context = appDelegate.persistentContainer.viewContext
//         check user log in
        if isLoggedIn(){
            let customTabbarController = CustomTabbarController()
            customTabbarController.context = self.context!
            viewControllers = [customTabbarController]
        }
        else{
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    private func isLoggedIn() -> Bool {
        return UserDefaults.standard.getIsLoggedIn()
    }
    
    @objc private func showLoginController() {
        let loginController = LoginController()
        loginController.context = self.context
        present(loginController, animated: false, completion: nil)
    }
    
}
