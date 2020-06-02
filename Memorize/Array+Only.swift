//
//  Array+Only.swift
//  Memorize
//
//  Created by Evan Timmons on 6/2/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
