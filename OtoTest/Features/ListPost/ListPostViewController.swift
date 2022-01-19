//
//  ListPostViewController.swift
//  OtoTest
//
//  Created by Edwin Niwarlangga on 19/01/22.
//

import Foundation
import UIKit


class ListPostViewController : UIViewController{
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var listPosttableView: UITableView!
    
    var listPostVM = ListPostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllPost()
        LoadingScreen.sharedInstance.showIndicator()
        
        setupTableView()
    }
    
    func setupTableView(){
        listPosttableView.register(UINib.init(nibName: "ListPostItemTableViewCell", bundle: nil), forCellReuseIdentifier: "listPostItemTableViewCell")
        listPosttableView.delegate = self
        listPosttableView.dataSource = self
        
    }
    
    func getAllPost(){
        listPostVM.getAllPost { _ in
            DispatchQueue.main.async {
                self.listPosttableView.reloadData()
                LoadingScreen.sharedInstance.hideIndicator()
            }
        }
    }
    
    
    
}

extension ListPostViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPostVM.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listPostItemTableViewCell", for: indexPath) as! ListPostItemTableViewCell
        
        let data = listPostVM.modelAt(indexPath.row)
        cell.setUI(title: data.item.title, publishedAt: data.item.published_at, content: data.item.content)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        // Delete Action action
        let delete = UIContextualAction(style: .normal,
                                         title: "Delete") { [weak self] (action, view, completionHandler) in

            if let deletePost = self?.listPostVM.modelAt(indexPath.row){
                print("DELETED")
            }

            
            completionHandler(true)
        }
        
        delete.image = UIImage(systemName: "trash")?.withTintColor(.white)
        delete.backgroundColor = UIColor.red
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])

        return configuration
    }
    
    
}
