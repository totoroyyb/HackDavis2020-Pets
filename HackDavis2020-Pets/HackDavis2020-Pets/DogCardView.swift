//
//  DogCardView.swift
//  HackDavisDemo
//
//  Created by Xiyu Zhang on 1/18/20.
//  Copyright © 2020 Xiyu Zhang. All rights reserved.
//

import SwiftUI

struct DogCardView: View {
    var dogInfo : DogInfo
    
    var body: some View {
        ZStack {
            VStack {
                Image(self.dogInfo.imageName).renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: ScreenDimension.width * 0.8)
                    .frame(height: ScreenDimension.width * 0.8)
                    .clipped()
                Spacer()
            }
            
            
            VStack {
                Spacer()
                VStack {
                    HStack{
                        Image("Max").renderingMode(.original)
                            .resizable()
                            .frame(width: ScreenDimension.width / 12, height: ScreenDimension.width / 12)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.white))
                            .shadow(radius: 40)
                        Text("UserName")
                        Spacer()
                    }
                    
                    Text(self.dogInfo.name)
                        .font(Font.system(size: 20, weight: .bold, design: .rounded))
                }
                .padding(.all, 10)
                .background(Color("login.gradient.blue").opacity(0.9))
            }
            
            if (self.dogInfo.disabled) {
                HStack {
                    Spacer()
                    VStack {
                        ZStack {
                            Circle()
                                .overlay(Circle().stroke(lineWidth: 3).foregroundColor(.white))
                                .opacity(0.7)
                                .foregroundColor(Color.black)
                            Image("bandage.fill")
                                .scaleEffect(1.3)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(width: 40, height: 40)
                        .shadow(radius: 40)
                        Spacer()
                    }
                }
                
            }
        }
        .frame(height: ScreenDimension.width)
        .frame(width: ScreenDimension.width * 0.8)
        .background(Color.init("login.gradient.blue"))
    }
}

struct DogCardView_Previews: PreviewProvider {
    static var previews: some View {
        DogCardView(dogInfo: DogInfo(imageName: "Max", name: "Max", age: "1 year and 8 month", disabled: false))
    }
}
