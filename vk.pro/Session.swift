//
//  Session.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 27/06/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
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
            getUser(id: Session.instance.userId)
            UserDefaults.standard.set(userId, forKey: "userId")
        }
    }
        
    private init() {
        deleteAll()
        //print(realm.configuration.fileURL)
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
                self.addObjects(array: value.response?.users ?? [])
            case .failure(let error):
                print(error)
            }
            completionBlock()
        }
    }
    
    func getUser(id: Int)  {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/users.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(Session.instance.userId)"),
            URLQueryItem(name: "fields", value: "id,photo_50,first_name,last_name"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.101")
        ]
        AF.request(urlComponents).responseObject { (vkResponse: DataResponse<VKRootResponse>) in
            let result = vkResponse.result
            switch result {
            case .success(let value):
                Session.instance.user = value.users.first
                Session.instance.addUserFB()
            case .failure(let error):
                print(error)
            }
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
                completionBlock(value.response?.photos ?? [])
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
                self.addObjects(array: value.response?.groups ?? [])
            case .failure(let error):
                print(error)
            }
            completionBlock()
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
                completionBlock(value.response?.groups ?? [])
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
