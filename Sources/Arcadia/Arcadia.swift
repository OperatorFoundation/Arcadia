//
//  Arcadia.swift
//
//
//  Created by Dr. Brandon Wiley on 2/9/24.
//

import Foundation

// Base Arcadia class, implementing the Arcadia algorithm and associated data structures
public class Arcadia
{
    // The Arcadia keyspace is the core data structure for the Arcadia algorithm.
    let keyspace: Keyspace = Keyspace()

    // As the keyspace just stores the ArcadiaID, the servers field lets us recover the full server information from the id.
    var servers: [ArcadiaID: WreathServerInfo] = [:]

    // In Swift, all classes need an initializer.
    public init()
    {
    }

    // Add a server to the servers list and to the Arcadia keyspace.
    public func addServer(wreathServer: WreathServerInfo) throws
    {
        guard let key = wreathServer.publicKey.arcadiaID else
        {
            throw ArcadiaError.noArcadiaKey
        }

        self.servers[key] = wreathServer
        self.keyspace.add(key: key)
    }

    // Remove a server from the servers list and from the Arcadia keyspace.
    public func removeServer(wreathServer: WreathServerInfo) throws
    {
        guard let key = wreathServer.publicKey.arcadiaID else
        {
            throw ArcadiaError.noArcadiaKey
        }

        self.servers.removeValue(forKey: key)
        self.keyspace.remove(key: key)
    }
}

extension Arcadia: CustomStringConvertible
{
    public var description: String
    {
        return """
        Arcadia[\(self.servers.map { "\($0.key): \($0.value)" }.joined(separator: ", "))]
        """
    }
}

public enum ArcadiaError: Error
{
    case noArcadiaKey
}
