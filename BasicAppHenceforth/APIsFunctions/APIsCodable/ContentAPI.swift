//
//  ContentAPI.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 09/01/21.
//

import Foundation

// MARK: - ContentAPI
struct ContentAPI: Codable {
    var id: Int?
    var image, title, content: String?
}
