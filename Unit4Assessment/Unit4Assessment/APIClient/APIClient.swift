//
//  APIClient.swift
//  Unit4Assessment
//
//  Created by Tsering Lama on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import NetworkHelper

struct CardsAPI {
    static func getCards(completionHandler: @escaping (Result<[Card], AppError>) -> ()) {
        let postmanURL = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
        guard let url = URL(string: postmanURL) else {
            completionHandler(.failure(.badURL(postmanURL)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completionHandler(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let allCards = try JSONDecoder().decode(AllCards.self, from: data)
                    let cards = allCards.cards
                    completionHandler(.success(cards))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
