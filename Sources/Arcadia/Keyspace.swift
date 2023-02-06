//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 10/7/21.
//

import Foundation

//public class Keyspace
//{
//    var slot: Slot
//
//    public init()
//    {
//        slot = Slot.leaf(0, Cohort(peers: []))
//    }
//
//    public func boostrap() -> Bool
//    {
//        guard let boot = Bootstrap() else {return false}
//        guard let peer = boot.getPeer() else {return false}
//        insert(peer)
//
//        return true
//    }
//
//    func insert(_ peer: Peer)
//    {
//        slot = slot.add(peer)
//    }
//}
