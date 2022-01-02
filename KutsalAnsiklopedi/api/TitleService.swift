//
//  TitleService.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 2.01.2022.
//


import Firebase

struct TitleService{
    static let shared = TitleService()
    
    func uploadTitle(title:String,titleContent:String, completion:@escaping(Error?,DatabaseReference) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let values = [
            "uid": uid,
            "dateStamp": Int(NSDate().timeIntervalSince1970),
            "title":title,
            "titleContent": titleContent,
        ] as [String:Any]
        
        TITLE_REF.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTitle(completion: @escaping([Title]) -> Void){
        var titles = [Title]()
        
        TITLE_REF.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            
            let titleId = snapshot.key
            
            
            UserService.shared.fetchUser(uid: uid) { user in
                let title = Title(user: user, titleId: titleId, dictionary: dictionary)
                titles.append(title)
                
                completion(titles)
            }
        }
        
    }
}

