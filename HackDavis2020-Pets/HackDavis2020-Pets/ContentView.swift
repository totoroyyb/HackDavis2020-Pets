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
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
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
    var receiveUsername: String
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
    @ObservedObject private var keyboardObserver = KeyboardObserver()
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
                TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(40))
                Button(action: sendMessage) {
                    Text("Send")
                }
            }.frame(minHeight: CGFloat(50)).padding()
        }.onAppear(perform: {self.chatController.retrieveMessage()}).padding(.bottom, keyboardObserver.keyboardHeight)
            .animation(.easeInOut(duration: 0.3)).onTapGesture {
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


struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(chatController: ChatController())
            .environmentObject(ChatController())
    }
}
