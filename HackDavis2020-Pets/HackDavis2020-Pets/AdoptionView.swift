//
//  AdoptionView.swift
//  HackDavisDemo
//
//  Created by Xiyu Zhang on 1/18/20.
//  Copyright © 2020 Xiyu Zhang. All rights reserved.
//

import SwiftUI

struct AdoptionView: View {
    @State var search = ""
    //    @State var showDetail = false
    var dogs: [DogInfo] = [DogInfo(imageName: "Max", name: "Max", age: "1 year and 8 month", disabled: false), DogInfo(imageName: "Charlie", name: "Charlie", age: "3 years old", disabled: false), DogInfo(imageName: "Max", name: "Max", age: "1 year and 8 month", disabled: false), DogInfo(imageName: "Charlie", name: "Charlie", age: "3 years old", disabled: false), DogInfo(imageName: "Max", name: "Max", age: "1 year and 8 month", disabled: false), DogInfo(imageName: "Charlie", name: "Charlie", age: "3 years old", disabled: false), DogInfo(imageName: "Max", name: "Max", age: "1 year and 8 month", disabled: false), DogInfo(imageName: "Charlie", name: "Charlie", age: "3 years old", disabled: false), DogInfo(imageName: "Max", name: "Max", age: "1 year and 8 month", disabled: false), DogInfo(imageName: "Charlie", name: "Charlie", age: "3 years old", disabled: false)]
    
    var body: some View {
        ZStack() {
            ScrollView {
                VStack {
                    ForEach(self.dogs) { dog in
                        NavigationLink(destination: DogDetailView(dogInfo: dog)) {
                            DogCardView(dogInfo: dog)
                        }
                        .cornerRadius(20)
                        .frame(maxWidth: .infinity)
                        .shadow(radius: 40)
                    }
                }.padding(.top, ScreenDimension.height * 0.2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("background-pets"))
            AdoptionSearchBar(search: self.$search)
        }
        .accentColor(.black)
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    
}

struct AdoptionSearchBar: View {
    @Binding var search: String
    //    @Binding var showDetail: Bool
    
    func searchDog() {
        //
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "heart.circle")
                    Text("Adoption")
                        .font(Font.system(size: 25, weight: .bold, design: .default))
                } .padding(.top, ScreenDimension.height / 20)
            }
            .frame(width: ScreenDimension.width, height: ScreenDimension.height * 0.12)
            .padding(.bottom)
            .padding(.top, 0)
            .background(
                BlurView(style: .dark)
                .overlay(Color("login.gradient.blue").opacity(0.8))
            )
            HStack {
                Image("magnifyingglass")
                TextField("Search", text: self.$search)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.trailing)
            .frame(width: ScreenDimension.width * 0.95)
            Spacer()
        }
        
    }
}

struct AdoptionView_Previews: PreviewProvider {
    static var previews: some View {
        AdoptionView()
    }
}
