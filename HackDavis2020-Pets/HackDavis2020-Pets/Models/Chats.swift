//
//  Chats.swift
//  HackDavis2020-Pets
//
//  Created by Quentin on 2020/1/18.
//  Copyright © 2020 iDEX. All rights reserved.
//

import Foundation
import SwiftUI

struct Chat : Hashable, Identifiable {
    let id = UUID()
    var messageContent: String
    var userName: String
    var color: Color
    var isMe: Bool = false
    var receiveUsername: String
}
