//
//  ChatCell.swift
//  Chatty
//
//  Created by Deniz Dilbilir on 04/10/2023.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var TextSpace: UIView!
    
    @IBOutlet weak var chattyLabel: UILabel!
    
    @IBOutlet weak var selfAvatar: UIImageView!
    
    @IBOutlet weak var youAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        TextSpace.layer.cornerRadius = TextSpace.frame.size.height/10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
}

