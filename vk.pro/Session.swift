//
//  Session.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 27/06/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import Alamofire
import SwiftKeychainWrapper
import RealmSwift
import FirebaseDatabase

class Session {
    static let instance = Session()
    var user: User!
    
    var token: String = "" {
        didSet {
            KeychainWrapper.standard.set(token, forKey: "token")
        }
    }
    var userId: Int = 0  {
        didSet {
            getUser(id: Session.instance.userId) { _ in }
            UserDefaults.standard.set(userId, forKey: "userId")
        }
    }
        
    private init() {
        deleteAll()
        
        
        //Realm.Configuration.defaultConfiguration.(deleteRealmIfMigrationNeeded: true)
//        do {
//            print(try Realm().configuration.fileURL)
//        } catch {
//
//        }
    }
    
    // MARK: - VK QUERYS
    
    func getFriends(completionBlock: @escaping () -> Void)  {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "fields", value: "id,photo_50,first_name,last_name"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.95")
        ]
        AF.request(urlComponents).responseObject { (vkResponse: DataResponse<VKResponse>) in
            let result = vkResponse.result
            switch result {
            case .success(let value):
                self.addObjects(array: value.items?.users ?? [])
            case .failure(let error):
                print(error)
            }
            completionBlock()
        }
    }
    
    func getUser(id: Int, completion: @escaping (User) -> Void)  {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/users.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(id)"),
            URLQueryItem(name: "fields", value: "id,photo_50,first_name,last_name"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.101")
        ]
        AF.request(urlComponents).responseObject { (vkResponse: DataResponse<VKResponse>) in
            let result = vkResponse.result
            switch result {
            case .success(let value):
                if Session.instance.user == nil {
                    Session.instance.user = value.users.first
                    Session.instance.addUserFB()
                }
                //
                completion(value.users.first ?? User())
            case .failure(let error):
                print(error)
            }
            completion(User())
        }
    }
    
    func getNews(completionBlock: @escaping ([News]) -> Void)  {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.101")
        ]
        print(urlComponents)
        AF.request(urlComponents).responseObject { (vkResponse: DataResponse<VKResponse>) in
            let result = vkResponse.result
            switch result {
            case .success(let value):
                //self.addObjects(array: value.items?.news ?? [])
                completionBlock(value.items?.news ?? [])
                break
            case .failure(let error):
                print(error)
            }
            completionBlock([])
        }
    }
    
    func getPhotos(ownerId: Int, completionBlock: @escaping ([Photo]) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(ownerId)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.95")
        ]
        
        AF.request(urlComponents).responseObject { (vkResponse: DataResponse<VKResponse>) in
            let result = vkResponse.result
            switch result {
            case .success(let value):
                completionBlock(value.items?.photos ?? [])
            case .failure(let error):
                print(error)
                completionBlock([])
            }
        }
    }
    
    func getGroups(completionBlock: @escaping () -> Void)  {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.95")
        ]
        
        AF.request(urlComponents).responseObject { (vkResponse: DataResponse<VKResponse>) in
            let result = vkResponse.result
            switch result {
            case .success(let value):
                self.addObjects(array: value.items?.groups ?? [])
            case .failure(let error):
                print(error)
            }
            completionBlock()
        }
    }
    
    func getGroupById(id: Int, completionBlock: @escaping (Group) -> Void)  {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "group_id", value: "\(id)"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.101")
        ]
        
        AF.request(urlComponents).responseObject { (vkResponse: DataResponse<VKResponse>) in
            let result = vkResponse.result
            switch result {
            case .success(let value):
                completionBlock(value.group.first ?? Group())
            case .failure(let error):
                print(error)
            }
            completionBlock(Group())
        }
    }
    
    func searchGroup(keyword: String, completionBlock: @escaping ([Group]) -> Void)  {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: keyword),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.95")
        ]
        
        AF.request(urlComponents).responseObject { (vkResponse: DataResponse<VKResponse>) in
            let result = vkResponse.result
            switch result {
            case .success(let value):
                completionBlock(value.items?.groups ?? [])
            case .failure(let error):
                print(error)
                completionBlock([])
            }
        }
    }
    
    // MARK: - Realm
    func getObjects(type: Object.Type) -> Results<Object> {
        do {
            return try Realm().objects(type)
        } catch {
            print(error)
            return try! Realm().objects(type)
        }
    }
    
    func addObjects(array: Array<Object>)   {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(array, update: .all)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAll()  {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
    func deleteObject(object: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Firebase QUERYS
    
    func addUserFB() {
        let databaseRef = Database.database().reference()
        for (key, value) in user.toJSON() {
            if key == "id" { continue }
            databaseRef.child("users/\(userId)/\(key)").setValue(value)
        }
    }
    
    func addGroupToUserFB(group: Group) {
        let databaseRef = Database.database().reference()
        for (key, value) in group.toJSON() {
            if key == "id" { continue }
            databaseRef.child("users/\(userId)/join_groups/\(group.id)/\(key)").setValue(value)
        }
    }
}
