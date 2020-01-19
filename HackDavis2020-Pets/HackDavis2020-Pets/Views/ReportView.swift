//
//  ReportView.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/19.
//  Copyright © 2020 iDEX. All rights reserved.
//

import SwiftUI
import MapKit

struct ReportView: View {
    @State private var isInjured = false
    @State private var isAggressive = false
    @State private var isAllowedForGeo = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var additionNotes = ""
    @EnvironmentObject var control: GlobalControl
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    LottieView(filename: "doggie-bg")
                        .frame(width: 300, height: 200)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ScrollView {
                VStack {
                    HStack {
                        Text("I Found A Homeless Pet!")
                            .font(.title).fontWeight(.bold)
                        Spacer()
                    }.padding(.vertical)
                    
                    VStack {
                        Toggle(isOn: $isInjured) {
                            Text("Is Injured?")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        
                        Toggle(isOn: $isAggressive) {
                            Text("Is Aggressive?")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                    }.padding(.vertical)
                    
                    VStack {
                        HStack {
                            Text("Location")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                            
                            if self.isAllowedForGeo {
                                Text("Location Updated")
                                    .font(.subheadline)
                                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                                    .transition(.move(edge: .trailing))
                            }
                        }
                        
                        ZStack {
                            MapView(centerCoordinate: $centerCoordinate, annotations: locations)
                                .frame(height: 300)
                            
                            BlurView(style: .dark)
                                .opacity(self.isAllowedForGeo ? 0.1 : 0.9)
                                .animation(.linear(duration: 0.5))
                            
                            Button(action: {
                                let newLocation = MKPointAnnotation()
                                newLocation.coordinate = self.centerCoordinate
                                self.locations.append(newLocation)
                                self.isAllowedForGeo.toggle()
                            }) {
                                Text("Locate")
                            }
                            .opacity(self.isAllowedForGeo ? 0 : 1)
                            .animation(.linear(duration: 0.5))
                            
                        }
                        .frame(maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        
                    }.padding(.vertical)
                    
                    VStack {
                        HStack {
                            Text("Additional Notes")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        TextField("Is there any additional notes for rescue team?", text: self.$additionNotes)
                    }
                    
                    Spacer()
                }
                .padding()
            }.background(Color("background.report"))
            
            
            VStack {
                Spacer()
                Button(action: {
                    self.control.isReportedClicked.toggle()
                }) {
                    Text("Submit")
                }
                .padding()
                .background(BlurView(style: .dark))
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(radius: 20)
            }
            .padding()
        }
        .padding(.top, 42)
        .padding(.bottom, 20)
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
