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
            
            LogInInnerView()
        }
    }
}

private struct LogInInnerView: View {
    @State private var userName = ""
    @State private var password = ""
    
    var body: some View {
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
            
            TextField("Password", text: $password)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.white.opacity(0.2), lineWidth: 2))
                .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.white.opacity(0.2)))
            
            HStack {
                Button(action: {
                   
                }) {
                    Text("Log In")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.white.opacity(0.8), lineWidth: 2))
                
                Spacer().frame(width: 20)
                
                Button(action: {
                    SignInUser(email: self.userName, password: self.password)
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

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LogInView()
            
            LogInInnerView()
        }
        
    }
}
