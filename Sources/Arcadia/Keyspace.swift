//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 10/7/21.
//

import Foundation

import Abacus

public class Keyspace
{
    let keys: SortedSet<Key> = SortedSet<Key>(sortingStyle: .lowFirst)

    var lock = DispatchSemaphore(value: 1)

    public init()
    {
    }

    public func add(key: Key)
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        self.keys.add(element: key)
    }

    public func getPeers(for server: Key) -> [Key]
    {
        return self.keys.array
    }

    public func getServers(for client: Key) -> [Key]
    {
        return self.keys.array
    }

    func getNext(for key: Key) -> Key
    {
        // FIXME
        return key
    }
}
