//
//  DetailViewController.swift
//  RickApp
//
//  Created by Ivan Nieto on 09/11/22.
//

import UIKit

class DetailViewController: ViewController {
    @IBOutlet var PersonajeLabel: UILabel!
    @IBOutlet var PersonajeImage: UIImageView!
    @IBOutlet var RaceLabel: UILabel!
    @IBOutlet var GenderLabel: UILabel!
    
    public var personaje: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabel()
        loadRace()
        loadGender()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadImage()
    }
    
    private func loadImage() {
        let configuracion = URLSessionConfiguration.default
        let sesion = URLSession(configuration: configuracion)
        guard let laURL = URL(string: personaje!.image )
        else { return }
        
        let request = URLRequest(url: laURL)
        let tarea = sesion.dataTask(with:request) { datos, response, error in
            if  nil != error {
                print ("algo salió mal \(String(describing: error?.localizedDescription))")
                return
            }
            guard let bytes = datos else {
                print ("el response no trajo datos")
                return
            }
            
            DispatchQueue.main.async { [self] in
                PersonajeImage.image = UIImage(data: bytes)
            }

        }
        tarea.resume()
    }
    
    private func loadLabel() {
        PersonajeLabel.text = personaje?.name
    }
    
    private func loadRace() {
        RaceLabel.text = personaje?.species.rawValue
    }
    
    private func loadGender() {
        switch personaje?.gender.rawValue {
        case "Male":
            GenderLabel.text = "Masculino"
        case "Female":
            GenderLabel.text = "Femenino"
        case .none:
            GenderLabel.text = "Indefinido"
        case .some(_):
            GenderLabel.text = personaje?.gender.rawValue
        }
    }

}
