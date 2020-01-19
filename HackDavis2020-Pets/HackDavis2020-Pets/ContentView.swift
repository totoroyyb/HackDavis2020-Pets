//
//  ContentView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var control: GlobalControl
    @State var isShowCreate = false
    @State var isSettingsOpened = false
    @ObservedObject var chatController = ChatController()
    
    var body: some View {
        ZStack {
            NavigationView {
                UnderMenu(back: {
                    AnyView(
                        MenuView(isSettingClicked: self.$isSettingsOpened)
                            .padding()
                            .padding(.vertical, 50)
                    )
                }) {
                    AnyView(
                        ZStack {
                            AdoptionView()
                            VStack {
                                Spacer()
                                Button(action: {
                                    self.isShowCreate.toggle()
                                }) {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 50, height: 50)
                                    .shadow(radius: 40)
                                }
                                .background(BlurView(style: .dark))
                                .clipShape(Circle())
                                .padding()
                            }
                            .padding(.bottom, 20)
                        }
                    )
                }
            }
            .sheet(isPresented: self.$isSettingsOpened) {
                SettingsView()
            }
            
            ChatView(chatController: self.chatController)
                .onAppear(perform: {self.chatController.retrieveMessage()})
            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
            .environmentObject(control)
                .offset(y: self.control.isChatRoomClicked ? 0 : UIScreen.main.bounds.height)
        
            ReportView()
            .background(Color.black)
            .offset(y: self.control.isReportedClicked ? 0 : UIScreen.main.bounds.height)
            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
            .environmentObject(control)
            .edgesIgnoringSafeArea(.all)
        
            CreatePost(isShow: $isShowCreate)
            .background(Color.black)
            .offset(y: self.isShowCreate ? 0 : UIScreen.main.bounds.height)
            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
            .transition(.move(edge: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Control)
    }
}
