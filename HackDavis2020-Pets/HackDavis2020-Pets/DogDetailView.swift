//
//  DogDetailView.swift
//  HackDavisDemo
//
//  Created by Xiyu Zhang on 1/18/20.
//  Copyright © 2020 Xiyu Zhang. All rights reserved.
//

import SwiftUI

struct DogDetailView: View {
    var dogInfo: DogInfo
    @State var liked = false
    @State var showAction = false
    
    var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Are you sure to submit your adoption request to us?"),
            buttons: [.default( Text("Submit")){
                //
                },
                      .cancel()
        ])
    }
    
    
    var body: some View {
        ZStack {
            
            ScrollView {
                VStack(spacing: 10) {
                    Image(dogInfo.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ScreenDimension.width)
                    VStack(alignment: .leading, spacing: 15) {
                        Button(action: {
                            self.liked.toggle()
                        }){
                            Image("\(liked ? "heart.fill" : "heart")")
                        }.scaleEffect(1.5)
                        
                        Divider()
                        
                        Text("Nickname: \(dogInfo.name)")
                            .font(Font.system(size: 25, weight: .bold, design: .default))
                        
                        Text("Type: \(dogInfo.type)")
                            .font(Font.system(size: 20, weight: .bold, design: .default))
                        
                        Text("Age: \(dogInfo.age)")
                            .font(Font.system(size: 20, weight: .bold, design: .default))
                        
                        Text("Disabled: \(dogInfo.disabled ? "Yes" : "No")")
                            .font(Font.system(size: 20, weight: .bold, design: .default))
                        
                        Divider()
                        
                        Text("Story")
                            .font(Font.system(size: 25, weight: .bold, design: .default))
                        
                        Text("Tip: The classic thing to do when you’re learning a framework is to scatter print() calls around so you can see when things happen. If you want to try that with your button action, you should first right-click on the play button in the preview canvas and choose “Debug Preview” so that your print() calls work.")
                        
                    }.padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                    
                    Button(action: {
                        self.showAction.toggle()
                    }){
                        Text("I want to ADOPT!")
                            .font(Font.system(size: 20, weight: .bold, design: .default))
                    }.frame(width: ScreenDimension.width * 0.9)
                        .padding(.vertical)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("adoption.gradient.green"), Color("login.gradient.blue")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(50)
                    
                    Button(action: {
                        
                    }){
                        Text("I want to DONATE!")
                            .font(Font.system(size: 20, weight: .bold, design: .default))
                    }.frame(width: ScreenDimension.width * 0.9)
                        .padding(.vertical)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [ Color("login.gradient.blue"), Color("adoption.gradient.green")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(50)
                    
                }
                .padding(.top, ScreenDimension.height * 0.09)
                .padding(.bottom, 100)
                .frame(maxWidth: .infinity)
            }
            .background(Color.clear)
            
            VStack {
                VStack {
                    Text(dogInfo.name).font(Font.system(size: 25, weight: .bold, design: .default)).offset(y: ScreenDimension.height * 0.03)
                }
                .frame(width: ScreenDimension.width, height: ScreenDimension.height * 0.08)
                .padding(.bottom)
                .background(Color("login.gradient.blue"))
                //            .zIndex(1)
                            .navigationBarHidden(true)
                Spacer()
            }

        }.edgesIgnoringSafeArea(.all)
            .actionSheet(isPresented: self.$showAction, content: {self.actionSheet})
    }
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailView(dogInfo: DogInfo(imageName: "Max", name: "Max", age: "1 year and 8 month", disabled: false))
    }
}
