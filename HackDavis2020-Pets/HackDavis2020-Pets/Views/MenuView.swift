//
//  MenuView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI
import Firebase

struct MenuView: View {
    @State var isLogInClicked = false
    @Binding var isSettingClicked: Bool
    
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
                .foregroundColor(.black)
                .padding()
            
            HStack {
                Button(action: {
                    
                }) {
                    LottieView(filename: "like")
                    .frame(width: 50, height: 50)
                }
                
                Divider()
                
                Button(action: {
                    
                }) {
                    LottieView(filename: "notification")
                    .frame(width: 50, height: 50)
                    .scaleEffect(4.5)
                }
            }
            .frame(height: 50)
            
            MenuItems()
                .padding()
                .environmentObject(Control)
            
            Spacer()
            
            PanelBottom(isLogIn: $isLogInClicked, isSettingsClicked: $isSettingClicked)
        }
        .sheet(isPresented: $isLogInClicked) {
            LogInView()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isSettingClicked: .constant(true))
    }
}

private struct MenuItems: View {
    @EnvironmentObject var control: GlobalControl
    
    var body: some View {
        VStack(spacing: 40) {
            Button(action: {
                self.control.isChatRoomClicked.toggle()
            }) {
                Text("Chat")
                    .foregroundColor(.black)
                    .font(Font.system(size: 20, weight: .bold, design: .default))
            }
            
            Button(action: {
                self.control.isReportedClicked.toggle()
            }) {
                Text("Homeless Pets")
                    .foregroundColor(.black)
                    .font(Font.system(size: 20, weight: .bold, design: .default))
            }
            
            //            Button(action: {
            //
            //            }) {
            //                Text("Some Menu Item")
            //            }
        }
        .padding()
        
    }
}

struct PanelBottom: View {
    @Binding var isLogIn: Bool
    @Binding var isSettingsClicked: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                self.isSettingsClicked.toggle()
            }) {
                HStack {
                    Image.init(systemName: "gear")
                    Text("Settings")
                        .foregroundColor(.black)
                        .font(Font.system(size: 18, weight: .bold, design: .default))
                }
            }
            
            HStack {
                Button(action: {
                    self.isLogIn.toggle()
                }) {
                    HStack {
                        Image.init(systemName: "person.badge.plus")
                        Text("Log In")
                            .font(Font.system(size: 18, weight: .bold, design: .default))
                    }
                }
                
                Divider()
                    .frame(width: 20, height: 30)
                
                Button(action: {
                    try? Auth.auth().signOut()
                }) {
                    HStack {
                        Image.init(systemName: "escape")
                        Text("Log Out")
                            .font(Font.system(size: 18, weight: .bold, design: .default))
                    }
                }
            }
            
        }.foregroundColor(.black)
    }
}
