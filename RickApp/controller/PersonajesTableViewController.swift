//
//  PersonajesTableViewController.swift
//  RickApp
//
//  Created by Ivan Nieto on 03/11/22.
//

import UIKit

class PersonajesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    private var personajes: [Result] = [Result]()
    private var personajeSelected: Result?
    private var viewModel: PersonajeViewModel = PersonajeViewModel()
    private var loaded = false
    private var ad = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ad.internetStatus {
            fetchCharacters()
        }
        else {
            let ac = UIAlertController(title:"Error", message:"Lo sentimos, pero al parecer no hay conexión a Internet", preferredStyle: .alert)
            let action = UIAlertAction(title: "Enterado", style: .default)
            ac.addAction(action)
            self.present(ac, animated: true)
        }
    }
    
    func fetchCharacters() {
        switch viewModel.personajesState {
        case .initial:
            personajes = [Result]()
        case .loading:
            personajes = [Result]()
        case .loaded(personajes: let characters):
            personajes = characters.results
            tableView.reloadData()
            loaded = true
        case .error(errorMessage: _):
            personajes = [Result]()
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if personajes.count > 0 {
            return personajes.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personajeTableViewCell", for: indexPath) as! PersonajeTableViewCell
        cell.nameLabel.text = personajes.count > 0 ? personajes[indexPath.row].name : "Haz click para cargar..."
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if loaded {
            personajeSelected = personajes[indexPath.row]
            self.performSegue(withIdentifier: "DetailSegue", sender: Self.self)
        } else {
            if ad.internetStatus {
                fetchCharacters()
            }
            else {
                let ac = UIAlertController(title:"Error", message:"Lo sentimos, pero al parecer no hay conexión a Internet", preferredStyle: .alert)
                let action = UIAlertAction(title: "Enterado", style: .default)
                ac.addAction(action)
                self.present(ac, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        destination.personaje = personajeSelected
    }
    
}
