//
//  TitleViewModel.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 2.01.2022.
//

import UIKit

struct TitleViewModel{
    let title:Title
    let user:User
    
    init(title:Title){
        self.title = title
        self.user = title.user
    }
    
    var dateStamp:String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second,.minute,.hour,.day,.weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        formatter.calendar?.locale = Locale(identifier: "tr")
        let now = Date()
        return formatter.string(from: title.dateStamp, to: now) ?? "2m"
    }
    
    var profileImage: URL?{
        return user.profileImageUrl
    }
    
    var content: String?{
        return title.titleContent
    }
    
    var attributedString2: NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(user.username)", attributes: [.font:UIFont.boldSystemFont(ofSize: 15)])
        
        attributedText.append(NSAttributedString(string: " • \(dateStamp)", attributes: [.font:UIFont.systemFont(ofSize: 12),.foregroundColor: UIColor.darkGray]))
        return attributedText
    }
    
    
}
