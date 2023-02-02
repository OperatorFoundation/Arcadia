//
//  Cohort.swift
//  
//
//  Created by Dr. Brandon Wiley on 10/8/21.
//

import Foundation

public class Cohort
{
    var peers: [Peer]

    public init(peers: [Peer])
    {
        self.peers = peers
    }

    public func count() -> Int
    {
        return self.peers.count
    }
}
