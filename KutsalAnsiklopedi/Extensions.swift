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
