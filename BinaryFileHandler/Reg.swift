//
//  Reg.swift
//  BinaryFileHandler
//
//  Created by Henrique Valcanaia on 3/3/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import Foundation

let BUFFER_SIZE = 8 * 8

struct Reg {
    var id:Int
    var name = UnsafeMutablePointer<CChar>()
}