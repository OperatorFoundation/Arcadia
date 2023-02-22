//
//  WreathServerInfo.swift
//  
//
//  Created by Dr. Brandon Wiley on 2/6/23.
//

import Foundation

import Keychain

public class WreathServerInfo: Codable
{
    public let publicKey: PublicKey
    public let serverAddress: String
    public var lastHeartbeat: Date

    public init(publicKey: PublicKey, serverAddress: String)
    {
        self.publicKey = publicKey
        self.serverAddress = serverAddress
        self.lastHeartbeat = Date()
    }
}
