//
//  AddNoteViewController.swift
//  keepsolid-notes
//
//  Created by Alex Rudoi on 35//20.
//  Copyright © 2020 Alex Rudoi. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var note: Note!
    var noteName = ""
    var noteDescription = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.addTarget(self, action: #selector(EditNoteViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        navigationItem.rightBarButtonItem = nil
        
        titleTextField.becomeFirstResponder()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        descriptionTextView.becomeFirstResponder()
        return true
    }
    
    @objc func done() {
        if titleTextField.text?.isEmpty == true {
            print("Failed to save the note: Title Text Field are empty")
        } else {
            noteName = titleTextField.text!
            noteDescription = descriptionTextView.text!
            
            DatabaseManager.instance.addNote(name: noteName, description: noteDescription) { (done) in
                if done {
                    print("Note added")
                    navigationController?.popViewController(animated: true)
                } else {
                    print("Someting went wrong. Try again")
                }
            }
        }
    }

}
