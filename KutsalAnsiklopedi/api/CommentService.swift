//
//  CommentService.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 3.01.2022.
//

import Firebase

struct CommentService{
    static let shared = CommentService()
    
    func uploadComment(comment:String,date:String,titleId:String,completion:@escaping(Error?,DatabaseReference) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let values = [
            "uid": uid,
            "date": date,
            "comment": comment,
            "titleId":titleId,
            "like":0
        ] as [String:Any]
        
        COMMENT_REF.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    
    func fetchComments(titleId:String,completion: @escaping([Comment]) -> Void){
        var comments = [Comment]()
        let query = COMMENT_REF.queryOrdered(byChild: "titleId").queryEqual(toValue: titleId)
        
        query.observe(.value) { snapshot in
            let key = snapshot.key
            if let dictionery = snapshot.value as? [String:Any] {
                for dic in dictionery{
                    if let data = dic.value as? NSDictionary{
                        let comment = data["comment"] as? String ?? ""
                        let uid = data["uid"] as? String ?? ""
                        let titleId = data["titleId"] as? String ?? ""
                        let like = data["like"] as? Int ?? 0
                        let date = data["date"] as? String ?? ""
                        
                        UserService.shared.fetchUser(uid: uid) { user in
                            let com = Comment(user: user, uid: uid, titleId: titleId, commentId: key, comment: comment, like: like, date: date)
                            
                            comments.append(com)
                            
                            completion(comments)
                        }
                    }
                }
            }
        }
    }
}

