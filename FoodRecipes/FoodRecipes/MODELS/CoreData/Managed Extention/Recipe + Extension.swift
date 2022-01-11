//
//  Recipe + Extension.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 08/06/1443 AH.
//

import Foundation
import CoreData

extension Recipe {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
