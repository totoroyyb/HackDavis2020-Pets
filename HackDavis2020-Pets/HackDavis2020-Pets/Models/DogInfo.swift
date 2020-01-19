//
//  File.swift
//  HackDavisDemo
//
//  Created by Xiyu Zhang on 1/18/20.
//  Copyright © 2020 Xiyu Zhang. All rights reserved.
//

import Foundation

struct DogInfo: Identifiable {
    let id = UUID()
    var imageName = "placeholder"
    var name = "Unknown"
    var type = "Unknown"
    var age  = "Unknown"
    var disabled: Bool
//    var vaccinationCondition:
    
    static var demoModel = [DogInfo(imageName: "Max", name: "Max", age: "1 year and 8 month", disabled: false),
                            DogInfo(imageName: "Charlie", name: "Charlie", age: "3 years old", disabled: true),
                            DogInfo(imageName: "Bill", name: "Bill", age: "4 years old", disabled: false),
                            DogInfo(imageName: "Hero", name: "Hero", age: "3 years old", disabled: false),
                            DogInfo(imageName: "Lucky", name: "Lucky", age: "1 year and 2 month", disabled: true),
                            DogInfo(imageName: "Steve", name: "Steve", age: "3 years old", disabled: true),
                            DogInfo(imageName: "Coco", name: "Coco", age: "2 year and 6 month", disabled: false),
                            DogInfo(imageName: "Miumiu", name: "Miumiu", age: "1 year old", disabled: false)]

}

