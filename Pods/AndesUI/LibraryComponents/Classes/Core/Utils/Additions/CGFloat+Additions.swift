//
//  CGFloat+Additions.swift
//  AndesUI
//
//  Created by Tomi De Lucca on 04/11/2020.
//

import Foundation

extension CGFloat {
    func sign() -> CGFloat {
        return self > 0 ? 1.0 : -1.0
    }

    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
