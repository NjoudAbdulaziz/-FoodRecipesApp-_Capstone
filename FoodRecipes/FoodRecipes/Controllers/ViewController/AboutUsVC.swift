//
//  AboutUsVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 24/05/1443 AH.
//

import UIKit

class AboutUsVC: UIViewController {

    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        //Background of The AboutUs Page
        imageView.image = UIImage(named: "1")

        updateTextView()
        
        // Start observing style change
        startObserving(&UserInterfaceStyleManager.shared)
    }
    func updateTextView(){
        let path = "https://twitter.com/Njoud06880782"
        let text = textView.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "Twitter".localized)
        let font = textView.font
        let textColor = textView.textColor
        textView.attributedText = attributedString
        textView.font = font
        textView.textColor = textColor
    }
}
