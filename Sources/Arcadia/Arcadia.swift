public struct Arcadia
{
//    let keyspace: Keyspace

    public init()
    {
//        self.keyspace = Keyspace()
    }

    public func findPeers(discoveryServers: [DiscoveryServerInfo], serverID: String) -> [DiscoveryServerInfo]
    {
        return discoveryServers
    }
}
