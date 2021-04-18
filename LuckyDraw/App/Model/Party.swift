//
//  LuckyDrawSession.swift
//  LuckyDraw
//

import Foundation
import SwiftCSV

class PartyFactory {
    private struct Keys {
        static let StaffID: String = "StaffID"
        static let Name: String = "Name"
    }
    
    static func createParty() -> Party {
        let rounds = [
            Round(index: 1, sessions: [
                RoundSession(prize: Prize(name: "Apple iPhone 11", count: 3)),
                RoundSession(prize: Prize(name: "Apple iPhone 12", count: 1)),
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
                RoundSession(prize: Prize(name: "Apple iPhone 12", count: 2)),
            ])
        ]
        
        return Party(rounds: rounds, attendees: getAttendees())
    }
    
    private static func getAttendees() -> [Attendee] {
        do {
            let csvFile: CSV! = try CSV(
                    name: "test_list",
                    extension: "csv",
                    bundle: .main,
                    delimiter: ",",
                    encoding: .utf8)

            var attendees: [Attendee] = []
            try csvFile.enumerateAsDict { dict in
                if let staffID = dict[Keys.StaffID],
                   let name = dict[Keys.Name] {
                    attendees.append(Attendee(name: name, staffID: staffID))
                }
            }
            return attendees
        } catch {
            print("parsing cvs file failed")
            return []
        }
    }
    
}

protocol LuckyDrawDelegate: class {
    func fetchCurrentAttendees() -> [Attendee]
    func getRandomWinners(with count: Int) -> [Attendee]
}

class Party {
    let rounds: [Round]
    let attendees: [Attendee]
    var winners: [Attendee] {
        rounds.flatMap { item -> [Attendee] in
            item.sessions.flatMap { $0.winners }
        }
    }
    
    init(rounds: [Round] = [], attendees: [Attendee] = []) {
        self.rounds = rounds
        self.attendees = attendees
    }
}

extension Party: LuckyDrawDelegate {
    func fetchCurrentAttendees() -> [Attendee] {
        return attendees.filter { !winners.contains($0) }
    }
    
    func getRandomWinners(with count: Int) -> [Attendee] {
        let currentAttendees = fetchCurrentAttendees()
        guard count <= currentAttendees.count else { return currentAttendees }
        return Array(currentAttendees.shuffled().shuffled()[0..<count])
    }
}
