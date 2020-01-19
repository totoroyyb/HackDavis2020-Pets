//
//  ErrorView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
            
            VStack {
                Text("Ooops, something happens")
                    .padding()
                
                Button(action: {
                    
                }) {
                    Text("Click to dismiss")
                }
                .padding()
            }
            .frame(width: 300, height: 200)
            .background(Color.blue)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
