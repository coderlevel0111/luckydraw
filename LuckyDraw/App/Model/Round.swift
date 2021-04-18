//
//  Round.swift
//  LuckyDraw
//

import Foundation

class Round {
    private let index: Int
    private let customTitle: String?
    var title: String {
        return customTitle ?? "Round \(index)"
    }
    
    let sessions: [RoundSession]
    var prizes: [Prize] {
        return sessions.map{ $0.prize }
    }
    
    init(index: Int, customTitle: String? = nil, sessions: [RoundSession] = []) {
        self.index = index
        self.customTitle = customTitle
        self.sessions = sessions
    }
}

class RoundSession {
    let prize: Prize
    private(set) var winners: [Attendee] = []
    
    init(prize: Prize) {
        self.prize = prize
    }
    
    func updateWinners(_ winners: [Attendee]) {
        self.winners.append(contentsOf: winners)
    }
    
    func clearWinners() {
        winners.removeAll()
    }
}

struct Prize {
    let name: String
    let count: Int
    
    var countDescription: String {
        return "x \(count)"
    }
    
    init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
    
}
