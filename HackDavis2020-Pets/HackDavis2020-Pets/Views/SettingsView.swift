//
//  SettingsView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/19.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: AccountSettingView()) {
                    Text("Account Settings")
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
