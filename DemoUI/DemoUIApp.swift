//
//  DemoUIApp.swift
//  DemoUI
//
//  Created by MR Tailor on 19/10/23.
//

import SwiftUI
import IQKeyboardManagerSwift

@main
struct DemoUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension UIApplication {
    func enableKeyBoardManager(_ isEnable:Bool) {
        IQKeyboardManager.shared.enable = isEnable
    }
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
