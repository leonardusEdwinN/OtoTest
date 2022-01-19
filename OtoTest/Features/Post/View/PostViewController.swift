//
//  PostViewController.swift
//  OtoTest
//
//  Created by Edwin Niwarlangga on 19/01/22.
//


import Foundation
import UIKit


class PostViewController : UIViewController{
    
    var postData : Post?
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postPublishedAt: UILabel!
    @IBOutlet weak var postContent: UILabel!
    
    @IBOutlet weak var navigationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setUINavigation()
        
        
    }
    
    
    func setData(){
        self.postTitle.text = self.postData?.title
        self.postContent.text = self.postData?.content
        
        if let publishedAt = self.postData?.published_at{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            dateFormatter.timeZone = TimeZone(abbreviation: "WIB")
            let dateTemp = dateFormatter.date(from: publishedAt)
            
            
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy HH:mm:ss"
            self.postPublishedAt.text = dateFormatter.string(from: dateTemp ?? Date())
        }
        
    }
    
    
    func setUINavigation(){
        navigationView.backgroundColor = UIColor.white
        navigationView.layer.shadowColor = UIColor.gray.cgColor
        navigationView.layer.shadowOffset = CGSize(width: 1, height: 1)
        navigationView.layer.shadowRadius = 1
        navigationView.layer.shadowOpacity = 5
    }
    
    
}
