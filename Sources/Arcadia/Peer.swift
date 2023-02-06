//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 10/7/21.
//

import Foundation
import CryptoKit
import Transmission
import Network

//public struct Peer
//{
//    let ip: IPv4Address
//    let port: UInt16
//
//    let connection: Connection
//    let publicKey: P256.Signing.PublicKey
//    let peerAddress: PeerAddress
//
//    public init?(_ ip: IPv4Address, _ port: UInt16)
//    {
//        self.ip = ip
//        self.port = port
//
//        let ipString = "\(ip)"
//        guard let connection = Connection(host: ipString, port: Int(port)) else {return nil}
//        self.connection = connection
//
//        guard let publicKeyData = connection.read(size: 32) else {return nil}
//        guard let publicKey = try? P256.Signing.PublicKey(compactRepresentation: publicKeyData) else {return nil}
//        self.publicKey = publicKey
//
//        guard let peerAddress = PeerAddress(publicKey: publicKey) else {return nil}
//        self.peerAddress = peerAddress
//    }
//}
//
//public struct PeerAddress
//{
//    let uint64: UInt64
//
//    public init?(uint64: UInt64)
//    {
//        self.uint64 = uint64
//    }
//
//    public init?(publicKey: P256.Signing.PublicKey)
//    {
//        guard let bytes = publicKey.compactRepresentation else {return nil}
//        let hash = bytes.hashValue
//
//        self.uint64 = UInt64(bitPattern: Int64(hash))
//    }
//}
