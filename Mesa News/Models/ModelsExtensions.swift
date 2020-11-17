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

//extension Decodable {
//    func decode(data: Data, resultType: ) -> Error? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(resultType, from: data)
//            print(decodedData)
//            return decodedData
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}


