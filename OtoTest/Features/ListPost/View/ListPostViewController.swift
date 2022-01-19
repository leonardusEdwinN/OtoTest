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
    @IBOutlet weak var addPostButton: UIButton!
    
    @IBAction func addPostButtonPressed(_ sender: Any) {
        self.isEdit = false
        self.performSegue(withIdentifier: "goToCreatePost", sender: ListPostViewController.self)
        
    }
    var listPostVM = ListPostViewModel()
    var selectedIndex : Int = 0
    var isEdit : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllPost()
        setupTableView()
        setUINavigation()
    }
    
    func setUINavigation(){
        navigationView.backgroundColor = UIColor.white
        navigationView.layer.shadowColor = UIColor.gray.cgColor
        navigationView.layer.shadowOffset = CGSize(width: 1, height: 1)
        navigationView.layer.shadowRadius = 1
        navigationView.layer.shadowOpacity = 5
    }
    
    func setupTableView(){
        listPosttableView.register(UINib.init(nibName: "ListPostItemTableViewCell", bundle: nil), forCellReuseIdentifier: "listPostItemTableViewCell")
        listPosttableView.delegate = self
        listPosttableView.dataSource = self
        
    }
    
    func getAllPost(){
        
        LoadingScreen.sharedInstance.showIndicator()
        
        listPostVM.getAllPost { _ in
            DispatchQueue.main.async {
                self.listPosttableView.reloadData()
                LoadingScreen.sharedInstance.hideIndicator()
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPostDetail"{
            if let destVC = segue.destination as? PostViewController {
                
                let listPostVM = listPostVM.modelAt(self.selectedIndex)
                destVC.postData = listPostVM.item
            }
        }else if segue.identifier == "goToCreatePost"{
            //you can edit or create data here
            if let destVC = segue.destination as? CreatePostViewController {
                destVC.lastCount = listPostVM.numberOfRows(0) + 1
                destVC.isEdit = self.isEdit
                destVC.postVM = listPostVM.modelAt(selectedIndex)
                destVC.delegate = self
                  
            }
        }
    }
    
    
    
}

extension ListPostViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("JUMLAH DATA : \(listPostVM.numberOfRows(section))")
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

            if let deletePostVM = self?.listPostVM.modelAt(indexPath.row){
                print("DELETED")
                
                deletePostVM.deleteData(title: deletePostVM.item.title, content: deletePostVM.item.content, id: "\(deletePostVM.item.id)", completion: { PostViewModel in
                    DispatchQueue.main.async {
                        self?.getAllPost()
                    }
                   
                })
            }
            
            

            
            completionHandler(true)
        }
        
        delete.image = UIImage(systemName: "trash")?.withTintColor(.white)
        delete.backgroundColor = UIColor.red
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])

        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal,
                                         title: "Edit") { [weak self] (action, view, completionHandler) in
            
            print("EDIT DATA \(indexPath.row)")
            //update data status
            self?.selectedIndex = indexPath.row
            self?.isEdit = true
            self?.performSegue(withIdentifier: "goToCreatePost", sender: self)
            
            
            completionHandler(true)
        }
        
        edit.image = UIImage(systemName: "pencil")?.withTintColor(.white)
        edit.backgroundColor = UIColor.systemGreen
        
        
        
        let configuration = UISwipeActionsConfiguration(actions: [edit])

        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        self.performSegue(withIdentifier: "goToPostDetail", sender: ListPostViewController.self)
    }
    
    
}


extension ListPostViewController : ReloadPostDataDelegate{
    func reloadDataAfterEditOrAdd() {
        print("ADD DATA BARU : \(selectedIndex)")
        getAllPost()
        DispatchQueue.main.async {
            
//            print("DATA UPDATE : \(self.listPostVM.modelAt(self.selectedIndex).item.id) \(self.listPostVM.modelAt(self.selectedIndex).item.title)")
            
            
            
        }
    }
    
    
}
