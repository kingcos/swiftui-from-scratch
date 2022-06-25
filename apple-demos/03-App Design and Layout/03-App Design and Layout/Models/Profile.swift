/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A model object that stores user profile data.
*/

import Foundation

struct Profile {
    var username: String
    var prefersNotifications: Bool
    var seasonalPhoto: Season = .winter
    var goalDate = Date()
    
//    static let `default` = Self(username: "kingcos", prefersNotifications: true, seasonalPhoto: .winter)
    static let `default` = Profile(username: "kingcos")
    
    init(username: String, prefersNotifications: Bool = true, seasonalPhoto: Season = .winter) {
        self.username = username
        self.prefersNotifications = prefersNotifications
        self.seasonalPhoto = seasonalPhoto
        self.goalDate = Date()
    }
    
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"
        
        var id: String { rawValue }
    }
}
