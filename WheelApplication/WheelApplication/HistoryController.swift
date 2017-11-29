//
//  HistoryController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 11/20/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

class HistoryController : UITableViewController{
    
    var posts:[Post]?
    var user:User?
    var context:NSManagedObjectContext?
    let cellId = "historyCell"
    let restApiHandle = RestApiHandle.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("his did load")
        tableView.register(HistoryCell.self, forCellReuseIdentifier: cellId)
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchPost:NSFetchRequest<Post> = Post.fetchRequest()
        do{
            posts = [Post]()
            posts = try!context?.fetch(fetchPost)
            tableView.reloadData()
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (posts?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HistoryCell
        cell.post = posts![indexPath.row]
        cell.user = self.user!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var actions = [UITableViewRowAction]()
        /////////// MARK : Edit action /////////////////
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (tableViewRow, indexPath) in
            let homeOdererController = HomeOrdererController()
            homeOdererController.historyController = self
            homeOdererController.context = self.context
            homeOdererController.user = self.user
            homeOdererController.postHistory = self.posts?[indexPath.row]
            self.navigationController?.pushViewController(homeOdererController, animated: true)
            
        }
        editAction.backgroundColor = UIColor.purple
        /////////// MARK : Delete action /////////////////
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (rowAction, indexPath) in
            // delete post on web services
            self.restApiHandle.deletePost(postId: (self.posts?[indexPath.row].postId)!, completeHandle: { (isDeleted) in
                // do some thing when deleted post
            })
            self.context?.delete((self.posts?[indexPath.row])!)
            self.posts?.remove(at: indexPath.row)
            // save again coredata
            do {
                try self.context?.save()
            }catch let err{
                fatalError(err as! String)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        actions = [editAction, deleteAction]
        return actions
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Lịch sử đặt hàng"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Trở lại"
    }
    
}
