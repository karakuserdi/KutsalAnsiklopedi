//
//  TitleCell.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 2.01.2022.
//

import UIKit
import SDWebImage

class TitleCell: UITableViewCell {
    var title:Title?{
        didSet{
            configure()
        }
    }
    
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabelView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleView.layer.masksToBounds = true
        titleView.layer.cornerRadius = 5
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 20
        profileImageView.backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(){
        guard let title = title else {return}
        
        titleLabel.text = title.title
        timeLabel.text = title.dateStamp
        contentLabel.text = title.titleContent
        profileImageView.sd_setImage(with: title.user.profileImageUrl, completed: nil)
        usernameLabel.text = title.user.username
    }

}
