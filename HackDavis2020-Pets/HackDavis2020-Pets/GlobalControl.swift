//
//  GlobalControl.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import Foundation
import Combine

var Control = GlobalControl()

class GlobalControl: ObservableObject {
    @Published var isShowError = false
    @Published var isShowLoading = false
    @Published var isChatRoomClicked = false
}
