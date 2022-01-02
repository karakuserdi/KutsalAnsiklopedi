//
//  User.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 2.01.2022.
//

import Foundation

struct User{
    let email:String
    let username:String
    var profileImageUrl:URL?
    let uid:String
    
    init(uid:String ,dictionery: [String: AnyObject]){
        self.uid = uid
        
        self.email = dictionery["email"] as? String ?? ""
        self.username = dictionery["username"] as? String ?? ""
        
        if let profileImageURLString = dictionery["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageURLString) else {return}
            self.profileImageUrl = url
        }
    }
}
