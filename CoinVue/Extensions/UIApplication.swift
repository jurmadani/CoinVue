//
//  UIApplication.swift
//  CoinVue
//
//  Created by Daniel Jurma on 02.01.2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
