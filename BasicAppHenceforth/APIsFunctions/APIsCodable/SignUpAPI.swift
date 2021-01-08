//
//  SignUpAPI.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 05/01/21.
//

import Foundation

// MARK: - SignUpAPI
struct SignUpAPI: Codable {
    var message, token: String?
    var user: User?
}

// MARK: - User
struct User: Codable {
    var id: Int?
    var firstName, lastName, profileImage, email: String?
    var fbID, googleID, appleID: String?
    var phoneNumber: Int?
    var countryCode, countryAbbr, city, state: String?
    var country, zip, address: String?
    var lat, lng: Double?
    var resetPassToken: String?
    var isEmailVerified: Int?
    var phoneVerifyCode: String?
    var isPhoneVerified, isUserVerified, isDeactivated, isBlocked: Int?
    var deactivateReason, userDescription: String?
    var isProfileCompleted, userType: Int?
    var createdAt, updatedAt, dob: String?
    var isEmailNotified, isPushNotified, isSMSNotified, status: Int?
    var lastSeenAt, designation: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
        case email
        case fbID = "fb_id"
        case googleID = "google_id"
        case appleID = "apple_id"
        case phoneNumber = "phone_number"
        case countryCode = "country_code"
        case countryAbbr = "country_abbr"
        case city, state, country, zip, address, lat, lng
        case resetPassToken = "reset_pass_token"
        case isEmailVerified = "is_email_verified"
        case phoneVerifyCode = "phone_verify_code"
        case isPhoneVerified = "is_phone_verified"
        case isUserVerified = "is_user_verified"
        case isDeactivated = "is_deactivated"
        case isBlocked = "is_blocked"
        case deactivateReason = "deactivate_reason"
        case userDescription = "description"
        case isProfileCompleted = "is_profile_completed"
        case userType = "user_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case dob
        case isEmailNotified = "is_email_notified"
        case isPushNotified = "is_push_notified"
        case isSMSNotified = "is_sms_notified"
        case status
        case lastSeenAt = "last_seen_at"
        case designation = "designation"
    }
}
