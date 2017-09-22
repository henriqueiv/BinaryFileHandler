//
//  BinaryFileHandler.swift
//  BinaryFileHandler
//
//  Created by Henrique Valcanaia on 3/3/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import Foundation

enum EncodingStructError: ErrorType {
    case InvalidSize(String)
}

func encode<T>(var value: T) -> NSData {
    return withUnsafePointer(&value) { p in
        NSData(bytes: p, length: sizeofValue(value))
    }
}

func decode<T>(data: NSData) throws -> T {
    guard data.length == strideof(T) else {
        throw EncodingStructError.InvalidSize("tamanhus diferentis :(")
    }
    
    let pointer = UnsafeMutablePointer<T>.alloc(1)
    data.getBytes(pointer, length: data.length)
    
    return pointer.move()
}

enum Result<T> {
    case Success(T)
    case Failure
}
