//
//  ChatAPI.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 09/01/21.
//

import Foundation


// MARK: - ChatAPIElements
typealias ChatAPI = [ChatAPIElement]


// MARK: - ChatAPIElement
struct ChatAPIElement: Codable {
    var lastSeenAt: String?
    var isRead, userFrom: Int?
    var countryCode: String?
    var deletedForMe, userTo: Int?
    var lastName: String?
    var fromMe: Int?
    var participant: String?
    var unreadCount: Int?
    var message, email: String?
    var status: Int?
    var createdAt, media, firstName, chatAPIDescription: String?
    var timeSince: String?
    var phoneNumber, deletedBy: Int?
    var profileImage: String?
    var id: Int?
    var conversationID: String?

    enum CodingKeys: String, CodingKey {
        case lastSeenAt = "last_seen_at"
        case isRead = "is_read"
        case userFrom = "user_from"
        case countryCode = "country_code"
        case deletedForMe = "deleted_for_me"
        case userTo = "user_to"
        case lastName = "last_name"
        case fromMe = "from_me"
        case participant
        case unreadCount = "unread_count"
        case message, email, status
        case createdAt = "created_at"
        case media
        case firstName = "first_name"
        case chatAPIDescription = "description"
        case timeSince = "time_since"
        case phoneNumber = "phone_number"
        case deletedBy = "deleted_by"
        case profileImage = "profile_image"
        case id
        case conversationID = "conversation_id"
    }
}
