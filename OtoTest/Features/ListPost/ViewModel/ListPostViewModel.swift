//
//  ListPostViewModel.swift
//  OtoTest
//
//  Created by Edwin Niwarlangga on 19/01/22.
//

import Foundation

class ListPostViewModel{
    private var postResponseVM = [PostViewModel]()

    
    func numberOfRows(_ section: Int) -> Int {
        return postResponseVM.count
    }
    
    func modelAt(_ index: Int) -> PostViewModel {
        return postResponseVM[index]
    }
    
    func getAllPost(completion: @escaping ([PostViewModel]) -> Void) {
        
        print("START FETCHING DATA")
        if(postResponseVM.count > 0){
            postResponseVM = []
        }
        
        let searchUrl = Constants.Urls.urlForGetAllPost()
        
        let postResource = Resource<[Post]>(url: searchUrl) { data in
            let postResponses = try? JSONDecoder().decode([Post].self, from: data)
            return postResponses
        }
        
        Webservice().load(resource: postResource) { (result) in
            
            if let postResource = result {
                for post in  postResource {
                    
                    self.postResponseVM.append(PostViewModel(post: post))
                }
                
                completion(self.postResponseVM)
            }
        }
        
    }
    
    
    
}


class PostViewModel {

    let item: Post

    init(post: Post) {
        self.item = post
    }
}

