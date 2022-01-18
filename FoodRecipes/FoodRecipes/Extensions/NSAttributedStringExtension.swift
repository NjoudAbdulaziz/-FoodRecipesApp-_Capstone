//
//  NSAttributedStringExtension.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 15/06/1443 AH.
//

import Foundation

extension NSAttributedString {
    static func makeHyperlink(for path: String, in string:String, as substring: String) -> NSAttributedString{
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attrbutedSrring = NSMutableAttributedString(string: string)
        attrbutedSrring.addAttribute(.link, value: path, range: substringRange)
        return attrbutedSrring
    }
}
