//
//  PublicKey+Key.swift
//  
//
//  Created by Dr. Brandon Wiley on 2/22/23.
//

import Foundation

import Keychain

extension PublicKey
{
    public var arcadiaKey: ArcadiaID?
    {
        do
        {
            return try ArcadiaID(publicKey: self)
        }
        catch
        {
            return nil
        }
    }
}
