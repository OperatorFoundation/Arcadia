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
    public let serverAddres: String
    public var lastHeartbeat: Date

    public init(serverID: String, serverAddres: String)
    {
        self.serverID = serverID
        self.serverAddres = serverAddres
        self.lastHeartbeat = Date()
    }
}
