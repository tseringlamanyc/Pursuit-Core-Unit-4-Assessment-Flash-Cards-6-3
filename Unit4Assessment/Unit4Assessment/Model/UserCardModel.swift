//
//  UserCardModel.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct UserCards: Codable & Equatable {
    var title: String
  //  var description: String
    let identifier = UUID().uuidString
}
