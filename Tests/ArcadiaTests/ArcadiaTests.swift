import XCTest

import BigNumber
import Keychain

@testable import Arcadia

final class ArcadiaTests: XCTestCase 
{
    func testKeyspaceAdd() throws
    {
        let keyspace = Keyspace()
        let arcadiaID1 = try generateID()
        let arcadiaID2 = try generateID()
        
        keyspace.add(key: arcadiaID1)
        keyspace.add(key: arcadiaID2)
        
        XCTAssert(keyspace.keys.array.count == 2)
    }
    
    func testKeyspaceRemove() throws
    {
        let keyspace = Keyspace()
        let arcadiaID1 = try generateID()
        let arcadiaID2 = try generateID()
        
        keyspace.add(key: arcadiaID1)
        keyspace.add(key: arcadiaID2)
        
        XCTAssert(keyspace.keys.array.count == 2)
        
        keyspace.remove(key: arcadiaID1)
        
        XCTAssert(keyspace.keys.array.count == 1)
        XCTAssert(keyspace.keys.array[0] == arcadiaID2)
    }
    
    func testKeyspaceGetNext() throws
    {
        let keyspace = Keyspace()
        let arcadiaIDa = try generateID()
        let arcadiaIDb = try generateID()
        let arcadiaIDc = try generateID()
        
        keyspace.add(key: arcadiaIDa)
        keyspace.add(key: arcadiaIDb)
        
        XCTAssert(keyspace.keys.array.count == 2)
        
        let nextFromC = try keyspace.getNext(for: arcadiaIDc)
        
        print("Next over from \(arcadiaIDc.identifier) is \(nextFromC.identifier)")
    }
    
    func testKeyspaceGetPrevious() throws
    {
        let keyspace = Keyspace()
        let arcadiaIDa = try generateID()
        let arcadiaIDb = try generateID()
        let arcadiaIDc = try generateID()
        
        keyspace.add(key: arcadiaIDa)
        keyspace.add(key: arcadiaIDb)
        
        XCTAssert(keyspace.keys.array.count == 2)
        
        let previousToC = try keyspace.getPrevious(for: arcadiaIDc)
        
        print("Previous to \(arcadiaIDc.identifier) is \(previousToC.identifier)")
    }
    
    // TODO: Shifted left and shifted right return the same two results and the same results as each other
    func testKeyspaceGetShifted() throws
    {
        let keyspace = Keyspace()
        let arcadiaIDa = try generateID()
        let arcadiaIDb = try generateID()
        let arcadiaIDc = try generateID()
        let arcadiaIDd = try generateID()
        let arcadiaIDClient = try generateID()
        
        keyspace.add(key: arcadiaIDa)
        keyspace.add(key: arcadiaIDb)
        keyspace.add(key: arcadiaIDc)
        keyspace.add(key: arcadiaIDd)
                
        let leftShifted = try keyspace.getShiftedLeft(for: arcadiaIDClient)
        print("Shifted left for \(arcadiaIDClient.identifier) is \(leftShifted[0].identifier), \(leftShifted[1].identifier)")
        
        let rightShifted = try keyspace.getShiftedLeft(for: arcadiaIDClient)
        print("Shifted right for \(arcadiaIDClient.identifier) is \(rightShifted[0].identifier), \(rightShifted[1].identifier)")
    }
    
    func testKeyspaceGetServers() throws
    {
        let keyspace = Keyspace()
        let arcadiaIDa = try generateID()
        let arcadiaIDb = try generateID()
        let arcadiaIDc = try generateID()
        let arcadiaIDd = try generateID()
        let arcadiaIDClient = try generateID()
        
        keyspace.add(key: arcadiaIDa)
        keyspace.add(key: arcadiaIDb)
        keyspace.add(key: arcadiaIDc)
        keyspace.add(key: arcadiaIDd)
                        
        let servers = try keyspace.getServers(for: arcadiaIDClient)
        print("Found \(servers.count) server for \(arcadiaIDClient.identifier):")
        
        for server in servers {
            print("\(server.identifier)")
        }
    }
    
    // TODO: Initializing ArcadiaID.leadingOne with a UInt instead of a UInt64 because this follows a code path that leads to public init(_ n: UInt){ self.init(limbs: [Limb(n)]) }
    func testBigIntFromUInt()
    {
        let leadingOneUInt = UInt(9223372036854775808)
        let leadingOneBigInt = BInt(leadingOneUInt)
        
        print("Leading One as BigInt = \(leadingOneBigInt)")
    }
    
    
    // TODO: This follows a code path in the BInt Library that eventually leads to this init: self.init(Int(source)) which fails because this number is too large for an Int by 1
    func testBigIntFromUInt64()
    {
        let leadingOneUInt64 = UInt64(9223372036854775808)
        print("leadingOneUInt64 = \(leadingOneUInt64)")
        print("Int max = \(Int.max)")
        print("leading one is \(leadingOneUInt64 - UInt64(Int.max)) bigger than Int.max")
        let leadingOneBigInt = BInt(leadingOneUInt64)
        
        print("Leading One as BigInt = \(leadingOneBigInt)")
    }
    
    func generateID() throws -> ArcadiaID
    {
        let key = try PrivateKey(type: .P256Signing).publicKey
        return key.arcadiaID!
    }
}
