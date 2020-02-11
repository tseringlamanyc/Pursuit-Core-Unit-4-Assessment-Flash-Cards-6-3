//
//  CardsModel.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct AllCards: Codable & Equatable {
    let cardListType, apiVersion: String
    let cards: [Card]
}

struct Card: Codable & Equatable {
    let id, cardTitle: String
    let facts: [String]
    
    static func getCards(from jsonData: Data) -> [Card] {
        do {
            let allCards = try JSONDecoder().decode(AllCards.self, from: jsonData)
            return allCards.cards
        } catch {
            print(error)
            return []
        }
    }
}
