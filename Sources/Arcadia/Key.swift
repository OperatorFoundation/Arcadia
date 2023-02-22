//
//  Key.swift
//  
//
//  Created by Dr. Brandon Wiley on 2/7/23.
//

import Foundation

import BigNumber
import Keychain

public class Key: Codable, Equatable, Comparable, Hashable
{
    static let min = BInt(0)
    static let max = BInt(UInt64.max)
    static let leadingOne = BInt(UInt64(9223372036854775808)) // A 64-bit number where the leftmost bit is 1.

    // Equatable
    public static func == (lhs: Key, rhs: Key) -> Bool
    {
        return lhs.identifier == rhs.identifier
    }

    // Comparable
    public static func < (lhs: Key, rhs: Key) -> Bool
    {
        return lhs.identifier < rhs.identifier
    }

    // Public constants
    public let identifier: BInt

    // Public initializers
    public convenience init(publicKey: PublicKey) throws
    {
        guard let data = publicKey.data else
        {
            throw KeyError.publicKeySerializationFailed
        }

        self.init(data: data)
    }

    public init(identifier: BInt)
    {
        self.identifier = identifier
    }

    // Private initializers
    convenience init(data: Data)
    {
        self.init(identifier: BInt(bytes: data.array))
    }

    // Hashable
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.identifier)
    }

    public func increment() -> Key
    {
        var nextIdentifier = self.identifier + BInt(1)
        if nextIdentifier > Self.max
        {
            nextIdentifier = nextIdentifier - Self.max
        }

        return Key(identifier: nextIdentifier)
    }

    public func decrement() -> Key
    {
        var nextIdentifier = self.identifier - BInt(1)
        if nextIdentifier < Self.min
        {
            nextIdentifier = nextIdentifier + Self.max
        }

        return Key(identifier: nextIdentifier)
    }

    public func shiftLeft() -> (Key, Key)
    {
        let shifted0 = self.identifier * BInt(2)
        let shifted1 = shifted0 + BInt(1)

        return (Key(identifier: shifted0), Key(identifier: shifted1))
    }

    public func shiftRight() -> (Key, Key)
    {
        let shifted0 = self.identifier / BInt(2)
        let shifted1 = shifted0 + Self.leadingOne

        return (Key(identifier: shifted0), Key(identifier: shifted1))
    }
}

// Errors
public enum KeyError: Error
{
    case publicKeySerializationFailed
}
