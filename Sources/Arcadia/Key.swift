//
//  Key.swift
//  
//
//  Created by Dr. Brandon Wiley on 2/7/23.
//

import Foundation

import BigNumber

public class Key: Codable, Equatable, Comparable, Hashable
{
    public static func == (lhs: Key, rhs: Key) -> Bool
    {
        return lhs.identifier == rhs.identifier
    }

    public static func < (lhs: Key, rhs: Key) -> Bool
    {
        return lhs.identifier < rhs.identifier
    }

    public let identifier: BInt

    public init(identifier: BInt)
    {
        self.identifier = identifier
    }

    public convenience init(data: Data)
    {
        self.init(identifier: BInt(bytes: data.array))
    }

    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.identifier)
    }
}
