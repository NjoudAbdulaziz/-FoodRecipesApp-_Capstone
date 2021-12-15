//
//  Extension+String.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 11/05/1443 AH.
//

import Foundation


extension String {
    var url: URL? {
        return URL(string: self)
    }
}
