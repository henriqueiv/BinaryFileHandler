//
//  ViewController.swift
//  BinaryFileHandler
//
//  Created by Henrique Valcanaia on 3/3/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import Cocoa

struct Reg {
    var id:Int
    var name:String
}

enum EncodingStructError: ErrorType {
    case InvalidSize
}

func encode<T>(var value: T) -> NSData {
    return withUnsafePointer(&value) { p in
        NSData(bytes: p, length: sizeofValue(value))
    }
}

func decode<T>(data: NSData) throws -> T {
    guard data.length == sizeof(T) else {
        throw EncodingStructError.InvalidSize
    }
    
    let pointer = UnsafeMutablePointer<T>.alloc(1)
    data.getBytes(pointer, length: data.length)
    
    return pointer.move()
}

enum Result<T> {
    case Success(T)
    case Failure
}


class ViewController: NSViewController {
    
    private let filePath = "pietro.txt"
    private let fileManager = NSFileManager.defaultManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeTestData()
        readTestData()
    }
    
    private func writeTestData() {
        if !fileManager.fileExistsAtPath(filePath) {
            fileManager.createFileAtPath(filePath, contents: NSData(), attributes: nil)
        }
        
        if let fileHandler = NSFileHandle(forUpdatingAtPath: filePath){
            for id in 1...100 {
                let reg:Result<Reg> = .Success(Reg(id: id, name: "Pietro\(id)"))
                let data = encode(reg)
                fileHandler.writeData(data)
            }
        } else {
            print("erro ao abrir arquivo")
        }
    }
    
    private func readTestData() {
        if !fileManager.fileExistsAtPath(filePath) {
            print("arquivo nao existe")
        } else {
            if let fileHandler = NSFileHandle(forUpdatingAtPath: filePath){
                var data:NSData
                repeat {
                    do {
                        data = fileHandler.readDataOfLength(sizeof(Reg))
                        var result:Result<Reg> = try decode(data)
                        switch result {
                        case .Success(let reg):
                            print(reg)
                            
                        case .Failure:
                            print("deu ruim")
                        }
                        
                    } catch {
                        print(error)
                    }
                    
                } while (data.length == sizeof(Reg))
            } else {
                print("erro ao abrir arquivo")
            }
        }
    }
    
    private func readStructAtIndex() {
        
    }
    
}

