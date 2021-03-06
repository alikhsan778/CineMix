//
//  GenreService.swift
//  CineMix
//
//  Created by omrobbie on 25/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

extension ApiService {

    func getGenresMovie(completion: @escaping ([Genre]) -> ()) {
        guard var urlComponents = URLComponents(string: BASE_URL + GENRE + MOVIE + LIST) else {return}

        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        guard let url = urlComponents.url else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let data = data else {return}

            do {
                let json = try JSONDecoder().decode(Genres.self, from: data)
                DispatchQueue.main.async {
                    completion(json.genres)
                }
            } catch {
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
}
