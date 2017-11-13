//
//  LoginController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/6/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import CoreData

class LoginController : UIViewController, FBSDKLoginButtonDelegate{
    
    var context:NSManagedObjectContext?
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // MARK : Add subview
        view.addSubview(logoLabel)
        view.addSubview(topLogoContainer)
        view.addSubview(bottomLogoContainer)
        setupViews()
        loginButton.delegate = self
        
        if (FBSDKAccessToken.current()) != nil{
            presentUserEntryInforController()
        }
        
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        presentUserEntryInforController()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("log out")
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    private func presentUserEntryInforController(){
        fetchProfileUser { (user) in
            self.user = user
            let userEntryInforController = UserEntryInforController()
            print(self.user?.userId)
            userEntryInforController.user = self.user
            userEntryInforController.context = self.context 
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController
            guard let mainNavigation = rootViewController as? MainNavigationController else{
                return
            }
            mainNavigation.viewControllers = [userEntryInforController]
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func fetchProfileUser(completeHandler:@escaping (User) -> ()){
        let parameters = ["fields" : "email, first_name , last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (requestConnect, result, err) in
            if err != nil {
                return
            }
            let data = result as! [String:AnyObject]
            guard
                let id = data["id"] as? String,
                let first_name = data["first_name"] as? String,
                let last_name = data["last_name"] as? String,
                let email = data["email"] as? String,
                let picture = data["picture"] as? [String:AnyObject],
                let imageUrl = picture["data"]?["url"] as? String
                else{
                    return
            }
            let user = User(context: self.context!)
            user.userId = id
            user.name = "\(first_name) \(last_name)"
            user.email = email
            user.imageUrl = imageUrl
            DispatchQueue.main.async {
                completeHandler(user)
            }
        }
    }
    
    func setupViews() {
        topLogoContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topLogoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topLogoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topLogoContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topLogoContainer.addSubview(logoImage)
        topLogoContainer.addSubview(logoLabel)
        
        logoImage.centerXAnchor.constraint(equalTo: topLogoContainer.centerXAnchor).isActive = true
        logoImage.centerYAnchor.constraint(equalTo: topLogoContainer.centerYAnchor,constant:-36).isActive = true
        logoImage.heightAnchor.constraint(equalTo: topLogoContainer.heightAnchor, multiplier: 0.3).isActive = true
        logoImage.widthAnchor.constraint(equalTo: topLogoContainer.heightAnchor, multiplier: 0.3).isActive = true
        
        logoLabel.centerXAnchor.constraint(equalTo: topLogoContainer.centerXAnchor).isActive = true
        logoLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor).isActive = true
        setupBottomLogoContainer()
        
    }
    
    func setupBottomLogoContainer() {
        bottomLogoContainer.topAnchor.constraint(equalTo: topLogoContainer.bottomAnchor).isActive = true
        bottomLogoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomLogoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomLogoContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        bottomLogoContainer.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: bottomLogoContainer.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: bottomLogoContainer.centerYAnchor).isActive = true
    }
    
    
    /// MARK : views
    
    let logoLabel:UILabel = {
        let label = UILabel()
        label.text = "Wheel"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "car-wheel")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let topLogoContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let bottomLogoContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginButton:FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile","email", "user_friends"]
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
}
