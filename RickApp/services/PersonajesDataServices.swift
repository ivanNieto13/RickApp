//
//  PersonajesDataServices.swift
//  RickApp
//
//  Created by Ivan Nieto on 05/11/22.
//

import Foundation
import Combine

class RickAndMortyDataServices: RickAndMortyService {
    func getAllCharacters() -> AnyPublisher<Personaje, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://rickandmortyapi.com/api/character")!)
            .map({$0.data})
            .decode(type: Personaje.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
