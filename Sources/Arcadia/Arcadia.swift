public struct Arcadia
{
//    let keyspace: Keyspace

    public init()
    {
//        self.keyspace = Keyspace()
    }

    public func findPeers(discoverServers: [DiscoveryServerInfo], serverID: String) -> [DiscoveryServerInfo]
    {
        return discoverServers
    }
}
