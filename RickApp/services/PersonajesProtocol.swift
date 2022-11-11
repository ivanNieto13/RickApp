//
//  PersonajesProtocol.swift
//  RickApp
//
//  Created by Ivan Nieto on 05/11/22.
//

import Foundation
import Combine

protocol RickAndMortyService {
    func getAllCharacters () -> AnyPublisher<Personaje,Error>
}
