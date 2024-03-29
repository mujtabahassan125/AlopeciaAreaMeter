//
//  PatientRecordModel.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 29/03/2024.
//

import Foundation


struct PatientRecordModel {
    var date: String = ""
    var value: Double = 0
    
    init(date: String, value: Double) {
        self.date = date
        self.value = value
    }
}
