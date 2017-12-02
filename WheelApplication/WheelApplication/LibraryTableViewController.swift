//
//  LibraryTableViewController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 12/1/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData


class LibraryTableViewController: UITableViewController , ShipperDelegate{
    
    let cellId = "cellId"
    var post:[Post]?{
        didSet{
            tableView.reloadData()
        }
    }
    var context:NSManagedObjectContext?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.register(LibraryViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did apprear")
        let fetchPost:NSFetchRequest<Post> = Post.fetchRequest()
        fetchPost.predicate = NSPredicate(format: "isSave = %@", true as CVarArg)
        do{
            let posts = try context!.fetch(fetchPost)
            print("Count \(posts.count)")
            self.post = posts
        }catch let err{
            print(err)
        }
        navigationController?.navigationBar.topItem?.title = "Đơn hàng đã lưu"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LibraryViewCell
        cell.post = self.post?[indexPath.row]
        cell.user = self.post?[indexPath.row].user
        cell.shipperDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 255
    }
    
    func didCallOrderer(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") ,UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
}
