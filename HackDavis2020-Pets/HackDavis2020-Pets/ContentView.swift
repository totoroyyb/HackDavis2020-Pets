//
//  ContentView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI

struct Chat: Hashable {
    var userName: String
    var messageContent: String
}
struct ContentView: View {
    var chatContent = [ Chat(userName: "Me", messageContent: "Hello there"),Chat(userName: "OtherPeople", messageContent: "Yo")]
    var body: some View {
        VStack{
            List{
                ForEach(chatContent,id: \.self){
                    CC in
                    Group{
                        Text(CC.userName)
                        Text(CC.messageContent)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
