//
//  RegisterViewController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var addProfileImageView: UIImageView!
    @IBOutlet weak var alreadyHaveAnAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        
    }
    
    func configureUI(){
        addProfileImageView.layer.cornerRadius = 75
        addProfileImageView.layer.masksToBounds = true
        
        alreadyHaveAnAccountButton.setAttributedTitle(NSAttributedString().attributedString(first: "Already have an account? ", second: "Log In"), for: .normal)
    }

    
    @IBAction func alreadyHaveAnAccountButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
