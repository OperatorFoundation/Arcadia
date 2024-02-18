//
//  ArcadiaForTransportServers.swift
//
//
//  Created by Dr. Brandon Wiley on 2/6/23.
//

import Foundation

import Datable

// Specialization of the Arcadia algorithm for transport servers
public class ArcadiaForTransportServers: Arcadia
{
    // This function gives back only the servers that the given client is allowed to know about.
    public func findServers(for client: ArcadiaID) -> [WreathServerInfo]
    {
        do
        {
            let keys = try self.keyspace.getServers(for: client)
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
