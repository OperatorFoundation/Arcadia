//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 10/7/21.
//

import Foundation

import Abacus

// The keyspace is the core data structure of the Arcadia Algorithm.
// It consists of a ring of BigIntegers and operations to traverse the ring.
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

    // Add a new key to the keyspace
    public func add(key: ArcadiaID)
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        self.keys.add(element: key)
    }

    // Remove a key from the keyspace
    public func remove(key: ArcadiaID)
    {
        defer
        {
            self.lock.signal()
        }
        self.lock.wait()

        self.keys.remove(element: key)
    }

    // Perform the Arcadia algorithm to get a list of Wreath server peers for the given Wreath server
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

    // Perform the Arcadia algorithm get a list of Transport servers for the given client ID
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

    // Find all of the IDs which are a left shift away from the given ID
    func getShiftedLeft(for key: ArcadiaID) throws -> [ArcadiaID]
    {
        let (idealAKey, idealBKey) = key.shiftLeft()
        let realAKey = try self.getNext(for: idealAKey)
        let realBKey = try self.getNext(for: idealBKey)
        
        if realAKey == realBKey
        {
            return [realAKey]
        }
        else
        {
            return [realAKey, realBKey]
        }
    }

    // Find all of the IDs which are a right shift away from the given ID
    func getShiftedRight(for key: ArcadiaID) throws -> [ArcadiaID]
    {
        let (idealAKey, idealBKey) = key.shiftRight()
        let realAKey = try self.getNext(for: idealAKey)
        let realBKey = try self.getNext(for: idealBKey)
        
        if realAKey == realBKey
        {
            return [realAKey]
        }
        else
        {
            return [realAKey, realBKey]
        }
    }

    // Find the ID that is right-adjacent to the given ID
    func getNext(for key: ArcadiaID) throws -> ArcadiaID
    {
        let array = self.keys.array
        if array.isEmpty
        {
            throw KeyspaceError.empty
        }

        for index in 0..<array.count
        {
            if key == array[index]
            {
                // The given key is in the array
                if index == array.count - 1
                {
                    // The given key is the array and it is the last key.
                    // It's right-most neighbor is first key.

                    return array[0]
                }
            }
            else if key < array[index]
            {
                // The given key is NOT in the array, but its right neighbor is.
                // This is what we wanted, the next value.
                return array[index]
            }
        }

        // The given key is NOT in the array, any neither is its right neighbor.
        // This means that our key is the biggest key. It's right-most neighbor is the first key.
        return array[0]
    }

    // Find the ID that is left-adjacent to the given ID
    func getPrevious(for key: ArcadiaID) throws -> ArcadiaID
    {
        let array = self.keys.array
        if array.isEmpty
        {
            throw KeyspaceError.empty
        }

        for reverseIndex in 0..<array.count
        {
            let index = (array.count - 1) - reverseIndex

            if key == array[index]
            {
                // The given key is in the array

                if index == 0
                {
                    // The given key is the array and it is the first key.
                    // It's right-most neighbor is last key.

                    return array[array.count - 1]
                }
            }
            else if key > array[index]
            {
                // The given key is NOT in the array, but its left neighbor is.
                // This is what we wanted, the previous value.
                return array[index]
            }
        }

        // The given key is NOT in the array, any neither is its left neighbor.
        // This means that our key is the smallest key. It's left-most neighbor is the last key.
        return array[array.count - 1]
    }
}

// Errors
public enum KeyspaceError: Error
{
    case keyLookupFailed
    case empty
}
