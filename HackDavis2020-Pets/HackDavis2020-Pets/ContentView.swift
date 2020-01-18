//
//  ContentView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI

public struct ListSeparatorStyleNoneModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content.onAppear {
            UITableView.appearance().separatorStyle = .none
        }.onDisappear {
            UITableView.appearance().separatorStyle = .singleLine
        }
    }
}
extension View {
    public func listSeparatorStyleNone() -> some View {
        modifier(ListSeparatorStyleNoneModifier())
    }
}
struct Chat : Hashable {
    var messageContent: String
    var userName: String
    var color: Color
    var isMe: Bool = false
}

struct ChatRow : View {
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

struct ContentView : View {
    @State var composedMessage: String = ""
    @ObservedObject var chatController: ChatController
    var body: some View {
        
        VStack {
            List(){
                ForEach(chatController.messages, id: \.self) { msg in
                    ChatRow(chatMessage: msg)
                }
            }.listSeparatorStyleNone()
            
            
            HStack {
                TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(30))
                Button(action: sendMessage) {
                    Text("Send")
                }
            }.frame(minHeight: CGFloat(50)).padding()
        }
    }
    func sendMessage() {
        chatController.sendMessage(Chat(messageContent: composedMessage, userName: "C", color: .green, isMe: true))
        composedMessage = ""
    }
}


struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(chatController: ChatController())
            .environmentObject(ChatController())
    }
}
