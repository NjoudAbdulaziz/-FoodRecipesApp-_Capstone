//
//  Localization.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 20/06/1443 AH.
//

import Foundation


extension String {
    
  var localized : String {
        
  return NSLocalizedString(self, comment: "")
        
    }
}
