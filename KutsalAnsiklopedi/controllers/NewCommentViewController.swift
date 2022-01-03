//
//  NewCommentViewController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 3.01.2022.
//

import UIKit

class NewCommentViewController: UIViewController {
    
    var titleId:String?
    
    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let titleId = titleId {
            print(titleId)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newCommentButtonPressed(_ sender: Any) {
        
        
        if let titleId = titleId, let comment = commentTextView.text{
            
            let todayDate = Date()
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "tr")
            formatter.dateFormat = "dd MMMM yyyy HH:mm"
            let today = formatter.string(from: todayDate)
            
            CommentService.shared.uploadComment(comment: comment, date: today, titleId: titleId) { error, ref in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }

}
