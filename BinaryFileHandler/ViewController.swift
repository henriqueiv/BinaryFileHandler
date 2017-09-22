//
//  ViewController.swift
//  BinaryFileHandler
//
//  Created by Henrique Valcanaia on 3/3/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    private let filePath = "pietro.txt"
    private let fileManager = NSFileManager.defaultManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeTestData()
        readTestData()
    }
    
    private func writeTestData() {
        if let fileHandler = getFileHandlerWithPath(filePath, andCreateIfDoesntExists: true) {
            for id in 1...100 {
                let t = "data \(id) de teste".dataUsingEncoding(NSUTF8StringEncoding)!
                let packet = Packet(name: "Miau\(id)", index: Int64(id), numberOfPackets: 1, data: t)
                let packetData = packet.archive()
                fileHandler.writeData(packetData)
                
                //                let reg:Reg = Reg(id: id, name: "Pietro\(id)".cStringUsingEncoding(NSUTF8StringEncoding)!)
                //                let data = encode(reg)
                //                fileHandler.writeData(data)
            }
        } else {
            print("erro ao abrir arquivo")
        }
    }
    
    private func getFileHandlerWithPath(filePath: String, andCreateIfDoesntExists create:Bool = false) -> NSFileHandle? {
        if !fileManager.fileExistsAtPath(filePath) && create {
            fileManager.createFileAtPath(filePath, contents: NSData(), attributes: nil)
        }
        
        if let fileHandler = NSFileHandle(forUpdatingAtPath: filePath){
            return fileHandler
        }
        
        return nil
    }
    
    private func readTestData() {
        if !fileManager.fileExistsAtPath(filePath) {
            print("arquivo nao existe")
        } else {
            if let fileHandler = getFileHandlerWithPath(filePath) {
                repeat {
                    let headerData = fileHandler.readDataOfLength(strideof(ArchivedPacket))
                    
                    
                    //                    let str = "0123456789".cStringUsingEncoding(NSUTF8StringEncoding)!
                    //                    let x = Reg(id: 1, name: str)
                    //                    if data.length == strideof(x.dynamicType){
                    //                        let reg:Reg = try! decode(data)
                    //                        print(reg)
                    //                    } else if data.length <= 0 {
                    //                        break
                    //                    }
                } while (true)
            } else {
                print("erro ao abrir arquivo")
            }
        }
    }
    
    private func readStructAtIndex() {
        
    }
    
}

