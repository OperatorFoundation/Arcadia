//
//  Arcadia.swift
//
//
//  Created by Dr. Brandon Wiley on 2/6/23.
//

public class Arcadia
{
    let keyspace: Keyspace

    var servers: [Key: WreathServerInfo] = [:]

    public init()
    {
        self.keyspace = Keyspace()
    }

    public func findPeers(for server: Key) -> [WreathServerInfo]
    {
        return [WreathServerInfo](self.servers.values)
    }

    public func findServers(for client: Key) -> [WreathServerInfo]
    {
        return [WreathServerInfo](self.servers.values)
    }

    public func addServer(wreathServer: WreathServerInfo) throws
    {
        guard let key = wreathServer.publicKey.arcadiaKey else
        {
            throw ArcadiaError.noArcadiaKey
        }

        self.servers[key] = wreathServer
    }
}

public enum ArcadiaError: Error
{
    case noArcadiaKey
}
