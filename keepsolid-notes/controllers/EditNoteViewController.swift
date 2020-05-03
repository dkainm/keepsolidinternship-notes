//
//  EditNoteViewController.swift
//  keepsolid-notes
//
//  Created by Alex Rudoi on 35//20.
//  Copyright © 2020 Alex Rudoi. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController, UITextViewDelegate {
  
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var note: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = note.noteName
        descriptionTextView.text = note.noteDescription
        
        titleTextField.addTarget(self, action: #selector(EditNoteViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        descriptionTextView.delegate = self
        navigationItem.rightBarButtonItem = nil
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if titleTextField.text?.isEmpty != true {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if titleTextField.text?.isEmpty != true {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        }
    }
    
    @objc func done() {
        if titleTextField.text?.isEmpty == true {
            print("Failed to save the note: Title Text Field are empty")
        } else {
            note.noteName = titleTextField.text!
            note.noteDescription = descriptionTextView.text!
            
            DatabaseManager.instance.updateNote()
            
            print("Note edited")
            navigationController?.popViewController(animated: true)
            
        }
    }
    
}
