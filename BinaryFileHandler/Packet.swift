//
//  Packet.swift
//  BinaryFileHandler
//
//  Created by Henrique Valcanaia on 3/5/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import Foundation

struct Record {
    
    var id:Int64
    var name:String
    
    struct Header {
        var idLength:Int64
        var nameLength:Int64
    }
    
    func archive() -> NSData {
        var header = Header(idLength: Int64(self.id), nameLength: Int64(self.name.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
        var headerData = NSData(bytes: &header, length: sizeof(Header))
        
        let data = NSMutableData(data: headerData)
        data.appendData(self.id)
        data.appendData(self.name.dataUsingEncoding(NSUTF8StringEncoding)!)
        
    }
    
    static func unarchive(data:NSData) -> Packet {
        
    }
}



//public struct Packet {
//    
//    var header:Header
//    var record:Record
//    
//    func archive() -> NSData {
//        
//        var archivedPacket = ArchivedPacket(index: Int64(self.index), numberOfPackets: Int64(self.numberOfPackets), nameLength: Int64(self.name.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)), dataLength: Int64(self.data.length))
//        
//        // Header
//        var metadata = NSData(
//            bytes: &archivedPacket,
//            length: sizeof(ArchivedPacket)
//        )
//        
//        let archivedData = NSMutableData(data: metadata)
//        archivedData.appendData(name.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)
//        
//        // Real data
//        archivedData.appendData(data)
//        
//        return archivedData
//    }
//    
//    static func unarchive(data: NSData!) -> Packet {
//        var archivedPacket = ArchivedPacket(index: 0, numberOfPackets: 0, nameLength: 0, dataLength: 0)
//        let archivedStructLength = sizeof(ArchivedPacket)
//        
//        let archivedData = data.subdataWithRange(NSMakeRange(0, archivedStructLength))
//        archivedData.getBytes(&archivedPacket)
//        
//        let nameRange = NSMakeRange(archivedStructLength, Int(archivedPacket.nameLength))
//        let dataRange = NSMakeRange(archivedStructLength + Int(archivedPacket.nameLength), Int(archivedPacket.dataLength))
//        
//        let nameData = data.subdataWithRange(nameRange)
//        let name = NSString(data: nameData, encoding: NSUTF8StringEncoding) as! String
//        let theData = data.subdataWithRange(dataRange)
//        
//        let packet = Packet(name: name, index: archivedPacket.index, numberOfPackets: archivedPacket.numberOfPackets, data: theData)
//        
//        return packet
//    }
//}