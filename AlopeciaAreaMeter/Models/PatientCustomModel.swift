//
//  PatientCustomModel.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 29/03/2024.
//

import Foundation


struct PatientModel {
    var firstName: String = ""
    var lastName: String = ""
    var profileImg: String = ""
    
    init(firstName: String, lastName: String, profileImg: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.profileImg = profileImg
    }
}
