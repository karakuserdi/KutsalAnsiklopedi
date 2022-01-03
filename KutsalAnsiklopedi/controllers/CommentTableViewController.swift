//
//  CommentTableViewController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 3.01.2022.
//

import UIKit
import Firebase
import SDWebImage

class CommentTableViewController: UITableViewController {
    
    //MARK: - Properties
    var tites:Title?
    var comments = [Comment]()
    var expandedCells = [Int]()
    
    @IBOutlet weak var addCommentButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let tites = tites {
            self.navigationItem.prompt = tites.title
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchComments()
    }
    
    //MARK: - Helpers
    
    func fetchComments(){
        if let tites = tites {
            CommentService.shared.fetchComments(titleId: tites.titleId) { comments in
                self.comments = comments
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewComment"{
            let titId = sender as? String
            let destinationVC = segue.destination as! NewCommentViewController
            destinationVC.titleId = titId
        }
    }
    
    //MARK: - Actions
    @IBAction func addCommentButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toNewComment", sender: tites?.titleId)
    }
    
    @objc func deleteAction(_ sender: UIButton){
          // If the array contains the button that was pressed, then remove that button from the array
          if expandedCells.contains(sender.tag) {
              expandedCells = expandedCells.filter { $0 != sender.tag }
              sender.setTitle("show more", for: .normal)
          }
            // Otherwise, add the button to the array
          else {
              expandedCells.append(sender.tag)
              sender.setTitle("hide", for: .normal)
          }
          
          self.tableView.beginUpdates()
          self.tableView.endUpdates()
      }

    // MARK: - tableView datasource, delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        let comment = comments[indexPath.row]
        
        cell.selectionStyle = .none
        cell.showMoreButton.tag = indexPath.row
        cell.showMoreButton?.addTarget(self, action: #selector(deleteAction), for: UIControl.Event.touchUpInside)
        
        
        if comment.comment.count <= 70{
            cell.showMoreButton.isHidden = true
        }else{
            cell.showMoreButton.isHidden = false
        }
        
        cell.usernameLabel.text = "\(comment.user.username) - \(comment.date)"
        cell.commentLabel.text = comment.comment
        cell.profileImageView.sd_setImage(with: comment.user.profileImageUrl, completed: nil)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expandedCells.contains(indexPath.row) {
            return UITableView.automaticDimension
            } else {
                return 130
            }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
