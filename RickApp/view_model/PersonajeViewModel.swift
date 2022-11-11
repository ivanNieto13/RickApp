//
//  PersonajeViewModel.swift
//  RickApp
//
//  Created by Ivan Nieto on 05/11/22.
//

import Foundation
import Combine

class PersonajeViewModel : ObservableObject {
    @Published var personajesState: PersonajeViewModelState = PersonajeViewModelState.initial
    
    let rickAndMoortyDataService: RickAndMortyDataServices = RickAndMortyDataServices()
    var cancellable = Set<AnyCancellable>()
        
    init() {
        getAllCharacters()
    }
    
    func getAllCharacters() {
        personajesState = PersonajeViewModelState.loading
        rickAndMoortyDataService.getAllCharacters()
            .sink { [weak self] completion in
                switch completion {
                    case .finished:
                        print("finish")
                    case .failure(let error):
                        self?.personajesState=PersonajeViewModelState.error(errorMessage: "\(error)")
                    }
            } receiveValue: { [weak self] Personajes in
                self?.personajesState = PersonajeViewModelState.loaded(personajes: Personajes)
            }
            .store(in: &cancellable)
    }
    
}
