//
//  Alert+Extension.swift
//  TodoAppSwiftUI
//
//  Created by Kosuke Nishimura on 2020/12/29.
//

import DomainLayer
import SwiftUI

extension Alert {
    
    static func make(with error: TodoValidationError) -> Alert {
        Alert(title: Text(error.description))
    }
}
