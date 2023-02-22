//
//  CircularArray.swift
//  Arcadia
//
//  Created by Dr. Brandon Wiley on 2/22/23.
//

import Foundation

public class CircularArray<T> where T: Equatable, T: Comparable
{
    var array: [T]
    var start: Int
    var cursor: Int

    public init(array: [T], start: Int = 0) throws
    {
        guard (start >= 0) && (start < array.endIndex) else
        {
            throw CircularArrayError.outOfBounds
        }

        self.array = array
        self.start = start
        self.cursor = start
    }

    public func get() -> T?
    {
        guard self.array.count > 0 else
        {
            return nil
        }

        return self.array[self.cursor]
    }

    public func get(index: Int) -> T?
    {
        guard index >= 0, index < self.array.endIndex - 1 else
        {
            return nil
        }

        return self.array[index]
    }

    public func next() -> T?
    {
        guard self.array.count > 0 else
        {
            return nil
        }

        self.cursor = self.cursor + 1
        if self.cursor == self.array.endIndex
        {
            self.cursor = 0
        }

        guard self.cursor != self.start else
        {
            return nil
        }

        return self.get()
    }

    public func previous() -> T?
    {
        guard self.array.count > 0 else
        {
            return nil
        }

        self.cursor = self.cursor - 1
        if self.cursor == 0
        {
            self.cursor = self.array.endIndex - 1
        }

        guard self.cursor != self.start else
        {
            return nil
        }

        return self.get()
    }

    public func contains(_ value: T) -> Bool
    {
        guard self.array.count > 0 else
        {
            return false
        }

        self.reset()

        return self.index(of: value) != nil
    }

    public func index(of value: T) -> Int?
    {
        guard self.array.count > 0 else
        {
            return nil
        }

        self.reset()
        defer
        {
            self.reset()
        }

        var item = self.get()
        while item != nil
        {
            if item == value
            {
                return self.cursor
            }
            else
            {
                item = self.next()
            }
        }

        return nil
    }

    public func closestLess(than value: T) -> Int?
    {
        guard let lessThanOrEqual = self.closestLessThanOrEqual(to: value) else
        {
            return nil
        }

        let item = self.array[lessThanOrEqual]
        if value == item
        {
            if lessThanOrEqual == 0
            {
                return self.array.endIndex - 1
            }
            else
            {
                return lessThanOrEqual - 1
            }
        }
        else
        {
            return lessThanOrEqual
        }
    }

    public func closestGreater(than value: T) -> Int?
    {
        guard let greaterThanOrEqual = self.closestGreaterThanOrEqual(to: value) else
        {
            return nil
        }

        let item = self.array[greaterThanOrEqual]
        if value == item
        {
            if greaterThanOrEqual == (self.array.endIndex - 1)
            {
                return 0
            }
            else
            {
                return greaterThanOrEqual + 1
            }
        }
        else
        {
            return greaterThanOrEqual
        }
    }

    public func closestLessThanOrEqual(to value: T) -> Int?
    {
        guard self.array.count > 0 else
        {
            return nil
        }

        self.set(index: 0)
        defer
        {
            self.reset()
        }

        guard let firstItem = self.get() else
        {
            return nil
        }

        if value < firstItem
        {
            let _ = self.previous()
            return self.cursor
        }
        else if value == firstItem
        {
            return self.cursor
        }

        while true
        {
            guard let nextItem = self.next() else
            {
                return nil
            }

            if value == nextItem
            {
                return self.cursor
            }
            else if value < nextItem
            {
                let _ = self.previous()
                return self.cursor
            }
        }
    }

    public func closestGreaterThanOrEqual(to value: T) -> Int?
    {
        guard let lessThanOrEqualToIndex = self.closestLessThanOrEqual(to: value) else
        {
            return nil
        }

        let item = self.array[lessThanOrEqualToIndex]

        if lessThanOrEqualToIndex == (self.array.endIndex - 1)
        {
            if value == item
            {
                return lessThanOrEqualToIndex
            }
            else
            {
                return 0
            }
        }
        else
        {
            return lessThanOrEqualToIndex + 1
        }
    }

    public func reset()
    {
        self.cursor = self.start
    }

    public func set(index: Int)
    {
        self.start = index
        self.cursor = index
    }

    public func advance(offset: Int) throws
    {
        guard offset > 0 else
        {
            throw CircularArrayError.outOfBounds
        }

        self.cursor = self.cursor + offset
        if self.cursor >= self.array.endIndex
        {
            self.cursor = self.cursor - self.array.endIndex
        }
    }

    public func retreat(offset: Int) throws
    {
        guard offset > 0 else
        {
            throw CircularArrayError.outOfBounds
        }

        self.cursor = self.cursor - offset
        if self.cursor < 0
        {
            self.cursor = self.cursor + self.array.endIndex
        }
    }
}

public enum CircularArrayError: Error
{
    case outOfBounds
}
