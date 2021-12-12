//
//  OnboardingVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 07/05/1443 AH.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var slides : [OnboardingSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func nextBtnClicked(_ sender: UIButton) {
    }
    
}

//extension OnboardingVC : UICollectionViewDelegate , UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //return.slides.count
//        return
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnbordingCollectionViewCell.identifire, for: indexPath) as! OnbordingCollectionViewCell
//        cell.setup(slides[indexPath.row])
//        return cell
//    }
//    
//
//}








extension UIView {
 @IBInspectable var cornerRadius: CGFloat{
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
