//
//  Extensions.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit

extension NSAttributedString{
    func attributedString(first:String,second:String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: first, attributes: [.font:UIFont.systemFont(ofSize: 15)])
        
        attributedText.append(NSAttributedString(string: second, attributes: [.font:UIFont.boldSystemFont(ofSize: 15),.foregroundColor: UIColor.orange]))
        return attributedText
    }
}

extension UIViewController{
    func alertTimer(title:String?,mesaj:String?){
        let alert = UIAlertController(title: "", message: mesaj, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1.5
        DispatchQueue.main.asyncAfter(deadline: when){
          alert.dismiss(animated: true, completion: nil)
        }
    }
}
