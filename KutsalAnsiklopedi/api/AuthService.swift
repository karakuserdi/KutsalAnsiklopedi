//
//  AuthService.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit
import Firebase

struct User{
    let email:String
    let password:String
    let username:String
    let profileImage:UIImage
}

struct AuthService{
    static let shared = AuthService()
    
    func registerUser(user: User, completion: @escaping(Error?, DatabaseReference) -> Void){
        let email = user.email
        let password = user.password
        let username = user.username
        let profileImage = user.profileImage
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else {return}
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { meta, error in
            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else {return}
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error{
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let uid = result?.user.uid else {return}
                    let values = ["email": email, "username":username, "profileImageUrl":profileImageUrl]
                    
                    USERS_REF.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
