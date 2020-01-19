//
//  CreatePost.swift
//  HackDavis2020-Pets
//
//  Created by failury on 1/18/20.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI

struct CreatePost: View {
    @State var composedTitle: String = ""
    @State var composedStory: String = ""
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    var body: some View {
        VStack{
                TextField("Title", text: $composedTitle).frame(minHeight: CGFloat(50)).padding().font(.largeTitle)
                TextView(
                    text: $composedStory
                )
                
                
            
            HStack {
                Button(action: {}) {
                    Text("Add Image")
                }.frame(minHeight: CGFloat(30)).padding().font(.headline)
                Spacer()
                Button(action: {}) {
                    Text("Public Post")
                }.frame(minHeight: CGFloat(30)).padding().font(.headline)
            }
            
            
        }.padding(.bottom, keyboardObserver.keyboardHeight)
        .animation(.easeInOut(duration: 0.3)).onTapGesture {
            UIApplication.shared.endEditing()}
    }
    struct TextView: UIViewRepresentable {
        @Binding var text: String
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        func makeUIView(context: Context) -> UITextView {
            
            let myTextView = UITextView()
            myTextView.delegate = context.coordinator
            
            myTextView.font = UIFont(name: "HelveticaNeue", size: 50)
            myTextView.isScrollEnabled = true
            myTextView.isEditable = true
            myTextView.isUserInteractionEnabled = true
            myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.07)
            
            return myTextView
        }
        
        func updateUIView(_ uiView: UITextView, context: Context) {
            uiView.text = text
        }
        
        class Coordinator : NSObject, UITextViewDelegate {
            
            var parent: TextView
            
            init(_ uiTextView: TextView) {
                self.parent = uiTextView
            }
            
            func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
                return true
            }
            
            func textViewDidChange(_ textView: UITextView) {
                self.parent.text = textView.text
            }
        }
    }
    struct CreatePost_Previews: PreviewProvider {
        static var previews: some View {
            CreatePost()
        }
    }
}
