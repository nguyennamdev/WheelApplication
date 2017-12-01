//
//  HomeShipperTableViewController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/29/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

class HomeShipperTableViewController: UITableViewController {
    
    let cellId = "CellId"
    let restApiHandler = RestApiHandle.getInstance()
    var user:User?
    
    var posts:[Post]?{
        didSet{
            tableView.reloadData()
            activityIndicatorView.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.register(ShipperViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        
        // get list post by api with region current user
        restApiHandler.getListPostByRegion(region: (user?.regionActive)!) { (posts) in
            self.posts = posts
        }
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 255
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ShipperViewCell
        cell.user = self.user!
        if let post = posts?[indexPath.row]{
            cell.post = post
        }
        cell.shipperDelegate = self
        return cell
    }
    
    let activityIndicatorView:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
}

extension HomeShipperTableViewController : ShipperDelegate{
    func didCallOrderer(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") ,UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func didSavePost(post: Post , sender:UIButton) {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let context = delegate?.persistentContainer.viewContext
        // check post is exist
        let fetchPost:NSFetchRequest<Post> = Post.fetchRequest()
        fetchPost.predicate = NSPredicate(format: "postId = %@", post.postId!)
        if let fetchResults = try?context?.fetch(fetchPost){
            if fetchResults?.count == 0{
                sender.backgroundColor = UIColor.black
                do{
                    try context?.save()
                }catch let err{
                    print(err)
                }
            }else{
                let alert  = UIAlertController(title: "Lưu vào thư viện", message: "Bạn đã lưu bài đăng này từ trước ", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Đóng", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
            }
        }
    }
}








