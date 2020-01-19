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
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color(hex: "833ab4"), Color(hex: "fd1d1d"), Color(hex: "fcb045")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            LogInInnerView().environmentObject(Control)
        }
    }
}

private struct LogInInnerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var userName = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            VStack {
                Text("Pets Finder")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                TextField("User Name", text: $userName)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.white.opacity(0.2), lineWidth: 2))
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.white.opacity(0.2)))
                    .padding(.vertical)
                
                SecureField("Password", text: $password)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.white.opacity(0.2), lineWidth: 2))
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.white.opacity(0.2)))
                
                HStack {
                    Button(action: {
                        Auth.auth().signIn(withEmail: self.userName, password: self.password) { (user, error) in
                           if error != nil {
                                print(error!)
                           } else {
                                print("Log in successful")
                                self.presentationMode.wrappedValue.dismiss()
                           }
                       }
                    }) {
                        Text("Log In")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.white.opacity(0.8), lineWidth: 2))
                    
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
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.white.opacity(0.8), lineWidth: 2))
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
            
            LogInInnerView()
        }
        
    }
}
