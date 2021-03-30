//
//  TableViewCell.swift
//  CoffeeTek
//
//  Created by Chamnab Eang on 15/3/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageCell.showAnimatedGradientSkeleton()
        labelCell.showAnimatedGradientSkeleton()
        accessoryView?.tintColor = .brown
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
