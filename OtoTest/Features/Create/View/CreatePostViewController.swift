//
//  CreatePost.swift
//  OtoTest
//
//  Created by Edwin Niwarlangga on 19/01/22.
//

import Foundation
import UIKit
protocol ReloadPostDataDelegate{
    func reloadDataAfterEditOrAdd()
}

class CreatePostViewController : UIViewController{
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var labelCreatePost: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBAction func buttonBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var labelPostTitle: UILabel!
    @IBOutlet weak var textfieldPostTitle: UITextField!
    @IBOutlet weak var labelPostContent: UILabel!
    @IBOutlet weak var textfieldPostContent: UITextField!
    
    @IBOutlet weak var buttonCreatePost: UIButton!
    @IBAction func buttonCreatePostPressed(_ sender: Any) {
        
        //cobain create data
        LoadingScreen.sharedInstance.showIndicator()
        
        let dateFormatter = DateFormatter()
        let date = dateFormatter.string(from: Date())
        
       
        
        if(isEdit){
            //melakukan update data
            if let postId = self.postVM?.item.id{
                print("TITLE UPDATE : \(textfieldPostTitle.text) :: \(textfieldPostContent.text)")
                postVM?.updateData(title: textfieldPostTitle.text ?? "", content: textfieldPostContent.text ?? "", id: "\(postId)", completion: { PostViewModel in
                    LoadingScreen.sharedInstance.hideIndicator()
                    self.dismiss(animated: true) {
                        self.delegate?.reloadDataAfterEditOrAdd()
                    }
                })
                
            }
            
            
        }else{
            print("ADD NEW DATA")
            
            let dataPost = Post(id: lastCount, title: textfieldPostTitle.text ?? "", content: textfieldPostContent.text ?? "", published_at: date , created_at: date , updated_at: date )
            
            postVM = PostViewModel(post: dataPost)
            
            postVM?.createNewPost(title: textfieldPostTitle.text ?? "", content: textfieldPostContent.text ?? "", completion: { PostViewModel in
                LoadingScreen.sharedInstance.hideIndicator()
                self.dismiss(animated: true) {
                    self.delegate?.reloadDataAfterEditOrAdd()
                }
            })
            
            
            
        }
        
    }
    
    var postVM : PostViewModel?
    var lastCount : Int = 0
    var isEdit : Bool = false
    var delegate : ReloadPostDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setUINavigation()
        
    }
    
    func setUI(){
        if(self.isEdit){
            //ada data,is edit true
            textfieldPostTitle.text = postVM?.item.title
            textfieldPostContent.text = postVM?.item.content
        }else{
            //is edit false
            textfieldPostTitle.text = ""
            textfieldPostContent.text = ""
        }
        
        buttonCreatePost.layer.cornerRadius = 15
        
    }
    
    func setUINavigation(){
        navigationView.backgroundColor = UIColor.white
        navigationView.layer.shadowColor = UIColor.gray.cgColor
        navigationView.layer.shadowOffset = CGSize(width: 1, height: 1)
        navigationView.layer.shadowRadius = 1
        navigationView.layer.shadowOpacity = 5
    }
    
}
