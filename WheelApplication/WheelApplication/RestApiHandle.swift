//
//  RestApiHandle.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/12/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class RestApiHandle: NSObject {
    private static var instance = RestApiHandle()
    
    public static func getInstance() -> RestApiHandle{
        return instance
    }
}

extension RestApiHandle{
    //api for user
    
    private func insertEditUser(method:String, path:String,user:User){
        let url = URL(string: "http://localhost:8000/users/\(path)")
        var request = URLRequest(url: url!)
        //        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        let parameters = ["userId" : user.userId , "name" : user.name , "email" : user.email, "phoneNumber" : user.phoneNumber ,
                          "imageUrl":user.imageUrl , "regionActive":user.regionActive, "typeOfUser":user.typeOfUser]
        guard let httpBody = try?JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        // create task using the session object to send data to the server
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if err != nil{
                return
            }
            guard let jsonData = data else{
                return
            }
            do {
                if let json = try?JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers){
                    print(json)
                }
            }
            }.resume()
    }
    
    public func insertUserToDatabase(user:User){
        insertEditUser(method: "POST", path: "insert_new_user", user: user)
    }
    
    public func updateUserToDatabase(user:User){
        insertEditUser(method: "PUT", path: "update_a_user", user: user)
    }

}































