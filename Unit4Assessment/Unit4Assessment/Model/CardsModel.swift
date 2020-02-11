//
//  CardsModel.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct AllCards: Codable {
    let cardListType, apiVersion: String
    let cards: [Card]
}


struct Card: Codable {
    let id, cardTitle: String
    let facts: [String]
}
