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
    // Private constants
    let keys: SortedSet<Key> = SortedSet<Key>(sortingStyle: .lowFirst)

    // Private variables
    var lock = DispatchSemaphore(value: 1)

    // Public initializers
    public init()
    {
    }

    // Public functions
    public func add(key: Key)
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        self.keys.add(element: key)
    }

    public func remove(key: Key)
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        self.keys.remove(element: key)
    }

    public func getPeers(for server: Key) throws -> [Key]
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        var set: Set<Key> = Set<Key>()

        let next = try getNext(for: server)
        let previous = try getPrevious(for: server)
        set.insert(next)
        set.insert(previous)
        set.insert(try getNext(for: next))
        set.insert(try getPrevious(for: previous))

        var results: [Key] = []
        let _ = set.map { results.append($0) }
        return results
    }

    public func getServers(for client: Key) throws -> [Key]
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        var set: Set<Key> = Set<Key>()

        set.insert(try getNext(for: client))
        set.insert(try getPrevious(for: client))
        let _ = try self.getShiftedLeft(for: client).map { set.insert($0) }
        let _ = try self.getShiftedRight(for: client).map { set.insert($0) }

        var results: [Key] = []
        let _ = set.map { results.append($0) }
        return results
    }

    // Private functions
    func getShiftedLeft(for key: Key) throws -> [Key]
    {
        let (idealAKey, idealBKey) = key.shiftLeft()
        let realAKey = try self.getNext(for: idealAKey)
        let realBKey = try self.getNext(for: idealBKey)

        return [realAKey, realBKey]
    }

    func getShiftedRight(for key: Key) throws -> [Key]
    {
        let (idealAKey, idealBKey) = key.shiftRight()
        let realAKey = try self.getNext(for: idealAKey)
        let realBKey = try self.getNext(for: idealBKey)

        return [realAKey, realBKey]
    }

    func getNext(for key: Key) throws -> Key
    {
        let circle = try CircularArray<Key>(array: self.keys.array)
        guard let index = circle.closestGreater(than: key) else
        {
            throw KeyspaceError.keyLookupFailed
        }

        guard let result = circle.get(index: index) else
        {
            throw KeyspaceError.keyLookupFailed
        }

        return result
    }

    func getPrevious(for key: Key) throws -> Key
    {
        let circle = try CircularArray<Key>(array: self.keys.array)
        guard let index = circle.closestLess(than: key) else
        {
            throw KeyspaceError.keyLookupFailed
        }

        guard let result = circle.get(index: index) else
        {
            throw KeyspaceError.keyLookupFailed
        }

        return result
    }
}

// Errors
public enum KeyspaceError: Error
{
    case keyLookupFailed
}
