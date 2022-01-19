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
    
    func createNewPost(title: String, content : String, completion: @escaping (PostViewModel) -> Void) {
        let json: [String: Any] = ["title": title,
                                   "content": content]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        var urlRequest = URLRequest(url:  Constants.Urls.urlForGetAllPost())
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        
        print("ADD NEW POST DATA FROM JSON :\(json) : \(urlRequest)")
        Webservice().loadPOST(resource: urlRequest) { (result) in
            
            
            if let postResult = result {
                do{
                    let dataDecoder = try JSONDecoder().decode(Post.self, from: postResult)
                    let postVM = PostViewModel(post: dataDecoder)
                       completion(postVM)
                  } catch let parsingError {
                     print("Error", parsingError)
                }
            }
        }
        
    }
    
    func updateData(title: String, content : String, id: String, completion: @escaping (PostViewModel) -> Void) {
        let json: [String: Any] = ["title": title,
                                   "content": content]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        var urlRequest = URLRequest(url:  Constants.Urls.urlForUpdateDelete(id: "\(id)"))
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "PUT"
        urlRequest.httpBody = jsonData
        
        
        Webservice().loadPOST(resource: urlRequest) { (result) in
            
            
            if let postResult = result {
                do{
                    let dataDecoder = try JSONDecoder().decode(Post.self, from: postResult)
                    let postVM = PostViewModel(post: dataDecoder)
                       completion(postVM)
                  } catch let parsingError {
                     print("Error", parsingError)
                }
            }
        }
        
    }
    
    
    func deleteData(title: String, content : String, id: String, completion: @escaping (PostViewModel) -> Void) {
        let json: [String: Any] = ["title": title,
                                   "content": content]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        var urlRequest = URLRequest(url:  Constants.Urls.urlForUpdateDelete(id: "\(id)"))
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "DELETE"
        urlRequest.httpBody = jsonData
        
        
        Webservice().loadPOST(resource: urlRequest) { (result) in
            
            
            if let postResult = result {
                do{
                    let dataDecoder = try JSONDecoder().decode(Post.self, from: postResult)
                    let postVM = PostViewModel(post: dataDecoder)
                       completion(postVM)
                  } catch let parsingError {
                     print("Error", parsingError)
                }
            }
        }
        
    }
}

