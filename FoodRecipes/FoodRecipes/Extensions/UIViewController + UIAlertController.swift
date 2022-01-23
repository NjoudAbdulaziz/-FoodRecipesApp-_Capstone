//
//  UIViewController + UIAlertController.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/06/1443 AH.
//

import Foundation
import CoreData
import UIKit

//MARK:-A UIViewController extension to hold a global showErrorAlert dialog
extension UIViewController  {
    
    //MARK:-showAlert Dialog
    /*
     show an alert message
     */
    
    func showAlertDialog(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //Open The External Website like recipe source and youtube video
    func openExternalUrl(url:String) {
        if verifyUrl(urlString: url) {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    
    //MARK:- check if Recipe exists
    func recipeExists(recipeId: String) -> Bool? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Recipe")
        fetchRequest.predicate = NSPredicate(format: "id == %@", recipeId)
        var results: [NSManagedObject] = []
        
        do {
            results = try DataController.shared.viewContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        print("fetch request: \(results.count)")
        return results.count > 0
    }
}

// Saved Recipes TableView
extension UITableView {
    func setEmptyView(title: String, message: String, messageImage: UIImage) {
           
           let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
           
           let messageImageView = UIImageView()
           let titleLabel = UILabel()
           let messageLabel = UILabel()
           
           messageImageView.backgroundColor = .clear
           
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           messageImageView.translatesAutoresizingMaskIntoConstraints = false
           messageLabel.translatesAutoresizingMaskIntoConstraints = false
           
        titleLabel.textColor = UIColor.lightGray
           titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
           
           messageLabel.textColor = UIColor.lightGray
           messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
           
           emptyView.addSubview(titleLabel)
           emptyView.addSubview(messageImageView)
           emptyView.addSubview(messageLabel)
           
           messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
           messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
           messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
           messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
           
           titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
           titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
           
           messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
           messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
           
           messageImageView.image = messageImage
           titleLabel.text = title
           messageLabel.text = message
           messageLabel.numberOfLines = 0
           messageLabel.textAlignment = .center
           
           UIView.animate(withDuration: 1, animations: {
               
               messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
           }, completion: { (finish) in
               UIView.animate(withDuration: 1, animations: {
                   messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
               }, completion: { (finishh) in
                   UIView.animate(withDuration: 1, animations: {
                       messageImageView.transform = CGAffineTransform.identity
                   })
               })
               
           })
           
           self.backgroundView = emptyView
           self.separatorStyle = .none
       }
       
       func restore() {
           
           self.backgroundView = nil
           self.separatorStyle = .singleLine
           
       }
}
