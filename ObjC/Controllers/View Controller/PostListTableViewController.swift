//
//  PostListTableViewController.swift
//  ObjC
//
//  Created by Deniz Tutuncu on 2/13/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    var posts: [DSTPost] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
            DSTPostController.shared().serchForPost(withSearchTerm: "California") { (posts, error) in
                self.posts = posts
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = posts[indexPath.row]
        cell.post = post
        
        DSTPostController.shared().fetchImagePost(post) { (image) in
            

            DispatchQueue.main.async {
                cell.thumbnail = image
            }
        }
        
        return cell
    }
    //Bu func onemli cunku ui icin otomatik buyume ya da kuculme sagliyor.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PostListTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DSTPostController.shared().serchForPost(withSearchTerm: searchText) { (posts, error) in
            self.posts = posts
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.title = searchText
            }
        }
        searchBar.text = ""
    }
}
