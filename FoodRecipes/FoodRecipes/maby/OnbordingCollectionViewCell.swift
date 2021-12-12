//
//  OnbordingCollectionViewCell.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/05/1443 AH.
//

import UIKit

class OnbordingCollectionViewCell: UICollectionViewCell {
    
    static let  identifire = String(describing: OnbordingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitelLbl: UILabel!
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    
    
    func setup(_ slide: OnboardingSlide){
        slideImageView.image = slide.image
        slideTitelLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
    
}
