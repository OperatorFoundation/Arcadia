//
//  Dictionary+match.swift
//  
//
//  Created by Dr. Brandon Wiley on 2/9/23.
//

import Foundation

extension Dictionary
{
    public func match(by matchFunction: (Key) -> Bool) -> [Value]
    {
        var results: [Value] = []

        for (key, value) in self
        {
            if matchFunction(key)
            {
                results.append(value)
            }
        }

        return results
    }
}
