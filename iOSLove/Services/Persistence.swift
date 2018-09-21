//
//  Persistence.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/29/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation

internal enum PersistenceError: Error {
    case unableToEncode(Error)
    case unableToWrite(Error)
    case unableToRead(Error)
    case unableToDecode(Error)
}

internal protocol Persistence {
    func store<T: Encodable>(data: T, key: String) throws
    func retrive<T: Decodable>(key: String) throws -> T?
}

internal func PersistenceDefault() -> Persistence {
    return PersistenceImpl()
}

private final class PersistenceImpl {
    private lazy var baseURL = FileManager.default.url(for: .documentDirectory,
                                                       in: .userDomainMask,
                                                       appropriateFor: nil,
                                                       create: false)

    private func URL(forKey key: String) -> URL {
        return baseURL.appendingPathComponent(key)
    }
}

extension PersistenceImpl: Persistence {
    func store<T: Encodable>(data: T, key: String) throws {
        let archiver = NSKeyedArchiver.init(requiringSecureCoding: true)
        do {
            try archiver.encodeEncodable(data, forKey: key)
        } catch {
            throw PersistenceError.unableToEncode(error)
        }
        let url = URL(forKey: key)
        do {
            try archiver.encodedData.write(to: url, options: .atomic)
            
        } catch {
            throw PersistenceError.unableToWrite(error)
        }
    }
    
    func retrive<T: Decodable>(key: String) throws -> T? {
        let url = URL(forKey: key)
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch CocoaError.fileReadNoSuchFile {
            return nil
        } catch {
            throw PersistenceError.unableToRead(error)
        }
        let unarchiver: NSKeyedUnarchiver
        do {
            unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
        } catch {
            throw PersistenceError.unableToDecode(error)
        }
        return unarchiver.decodeDecodable(T.self, forKey: key)
    }
}
