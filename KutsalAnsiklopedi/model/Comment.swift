//
//  Comment.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 3.01.2022.
//

import Foundation

struct Comment{
    var uid:String
    var titleId:String
    var commentId:String
    var comment:String
    var like:Int
    var date:String
    
    let user:User
    
    init(user:User,uid:String,titleId:String,commentId:String,comment:String,like:Int,date:String){
        self.user = user
        self.uid = uid
        self.titleId = titleId
        self.commentId = commentId
        self.comment = comment
        self.like = like
        self.date = date
    }
}
