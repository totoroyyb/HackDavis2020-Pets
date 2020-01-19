//
//  Dogcontroller.swift
//  HackDavis2020-Pets
//
//  Created by failury on 1/19/20.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI
import FirebaseStorage
import Firebase
import FirebaseDatabase
import Combine
class DogInfos :ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    @Published var infos: [DogInfo] = []
    func getDogInfos(){
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Dogs")
        ref.observe(.childAdded, with: { (SnapShot) -> Void in
            let snapshot = SnapShot.value as! NSDictionary
            let age = snapshot["Age"] as! String
            let name = snapshot["NickName"] as! String
            let type = snapshot["Type"] as! String
            let disabled = ((snapshot["isdisabled"] as! String) == "false") ? false : true
            let ref = Storage.storage().reference().child("Dogs/"+name+".jpg")
            ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
                } else {
                    let image = UIImage(data: data!)
                    let dogInfo = DogInfo(imageName: image!, name: name, type: type, age: age, disabled: disabled)
                    self.infos.append(dogInfo)
                }
            }
        })
        didChange.send(())
    }
}
