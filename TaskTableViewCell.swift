//
//  TaskTableViewCell.swift
//  ApiFatching
//
//  Created by Digvijay Nikam on 20/11/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LabelId: UILabel!
    
    @IBOutlet weak var LabelTitle: UILabel!
    
    @IBOutlet weak var LabelBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
