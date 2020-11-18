//
//  ModelsExtensions.swift
//  Mesa News
//
//  Created by Diana Monteiro on 15/11/20.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(self)
            return encodedData
        } catch {
            print(error)
            return nil
        }
    }
}

extension Data {
    func decode<T:Decodable>() -> T? {
        let decoder = JSONDecoder()
        do {
            let allNews = try decoder.decode(T.self, from: self)
            return allNews
        } catch {
            print(error)
            return nil
        }
    }
}


