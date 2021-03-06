//
//  UserService.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 2.01.2022.
//

import Foundation
import Firebase

struct UserService{
    static let shared = UserService()
    
    func fetchUser(uid:String, completion: @escaping(User) -> Void){
        //uid ye göre giriş yapmış olan kullanıcıyı çektik
        USERS_REF.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionery = snapshot.value as? [String:AnyObject] else {return}
            
            let user = User(uid: uid, dictionery: dictionery)
            
            completion(user)
        }
    }
    
    
}
