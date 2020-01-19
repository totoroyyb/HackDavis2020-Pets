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
    @Published var messages  = [Chat]()
    var didChange = PassthroughSubject<Void, Never>()
    func retrieveMessage()  {
        let DB = Database.database().reference().child("Messages")
        
        DB.observe(DataEventType .childAdded) { (DataSnapshot) in
            let snapshot = DataSnapshot.value as! NSDictionary
            let messageText = snapshot["Message"] as! String
            let sender = snapshot["Sender"] as! String
            if sender == Auth.auth().currentUser?.email
            {
                let chatMessage = Chat(messageContent: messageText , userName: "Me", color: .green, isMe: true, receiveUsername: "")
                self.messages.append(chatMessage)
            } else
            {
                let chatMessage = Chat(messageContent: messageText , userName: sender, color: .blue, isMe: false, receiveUsername: "")
                               self.messages.append(chatMessage)
            }
            
        }
        didChange.send(())
    }
    
    
    func sendMessage(_ chatMessage: Chat) {
        let DB = Database.database().reference().child("Messages")
//        let DB1 = Database.database().reference().child("Dogs")
//        DB1.childByAutoId().setValue(["NickName" : "Bailey","Age": "7","Type": "Chihuahua", "isDisable": "false", "Story": "She was lost in the woods when I found her", "ImageUrl":"www.google.com"])
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
