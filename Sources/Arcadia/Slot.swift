//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 10/7/21.
//

import Foundation
import Bits

//let maxCohortSize = 16
//let maxDepth = 63
//
//public indirect enum Slot
//{
//    case branch(Int, Slot, Slot)
//    case leaf(Int, Cohort)
//
//    public init(peers: [Peer])
//    {
//        var temp: Slot = Slot.leaf(0, Cohort(peers: []))
//
//        for peer in peers
//        {
//            guard let newTemp = temp.add(peer) else {continue}
//            temp = newTemp
//        }
//
//        self = temp
//    }
//
//    public func add(_ peer: Peer) -> Slot?
//    {
//        guard var peerBits = Bits(maybeNetworkUint64: peer.peerAddress.uint64) else {return nil}
//        return add(peer: peer, bits: &peerBits)
//    }
//
//    func add(peer: Peer, bits: inout Bits) -> Slot?
//    {
//        switch self
//        {
//            case .branch(let depth, let left, let right):
//                guard let isRight = bits.unpackBool() else {return nil}
//                if isRight
//                {
//                    guard let newRight = add(peer: peer, bits: &bits) else {return nil}
//                    return Slot.branch(depth, left, newRight)
//                }
//                else // isLeft
//                {
//                    guard let newLeft = add(peer: peer, bits: &bits) else {return nil}
//                    return Slot.branch(depth, newLeft, right)
//                }
//            case .leaf(let depth, let cohort):
//                if cohort.count == maxCohortSize
//                {
//                    guard depth < maxDepth else {return nil}
//                    let newDepth = depth + 1
//
//                    let leftPeers = cohort.peers.filter
//                    {
//                        peer in
//
//                        var bits = Bits(maybeNetworkUint64: peer.peerAddress.uint64)
//                        if depth == 0
//                        {
//                            let bit = bits.unpackBit()
//                        }
//                        else
//                        {
//                            bits.unpack(bits: depth - 1)
//                            let bit = bits.unpackBit()
//                        }
//                    }
//                }
//                else
//                {
//                    var peers = cohort.peers
//                    peers.append(peer)
//                    return .leaf(Cohort(peers: peers))
//                }
//        }
//    }
//}
