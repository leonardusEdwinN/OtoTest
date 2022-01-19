//
//  ListPostItemTableViewCell.swift
//  OtoTest
//
//  Created by Edwin Niwarlangga on 19/01/22.
//

import UIKit

class ListPostItemTableViewCell: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPublishedAt: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetUI()
    
        outerView.backgroundColor = UIColor.white
        outerView.layer.cornerRadius = 15.0
        outerView.layer.shadowColor = UIColor.gray.cgColor
        outerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        outerView.layer.shadowRadius = 1
        outerView.layer.shadowOpacity = 5
        
       
        // Initialization code
    }
    
    func resetUI(){
        self.labelTitle.text = ""
        self.labelPublishedAt.text = ""
        self.labelContent.text = ""
    }
    
    func setUI(title: String, publishedAt : String, content: String){
        
        self.labelTitle.text = title
        self.labelContent.text = content
        
        let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
       dateFormatter.timeZone = TimeZone(abbreviation: "WIB")
       let dateTemp = dateFormatter.date(from: publishedAt)


       dateFormatter.dateFormat = "EEEE, MMM d, yyyy HH:mm:ss"
       self.labelPublishedAt.text = "Published At : \(dateFormatter.string(from: dateTemp ?? Date()))"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
