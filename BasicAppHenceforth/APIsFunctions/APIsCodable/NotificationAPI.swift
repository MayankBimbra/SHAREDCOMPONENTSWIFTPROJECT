//
//  NotificationAPI.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 09/01/21.
//

import Foundation

// MARK: - NotificationAPI
struct NotificationAPI: Codable {
    var count: Int?
    var notifications: [NotificationC]?
}

// MARK: - Notification
struct NotificationC: Codable {
    var title: String?
    var type, fromUserID: Int?
    var timeSince: String?
    var message: String?
    var isRead: Int?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case title, type
        case fromUserID = "from_user_id"
        case timeSince = "time_since"
        case message
        case isRead = "is_read"
        case createdAt = "created_at"
    }
}
