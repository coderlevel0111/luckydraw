//
//  LuckyDrawTests.swift
//  LuckyDrawTests
//

import XCTest
@testable import LuckyDraw

class LuckyDrawTests: XCTestCase {

    func test_luckydraw_finished_current_attendees_reduced() throws {
        let party = PartyFactory.createParty()
        let originalAttendees = party.attendees
        
        let session1 = party.rounds[0].sessions[0]
        let session2 = party.rounds[1].sessions[0]
        
        session1.updateWinners(party.getRandomWinners(with: session1.prize.count))
        session2.updateWinners(party.getRandomWinners(with: session2.prize.count))
        
        let newAttendess = party.fetchCurrentAttendees()
        XCTAssertEqual(originalAttendees.count,
                       newAttendess.count + session1.prize.count + session2.prize.count)
        
        party.winners.forEach { winner in
            if newAttendess.contains(winner) {
                XCTFail("one people can only win one prize")
            }
        }
    }

    func test_luckydraw_finished_clear_all_winners() throws {
        let party = PartyFactory.createParty()
        let originalAttendees = party.fetchCurrentAttendees()
        
        guard let round = party.rounds.first,
              let session = round.sessions.first else {
            XCTFail()
            return
        }
        
        session.updateWinners(party.getRandomWinners(with: session.prize.count))
        
        XCTAssertEqual(originalAttendees.count,
                       party.fetchCurrentAttendees().count + session.prize.count)
        
        party.winners.forEach { winner in
            if party.fetchCurrentAttendees().contains(winner) {
                XCTFail("one people can only win one prize")
            }
        }
        
        session.clearWinners()
        XCTAssertEqual(originalAttendees.count, party.fetchCurrentAttendees().count)
        XCTAssertEqual(party.winners.count, 0)
    }
    
    func test_luckydraw_finished_clear_one_session_winners() throws {
        let party = PartyFactory.createParty()
        let originalAttendees = party.fetchCurrentAttendees()
        let session1 = party.rounds[0].sessions[0]
        let session2 = party.rounds[1].sessions[0]
        
        session1.updateWinners(party.getRandomWinners(with: session1.prize.count))
        session2.updateWinners(party.getRandomWinners(with: session2.prize.count))
        
        XCTAssertEqual(originalAttendees.count,
                       party.fetchCurrentAttendees().count + session1.prize.count + session2.prize.count)
        
        session1.clearWinners()
        XCTAssertEqual(originalAttendees.count,
                       party.fetchCurrentAttendees().count + session2.prize.count)
        XCTAssertEqual(party.winners.count, session2.prize.count)
        XCTAssertEqual(session1.winners.count, 0)
        party.winners.forEach { winner in
            if party.fetchCurrentAttendees().contains(winner) {
                XCTFail("one people can only win one prize")
            }
        }
    }
}
