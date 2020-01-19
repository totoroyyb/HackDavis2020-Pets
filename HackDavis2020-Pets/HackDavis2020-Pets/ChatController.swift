//
//  ChatController.swift
//  HackDavis2020-Pets
//
//  Created by failury on 1/18/20.
//  Copyright © 2020 iDEX. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import FirebaseDatabase
import Firebase

class ChatController : ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()

    @Published var messages = [
        Chat(messageContent: "Hello world", userName: "A", color: .red, receiveUsername: ""),
        Chat(messageContent: "Hi", userName: "B", color: .blue, receiveUsername: "")
    ]
    
    func sendMessage(_ chatMessage: Chat) {
        messages.append(chatMessage)
        var DB: DatabaseReference!
        DB = Database.database().reference().child("Messages")
        let messagePacket = ["Sender" : Auth.auth().currentUser?.email,"Reciever": chatMessage.receiveUsername,"Message": chatMessage.messageContent]
        DB.childByAutoId().setValue(messagePacket){
            (error,reference) in
            if error != nil{
                print(error!)
            } else {
                print("Message saved successfully!")
            }
        }
        didChange.send(())
    }
    
}
