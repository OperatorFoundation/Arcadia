//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 10/7/21.
//

import Foundation
import Transmission
import Network

public class Bootstrap
{
    let bootstrapAddress: (String, Int) = ("127.0.0.1", 1234)
    let connection: Connection

    public init?()
    {
        guard let connection = Connection(host: bootstrapAddress.0, port: bootstrapAddress.1) else {return nil}
        self.connection = connection
    }

    public func getPeer() -> Peer?
    {
        guard let ipData = connection.read(size: 4) else {return nil}
        guard let portData = connection.read(size: 2) else {return nil}

        guard let ip = IPv4Address(ipData) else {return nil}
        guard let port = portData.maybeNetworkUint16 else {return nil}

        return Peer(ip, port)
    }
}
