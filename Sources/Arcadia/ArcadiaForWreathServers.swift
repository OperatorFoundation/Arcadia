//
//  Arcadia.swift
//
//
//  Created by Dr. Brandon Wiley on 2/6/23.
//

import Foundation

import Datable

// Specialization of the Arcadia algorithm for Wreath servers servers
public class ArcadiaForWreathServers: Arcadia
{
    // Two wreath servers are peers if they are allowed to know about each other.
    public func findPeers(for server: ArcadiaID) -> [WreathServerInfo]
    {
        do
        {
            let keys = try self.keyspace.getPeers(for: server)
            return keys.compactMap
            {
                key in

                return self.servers[key]
            }
        }
        catch
        {
            return []
        }
    }
}
