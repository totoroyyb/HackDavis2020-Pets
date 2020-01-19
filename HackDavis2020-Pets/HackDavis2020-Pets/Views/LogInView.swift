//
//  LogInView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI
import Firebase

struct LogInView: View {
    @State private var isLoggingIn = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color(hex: "833ab4"), Color(hex: "fd1d1d"), Color(hex: "fcb045")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            LogInInnerView(isLoggingIn: $isLoggingIn)
            
            Color.black
                .opacity(self.isLoggingIn ? 0.8 : 0)
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            if isLoggingIn {
                VStack {
                    LottieView(filename: "dog-loading").scaleEffect(1.5)
                    Text("We are logging you in...")
                }
                .frame(width: 300, height: 250)
            }
        }
    }
}

private struct LogInInnerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var userName = ""
    @State private var password = ""
    @Binding var isLoggingIn: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Text("Pets Finder")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                TextField("User Name", text: $userName)
                    .modifier(LogInTextFieldModifier())
                
                SecureField("Password", text: $password)
                    .modifier(LogInTextFieldModifier())
                
                HStack {
                    Button(action: {
                        self.isLoggingIn = true
                        Auth.auth().signIn(withEmail: self.userName, password: self.password) { (user, error) in
                           if error != nil {
                                print(error!)
                                print("\(String(describing: Auth.auth().currentUser?.email))")
                           } else {
                                print("Log in successful")
                                print("\(String(describing: Auth.auth().currentUser?.email))")
                                self.presentationMode.wrappedValue.dismiss()
                           }
                            self.isLoggingIn = false
                       }
                    }) {
                        Text("Log In")
                    }
                    .modifier(LogInModifier())
                    
                    Spacer().frame(width: 20)
                    
                    Button(action: {
                        
                        Auth.auth().createUser(withEmail: self.userName, password: self.password) { (user, error) in
                            if error != nil{
                                print(error!)
                            } else{
                                print("register success")
                            }
                        }
                    }) {
                        Text("Sign Up")
                    }
                    .modifier(LogInModifier())
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 60)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LogInView()
            
            LogInInnerView(isLoggingIn: .constant(true))
        }
        
    }
}
