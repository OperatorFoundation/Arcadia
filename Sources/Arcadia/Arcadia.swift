//
//  Arcadia.swift
//
//
//  Created by Dr. Brandon Wiley on 2/6/23.
//

public class Arcadia
{
    let keyspace: Keyspace = Keyspace()

    var servers: [ArcadiaID: WreathServerInfo] = [:]

    public init()
    {
    }

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

    public func addServer(wreathServer: WreathServerInfo) throws
    {
        guard let key = wreathServer.publicKey.arcadiaID else
        {
            throw ArcadiaError.noArcadiaKey
        }

        self.servers[key] = wreathServer
        self.keyspace.add(key: key)
    }

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

public enum ArcadiaError: Error
{
    case noArcadiaKey
}
