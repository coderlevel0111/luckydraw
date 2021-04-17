//
//  LuckyDrawSession.swift
//  LuckyDraw
//

import Foundation

class PartyFactory {
    static func createParty() -> Party {
        let rounds = [
            Round(index: 1, sessions: [
                RoundSession(prize: Prize(name: "Apple iPhone 12", count: 1)),
                RoundSession(prize: Prize(name: "Apple iPhone 11", count: 3)),
                RoundSession(prize: Prize(name: "Apple iPhone 12 pro max", count: 5)),
                RoundSession(prize: Prize(name: "Apple watch", count: 7)),
            ]),
            Round(index: 2, sessions: [
                RoundSession(prize: Prize(name: "test 1", count: 1)),
                RoundSession(prize: Prize(name: "test 2", count: 3)),
                RoundSession(prize: Prize(name: "test 3", count: 10)),
            ]),
            Round(index: 3, sessions: [
                RoundSession(prize: Prize(name: "Apple iPhone 12", count: 1)),
            ]),
            Round(index: 4, sessions: [
                RoundSession(prize: Prize(name: "Apple iPhone 12", count: 1)),
                RoundSession(prize: Prize(name: "Apple iPhone 12", count: 7)),
            ]),
            Round(index: 5, customTitle: "Suprise", sessions: [
                RoundSession(prize: Prize(name: "Apple iPhone 12", count: 1)),
                RoundSession(prize: Prize(name: "Apple iPhone 12", count: 3)),
                RoundSession(prize: Prize(name: "Apple iPhone 12", count: 5)),
                RoundSession(prize: Prize(name: "Apple iPhone 12", count: 7)),
            ])
        ]
        return Party(rounds: rounds, attendees: [])
    }
    
}


class Party {
    let rounds: [Round]
    let attendees: [Attendee]
    private(set) var winners: [Attendee] = []
    
    init(rounds: [Round] = [], attendees: [Attendee] = []) {
        self.rounds = rounds
        self.attendees = attendees
        self.winners = []
    }
}
