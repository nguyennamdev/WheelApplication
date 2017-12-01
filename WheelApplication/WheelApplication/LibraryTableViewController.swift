//
//  LibraryTableViewController.swift
//  WheelApplication
//
//  Created by Nguyen Nam on 12/1/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

class LibraryTableViewController: UITableViewController {

    let cellId = "CellId"
    var context:NSManagedObjectContext?
    var posts:[Post]?{
        didSet{
            print(posts?.count)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchPost:NSFetchRequest<Post> = Post.fetchRequest()
        do{
            posts = [Post]()
            posts = try!context?.fetch(fetchPost)
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "She is like a hedgehog "
        return cell
    }

   
}
