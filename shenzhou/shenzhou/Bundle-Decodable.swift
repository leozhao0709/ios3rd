//
//  Bundle-Decodable.swift
//  shenzhou
//
//  Created by Lei Zhao on 10/26/20.
//
//

import Foundation

extension Bundle {
  func decode<T: Codable>(path: String) -> T {
    guard let fileUrl = Bundle.main.url(forResource: path, withExtension: nil) else {
      fatalError("load url fail")
    }
    guard   let data = try? Data(contentsOf: fileUrl) else {
      fatalError("load data from file uel fail")
    }
    guard   let decodeData = try? JSONDecoder().decode(T.self, from: data) else {
      fatalError("json decode fail")
    }
    return decodeData
  }
}