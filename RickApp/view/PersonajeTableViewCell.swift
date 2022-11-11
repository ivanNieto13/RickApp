//
//  PersonajeTableViewCell.swift
//  RickApp
//
//  Created by Ivan Nieto on 03/11/22.
//

import UIKit

class PersonajeTableViewCell: UITableViewCell {
    @IBOutlet public weak var nameLabel: UILabel!
    
    public var personajeSelected: Personaje?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }


}
