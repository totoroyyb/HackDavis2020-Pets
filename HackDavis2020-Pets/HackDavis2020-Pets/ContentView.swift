//
//  ContentView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
