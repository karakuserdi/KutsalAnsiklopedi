//
//  Title.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 2.01.2022.
//

import Foundation

struct Title{
    var uid:String
    var titleId:String
    var title:String
    var titleContent:String
    var dateStamp:Date!
    
    let user:User
    
    init(user:User,titleId:String, dictionary:[String:Any]){
        self.user = user
        self.titleId = titleId
        self.title = dictionary["title"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.titleContent = dictionary["titleContent"] as? String ?? ""
        
        if let dateStamp = dictionary["dateStamp"] as? Double {
            self.dateStamp = Date(timeIntervalSince1970: dateStamp)
        }
    }
}

