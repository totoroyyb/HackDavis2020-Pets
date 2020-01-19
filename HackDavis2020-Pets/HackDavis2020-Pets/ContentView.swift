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
    
    var body: some View {
        ZStack {
            NavigationView {
                UnderMenu(back: {
                    AnyView(
                        MenuView()
                            .padding()
                            .padding(.vertical, 50)
                    )
                }) {
                    AnyView(AdoptionView())
                }
            }
            
            ChatView(chatController: ChatController())
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .offset(y: self.control.isChatRoomClicked ? 0 : UIScreen.main.bounds.height)
                
                .environmentObject(control)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
