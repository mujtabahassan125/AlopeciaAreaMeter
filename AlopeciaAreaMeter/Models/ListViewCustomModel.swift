//
//  ListViewCustomModel.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 27/03/2024.
//

import Foundation


struct ListModel {
    var title: String = ""
    var image: String = ""
    var hint: String = ""
    
    
    init(title: String, image: String, hint: String) {
        self.title = title
        self.image = image
        self.hint = hint
    }
}
