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
    var id, userFrom, userTo: Int?
    var conversationID, message, media: String?
    var isRead, deletedForMe: Int?
    var createdAt: String?
    var deletedBy: Int?
    var firstName, lastName, profileImage, email: String?
    var phoneNumber: Int?
    var countryCode, chatAPIDescription: String?
    var status: Int?
    var lastSeenAt, participant: String?
    var fromMe: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userFrom = "user_from"
        case userTo = "user_to"
        case conversationID = "conversation_id"
        case message, media
        case isRead = "is_read"
        case deletedForMe = "deleted_for_me"
        case createdAt = "created_at"
        case deletedBy = "deleted_by"
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
        case email
        case phoneNumber = "phone_number"
        case countryCode = "country_code"
        case chatAPIDescription = "description"
        case status
        case lastSeenAt = "last_seen_at"
        case participant
        case fromMe = "from_me"
    }
}
