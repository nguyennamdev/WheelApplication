//
//  RestApiHandle.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/12/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import CoreLocation
import UIKit
import CoreData

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

extension RestApiHandle {
    // api for post
    
    public func insertEditPost(method:String, path:String, post:Post , locationStart:CLLocation , locationEnd:CLLocation, completeHandler:@escaping (_ isComplete:Bool) -> ()){
        // parse locations
        let latitudeStart:Double = locationStart.coordinate.latitude
        let longtitudeStart:Double = locationStart.coordinate.longitude
        let latitudeEnd:Double = locationEnd.coordinate.latitude
        let longtitudeEnd:Double  = locationEnd.coordinate.longitude
        
        let url = URL(string: "http://localhost:8000/posts/\(path)")
        var request = URLRequest(url: url!)
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        let parameters = ["postId": post.postId! , "userId" : post.user!.userId! , "prepayment" : post.prepayment,
                          "price":post.price , "phoneReceiver" : post.phoneReceiver! ,"phoneOrderer": post.user!.phoneNumber!, "addressStart": post.addressStart!,
                          "addressDestination" : post.addressDestination! , "latitudeStart" : latitudeStart,
                          "longtitudeStart" :longtitudeStart, "latitudeEnd" :latitudeEnd, "region":post.user!.regionActive!,
                          "longtitudeEnd" : longtitudeEnd, "description" : post.descriptionText!] as [String : Any]
        guard let httpBody = try?JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        dataTaskURLRequest(urlRequest: request) { (isComplete) in
            completeHandler(isComplete)
        }
    }
    
    public func deletePost(postId:String, completeHandle:@escaping (Bool) -> ()){
        let url = URL(string: "http://localhost:8000/posts/delete_a_post")
        var request = URLRequest(url: url!)
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        let parameters = ["postId": postId] as [String : Any]
        guard let httpBody = try?JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        dataTaskURLRequest(urlRequest: request) { (isComplete) in
            completeHandle(isComplete)
        }
    }
    
    private func dataTaskURLRequest(urlRequest:URLRequest , completeHandler:@escaping (_ isComplete:Bool) -> ()){
        // create task using the session object to send data to the server
        URLSession.shared.dataTask(with: urlRequest) { (data, response, err) in
            if err != nil{
                return
            }
            guard let jsonData = data else{
                return
            }
            do {
                if let json = try?JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
                    let dictionary = json as? [String:AnyObject]
                    let result = dictionary?["result"] as? String
                    completeHandler(result == "OK" ? true : false)
                }
            }
            }.resume()
    }
    
    public func getListPostByRegion(region:String , completeHandler:@escaping ([Post]) -> ()){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var urlComponents = URLComponents(string:"http://localhost:8000/posts/list_post") // create url and query
        urlComponents?.queryItems = [
            URLQueryItem(name: "region", value: region)
        ]
        guard let url = urlComponents?.url! else {
            print("Error : cannot create URL")
            return
        }
        var posts:[Post]?
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, err) in
            if err != nil {
                return
            }
            guard let jsonData = data else{
                return
            }
            do{
                if let json = try?JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers){
                    guard let  dictionary = json as? [String:AnyObject],
                        let _ = dictionary["result"] as? String,
                        let postResult = dictionary["data"] as? [Any]
                        else{
                            return
                    }
                    posts = [Post]()
                    
                    // parse json
                    for p in postResult{
                        if let postDict = p as? NSDictionary{
                            let post = NSEntityDescription.insertNewObject(forEntityName: "Post", into: context) as! Post
                            post.setValueWithDictionary(dictionary: postDict)
                            post.isShipper = true
                            post.isSave = false // set equal false because don't want save post when switch scene
                            // add to array post
                            posts?.append(post)
                        }
                    }
                    completeHandler(posts!)
                }
            }
        }.resume()
    }
}




























