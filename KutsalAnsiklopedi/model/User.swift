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
    let profileImageUrl:String
    let uid:String
    
    init(uid:String ,dictionery: [String: AnyObject]){
        self.uid = uid
        
        self.email = dictionery["email"] as? String ?? ""
        self.username = dictionery["username"] as? String ?? ""
        self.profileImageUrl = dictionery["profileImageUrl"] as? String ?? ""
    }
}
