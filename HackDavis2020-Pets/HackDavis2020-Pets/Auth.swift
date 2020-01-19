//
//  Auth.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import Foundation
import Firebase

func SignInUser(email: String, password: String) {
    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
        if error != nil{
            print(error!)
        } else{
            print("register success")
        }
    }
}
