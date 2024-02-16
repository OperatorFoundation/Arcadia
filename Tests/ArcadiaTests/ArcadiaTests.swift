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
    
    func testKeyspaceGetShifted() throws
    {
        let keyspace = Keyspace()
        
        for _ in 0..<128
        {
            let arcadiaID = try generateID()
            keyspace.add(key: arcadiaID)
        }

        let arcadiaIDClient = try generateID()
        let leftShifted = try keyspace.getShiftedLeft(for: arcadiaIDClient)
        print("Left shifted for \(arcadiaIDClient.identifier):")
        for left in leftShifted
        {
            print(left.identifier)
        }
        
        let rightShifted = try keyspace.getShiftedRight(for: arcadiaIDClient)
        print("Right shifted for \(arcadiaIDClient.identifier):")
        for right in rightShifted
        {
            print(right.identifier)
        }
    }
    
    func testKeyspaceGetServers() throws
    {
        let keyspace = Keyspace()
        let arcadiaIDClient = try generateID()
        
        for _ in 0..<128
        {
            let arcadiaID = try generateID()
            keyspace.add(key: arcadiaID)
        }
                        
        let servers = try keyspace.getServers(for: arcadiaIDClient)
        print("Found \(servers.count) server for \(arcadiaIDClient.identifier):")
        
        for server in servers {
            print("\(server.identifier)")
        }
    }
    
    func testKeyspaceGetPeers() throws
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
                        
        let peers = try keyspace.getPeers(for: arcadiaIDClient)
        XCTAssert(peers.count > 0)
        
        print("Found \(peers.count) peers for \(arcadiaIDClient.identifier):")
        
        for peer in peers {
            print("\(peer.identifier)")
        }
    }
    
    func testArcadiaForWreathServersFindPeers() throws
    {
        let arcadia = ArcadiaForWreathServers()

        let publicKeyA = try PrivateKey(type: .P256Signing).publicKey
        let serverA = WreathServerInfo(publicKey: publicKeyA, serverAddress: "127.0.0.1:1111")
        let publicKeyB = try PrivateKey(type: .P256Signing).publicKey
        let serverB = WreathServerInfo(publicKey: publicKeyB, serverAddress: "127.0.0.1:2222")
        let publicKeyC = try PrivateKey(type: .P256Signing).publicKey
        let serverC = WreathServerInfo(publicKey: publicKeyC, serverAddress: "127.0.0.1:3333")
        let publicKeyD = try PrivateKey(type: .P256Signing).publicKey
        let serverD = WreathServerInfo(publicKey: publicKeyD, serverAddress: "127.0.0.1:4444")
        let arcadiaIDClient = try generateID()
        
        try arcadia.addServer(wreathServer: serverA)
        try arcadia.addServer(wreathServer: serverB)
        try arcadia.addServer(wreathServer: serverC)
        try arcadia.addServer(wreathServer: serverD)
                        
        let peers = arcadia.findPeers(for: arcadiaIDClient)
        XCTAssert(peers.count > 0)
        
        print("Found \(peers.count) peers for \(arcadiaIDClient.identifier):")
        
        for peer in peers {
            print("\(peer.serverAddress)")
        }
    }

    func testBigIntFromUInt()
    {
        let leadingOneBigInt = ArcadiaID.leadingOne
        
        print("Leading One as BigInt = \(leadingOneBigInt)")
    }
    
    func generateID() throws -> ArcadiaID
    {
        let key = try PrivateKey(type: .P256Signing).publicKey
        return key.arcadiaID!
    }
}
