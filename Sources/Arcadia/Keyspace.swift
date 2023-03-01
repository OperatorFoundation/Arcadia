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
    let keys: SortedSet<ArcadiaID> = SortedSet<ArcadiaID>(sortingStyle: .lowFirst)

    // Private variables
    var lock = DispatchSemaphore(value: 1)

    // Public initializers
    public init()
    {
    }

    // Public functions
    public func add(key: ArcadiaID)
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        self.keys.add(element: key)
    }

    public func remove(key: ArcadiaID)
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        self.keys.remove(element: key)
    }

    public func getPeers(for server: ArcadiaID) throws -> [ArcadiaID]
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        var set: Set<ArcadiaID> = Set<ArcadiaID>()

        let next = try getNext(for: server)
        let previous = try getPrevious(for: server)
        set.insert(next)
        set.insert(previous)
        set.insert(try getNext(for: next))
        set.insert(try getPrevious(for: previous))

        var results: [ArcadiaID] = []
        let _ = set.map { results.append($0) }
        return results
    }

    public func getServers(for client: ArcadiaID) throws -> [ArcadiaID]
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        var set: Set<ArcadiaID> = Set<ArcadiaID>()

        set.insert(try getNext(for: client))
        set.insert(try getPrevious(for: client))
        let _ = try self.getShiftedLeft(for: client).map { set.insert($0) }
        let _ = try self.getShiftedRight(for: client).map { set.insert($0) }

        var results: [ArcadiaID] = []
        let _ = set.map { results.append($0) }
        return results
    }

    // Private functions
    func getShiftedLeft(for key: ArcadiaID) throws -> [ArcadiaID]
    {
        let (idealAKey, idealBKey) = key.shiftLeft()
        let realAKey = try self.getNext(for: idealAKey)
        let realBKey = try self.getNext(for: idealBKey)

        return [realAKey, realBKey]
    }

    func getShiftedRight(for key: ArcadiaID) throws -> [ArcadiaID]
    {
        let (idealAKey, idealBKey) = key.shiftRight()
        let realAKey = try self.getNext(for: idealAKey)
        let realBKey = try self.getNext(for: idealBKey)

        return [realAKey, realBKey]
    }

    func getNext(for key: ArcadiaID) throws -> ArcadiaID
    {
        let circle = try CircularArray<ArcadiaID>(array: self.keys.array)
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

    func getPrevious(for key: ArcadiaID) throws -> ArcadiaID
    {
        let circle = try CircularArray<ArcadiaID>(array: self.keys.array)
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
