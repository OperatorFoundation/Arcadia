//
//  WreathServerInfo.swift
//  
//
//  Created by Dr. Brandon Wiley on 2/6/23.
//

import Foundation

public class WreathServerInfo: Codable
{
    public let key: Key
    public let serverAddress: String
    public var lastHeartbeat: Date

    public init(key: Key, serverAddress: String)
    {
        self.key = key
        self.serverAddress = serverAddress
        self.lastHeartbeat = Date()
    }
}
