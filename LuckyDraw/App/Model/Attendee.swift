//
//  Attendee.swift
//  LuckyDraw
//

import Foundation

struct Attendee {
    let name: String
    let staffID: String
    
    init(name: String, staffID: String) {
        self.name = name
        self.staffID = staffID
    }
}

extension Attendee: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.staffID == rhs.staffID
    }
}

extension Attendee: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(name) \(staffID)"
    }
}
