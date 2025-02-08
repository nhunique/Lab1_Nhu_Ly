//
//  Font.swift
//  Lab1_Nhu_Ly
//
//  Created by Huynh Yen Nhu Ly on 2025-02-08.
//

import SwiftUI

extension Font {
    static func pacifico(fontStyle: Font.TextStyle = .body) -> Font {
        return Font.custom("Pacifico-Regular", size: fontStyle.size)
    }
}

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle: return 70
        case .title : return 40
        default : return 30
        }
    }
}

