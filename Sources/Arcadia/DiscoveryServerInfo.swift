//
//  DiscoveryServerInfo.swift
//  
//
//  Created by Dr. Brandon Wiley on 2/6/23.
//

import Foundation

public class DiscoveryServerInfo: Codable
{
    public let serverID: String
    public let serverAddress: String
    public var lastHeartbeat: Date

    public init(serverID: String, serverAddress: String)
    {
        self.serverID = serverID
        self.serverAddress = serverAddress
        self.lastHeartbeat = Date()
    }
}
