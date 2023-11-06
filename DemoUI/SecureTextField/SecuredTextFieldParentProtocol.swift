//
//  SecuredTextFieldParentProtocol.swift
//  DemoUI
//
//  Created by MR Tailor on 19/10/23.
//

import Foundation

/// Properties and functionalities to assign and  perform in the parent view of the SecuredTextFieldView.
protocol SecuredTextFieldParentProtocol {
    
    /// Assign SecuredTextFieldView hideKeyboard method to this and
    /// then parent can excute it when needed..
    var hideKeyboard: (() -> Void)? { get set }
}
