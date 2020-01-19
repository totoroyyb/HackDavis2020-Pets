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
        VStack(spacing: ScreenDimension.height / 150) {
            ZStack(alignment:.topTrailing) {
                Image(dogInfo.imageName).renderingMode(.original)
                                   .resizable()
                                   .aspectRatio(contentMode: .fill)
                                   .frame(maxWidth: ScreenDimension.width * 0.8, maxHeight: ScreenDimension.width * 0.8)
                ZStack {
                    Circle()
                        .overlay(Circle().stroke(lineWidth: 3).foregroundColor(.white))
                        .opacity(0.7)
                        .foregroundColor(Color.black)
                    Image("bandage.fill")
                        .scaleEffect(1.3)
                        .foregroundColor(.white)
                    //                    .onHover(perform: T##(Bool) -> Void)
                }
                .frame(width: 40, height: 40)
                .offset(x: -ScreenDimension.width * 0.05, y:ScreenDimension.width * 0.05)
                .shadow(radius: 40)
               
            }
            HStack{
                Image("Max").renderingMode(.original)
                    .resizable()
                    .frame(width: ScreenDimension.width / 12, height: ScreenDimension.width / 12)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.white))
                    .shadow(radius: 40)
                Text("FinderName")
                Spacer()
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            Text(dogInfo.name)
                .font(Font.system(size: 20, weight: .bold, design: .rounded))
                .offset(y: -ScreenDimension.height / 100)
            
        }
        .frame(maxHeight: ScreenDimension.height * 0.45)
        .frame(maxWidth: ScreenDimension.width * 0.8)
        .background(Color.init("login.gradient.blue"))
    }
}


