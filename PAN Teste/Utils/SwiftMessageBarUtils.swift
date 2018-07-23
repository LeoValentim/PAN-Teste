//
//  SwiftMessageBarUtils.swift
//  OneTaxi
//
//  Created by Megaleios DEV on 10/05/18.
//  Copyright © 2018 Megaleios. All rights reserved.
//

import Foundation
import SwiftMessageBar

struct SwiftMessageBarUtils {
    static func showMessage(_ title: String?, message: String?, type: SwiftMessageBar.MessageType) {
        SwiftMessageBar.sharedMessageBar.cancelAll(force: true)
        SwiftMessageBar.showMessageWithTitle(title, message: message, type: type)
    }
}
