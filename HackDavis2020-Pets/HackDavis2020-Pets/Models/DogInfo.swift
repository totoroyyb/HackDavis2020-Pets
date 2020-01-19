//
//  File.swift
//  HackDavisDemo
//
//  Created by Xiyu Zhang on 1/18/20.
//  Copyright © 2020 Xiyu Zhang. All rights reserved.
//

import Foundation
import UIKit
struct DogInfo: Identifiable,Hashable {
    let id = UUID()
    var imageName : UIImage
    var name = "Unknown"
    var type = "Unknown"
    var age  = "Unknown"
    var disabled: Bool
//    var vaccinationCondition:
}
