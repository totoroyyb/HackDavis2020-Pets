//
//  ContentView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI
import Firebase

private struct ChatRow : View {
    var chatMessage: Chat
    var body: some View {
        Group {
            if !chatMessage.isMe {
                HStack {
                    Group {
                        Text(chatMessage.userName)
                        Text(chatMessage.messageContent)
                            .bold()
                            .padding(10)
                            .foregroundColor(Color.white)
                            .background(chatMessage.color)
                            .cornerRadius(10)
                    }
                }
            } else {
                HStack {
                    Group {
                        Spacer()
                        Text(chatMessage.messageContent)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(chatMessage.color)
                            .cornerRadius(10)
                        Text(chatMessage.userName)
                    }
                }
            }
        }
    }
}

struct ChatView : View {
    @State var composedMessage: String = ""
    @ObservedObject var chatController: ChatController
    
    var body: some View {
        VStack {
            List {
                ForEach(chatController.messages, id: \.self) { msg in
                    ChatRow(chatMessage: msg)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 44)
            .listSeparatorStyleNone()
            
            HStack {
                TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(30))
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .frame(minHeight: CGFloat(50))
            .padding()
        }
        .onAppear(perform: self.chatController.retrieveMessage)
    }
    
    func sendMessage() {
        chatController.sendMessage(Chat(messageContent: composedMessage, userName: (Auth.auth().currentUser?.email)!, color: .green, isMe: true, receiveUsername: ""))
        composedMessage = ""
    }
}


struct ChatView_Previews : PreviewProvider {
    static var previews: some View {
        ChatView(chatController: ChatController())
    }
}
