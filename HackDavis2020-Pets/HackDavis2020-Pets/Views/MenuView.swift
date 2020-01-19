//
//  MenuView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @State var isLogInClicked = false
    
    var body: some View {
        VStack {
            Image("UserProfilePlaceholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 5))
                .shadow(radius: 20)
                .padding()
            
            Text("Username")
                .padding()
            
            MenuItems()
                .padding()
            
            Spacer()
            
            PanelBottom(isLogIn: $isLogInClicked)
        }
        .sheet(isPresented: $isLogInClicked) {
            LogInView()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

private struct MenuItems: View {
    var body: some View {
        VStack(spacing: 40) {
            Button(action: {
                
            }) {
                Text("Some Menu Item")
            }
            
            Button(action: {
                
            }) {
                Text("Some Menu Item")
            }
            
            Button(action: {
                
            }) {
                Text("Some Menu Item")
            }
        }
        .padding()
    }
}

struct PanelBottom: View {
    @Binding var isLogIn: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                self.isLogIn.toggle()
            }) {
                HStack {
                    Image.init(systemName: "person.badge.plus")
                    Text("Log In")
                }
            }
            
            Button(action: {
                
            }) {
                HStack {
                    Image.init(systemName: "gear")
                    Text("Settings")
                }
            }
        }
    }
}
