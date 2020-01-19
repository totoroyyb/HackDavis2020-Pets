//
//  ContentView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class KeyboardObserver: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    @Published private(set) var keyboardHeight: CGFloat = 0
    
    let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }
    
    let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ -> CGFloat in 0 }
    
    init() {
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.keyboardHeight, on: self)
    }
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
                        Spacer()
                        VStack{Text(chatMessage.userName)
                            Text(chatMessage.messageContent)
                                .bold()
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(chatMessage.color)
                                .cornerRadius(10)
                            
                        }
                        
                        
                    
                }
            }
        }
    }
}

struct ChatView : View {
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    @State var composedMessage: String = ""
    @ObservedObject var chatController : ChatController
    @EnvironmentObject var control: GlobalControl
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(chatController.messages, id: \.self) { msg in
                        ChatRow(chatMessage: msg)
                    }
                }
                .listSeparatorStyleNone()
                
                HStack {
                    TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(40))
                    Button(action: sendMessage) {
                        Text("Send")
                    }
                }
                .frame(minHeight: CGFloat(50))
                .padding()
                .background(Color.black)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.control.isChatRoomClicked.toggle()
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: {self.chatController.retrieveMessage()}).padding(.bottom, keyboardObserver.keyboardHeight)
            .onTapGesture {
                UIApplication.shared.endEditing()
        }
    }
    
    func sendMessage() {
        UIApplication.shared.endEditing()
        if(composedMessage != "") {
            chatController.sendMessage(Chat(messageContent: composedMessage, userName: (Auth.auth().currentUser?.email)!, color: .green, isMe: true, receiveUsername: ""))
        }
        composedMessage = ""
    }
}


struct ChatView_Previews : PreviewProvider {
    static var previews: some View {
        ChatView(chatController: ChatController())
    }
}
