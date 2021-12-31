//
//  TabBarController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 56 / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //cikisyap()
        configureUI()
    }
    
    func configureUI(){
        view.addSubview(addButton)
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    @objc func addButtonPressed(){
        authenticateUserAndConfigUI()
    }
    
    //MARK: - api
    func authenticateUserAndConfigUI(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = mainStoryBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
        }else {
            alertAction(title: "Vay be", mesaj: "Aramıza tekrar hoş geldin :)")
        }
    }
    
    func cikisyap(){
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
