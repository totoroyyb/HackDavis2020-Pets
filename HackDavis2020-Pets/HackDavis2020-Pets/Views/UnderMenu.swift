//
//  UnderMenu.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI

struct UnderMenu<Content>: View where Content: View {
    let underContent: Content
    let coverContent: Content
    
    var menuWidth: CGFloat = 250
    var translationThreshold: CGFloat = 80
    var slideEdgeWidth: CGFloat = 40
    var openScale: CGFloat = 0.85
    var slideAnimation: Animation = .linear(duration: 0.2)
    
    @State private var dynamicScale: CGFloat = 1
    
    @State private var isOpen = false {
        didSet {
            withAnimation(slideAnimation) {
                if _isOpen.wrappedValue {
                    self.coverTranslation = menuWidth
                } else {
                    self.coverTranslation = CGFloat.zero
                }
            }
        }
    }
    
    @State private var coverTranslation: CGFloat = CGFloat.zero {
        didSet {
            self.dynamicScale = 1 - (self.coverTranslation / self.menuWidth) * (1 - self.openScale)
        }
    }
    
    init(@ViewBuilder back: () -> Content, @ViewBuilder cover: () -> Content) {
        self.underContent = back()
        self.coverContent = cover()
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                HStack {
                    underContent
                    .frame(maxWidth: menuWidth, maxHeight: .infinity)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            coverContent
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(radius: 10)
                .scaleEffect(dynamicScale, anchor: .leading)
                .offset(x: coverTranslation)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Color.red
                    .opacity(0.00001)
                    .frame(maxWidth: self.isOpen ? .infinity : slideEdgeWidth)
                Spacer()
            }
            .scaleEffect(dynamicScale, anchor: .leading)
            .offset(x: coverTranslation)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if !self.isOpen && value.startLocation.x <= self.slideEdgeWidth && value.translation.width > 0 && value.translation.width <= self.menuWidth {
                            self.coverTranslation = value.translation.width
                        } else if self.isOpen && value.startLocation.x >= self.menuWidth && value.translation.width < 0 && -value.translation.width <= self.menuWidth {
                            self.coverTranslation = self.menuWidth + value.translation.width
                        }
                    }
                    .onEnded { value in
                        if !self.isOpen && value.startLocation.x <= self.slideEdgeWidth {
                            if value.translation.width > self.translationThreshold {
                                self.isOpen.toggle()
                            } else {
                                self.isOpen = false
                            }
                        } else if self.isOpen && value.startLocation.x >= self.menuWidth {
                            if -value.translation.width > self.translationThreshold {
                                self.isOpen.toggle()
                            } else {
                                self.isOpen = true
                            }
                        }
                    }
                )
        }
    }
}

struct UnderView: View {
    var body: some View {
        VStack {
            Text("This is a under view")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct CoverView: View {
    var body: some View {
        VStack {
            Text("This is a cover view")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
    }
}

struct UnderMenu_Previews: PreviewProvider {
    static var previews: some View {
        UnderMenu(back: {
            AnyView(UnderView())
        }) {
            AnyView(CoverView())
        }
    }
}

