//
//  TableViewCell.swift
//  keepsolid-notes
//
//  Created by Alex Rudoi on 35//20.
//  Copyright © 2020 Alex Rudoi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var note: Note!
    var completion: EmptyClosureType!
    
    func config(note: Note, completion: @escaping EmptyClosureType) {
        self.note = note
        self.completion = completion
        
        setStyle()
    }
    
    func setStyle() {
        nameLabel.text = note.noteName
        if note.noteDescription == "" {
            descriptionLabel.text = "No description text"
        } else {
            descriptionLabel.text = note.noteDescription
        }
    }
    
}
