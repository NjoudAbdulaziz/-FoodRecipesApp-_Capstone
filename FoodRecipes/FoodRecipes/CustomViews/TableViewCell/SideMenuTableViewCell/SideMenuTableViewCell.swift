//
//  SideMenuTableViewCell.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 24/05/1443 AH.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    class var identifire: String {return String(describing: self) }
    class var nib: UINib {return UINib(nibName: identifire, bundle: nil)}
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
         //background
        self.backgroundColor = .clear
        
        //Icon
        self.iconImageView.tintColor = .white
        
        //Title
        self.titleLabel.textColor = .white
        
    }
    
}
