//
//  ViewController.swift
//  keepsolid-notes
//
//  Created by Alex Rudoi on 35//20.
//  Copyright © 2020 Alex Rudoi. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var deleteBarButton: UIBarButtonItem!
    
    var note: Note!
    var noteArray = [Note]()
    let cellId = "TableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func callDelegates() {
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = true
        tv.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func fetchData() {
        DatabaseManager.instance.fetchData { (done, noteArray) in
            if done, let noteArray = noteArray {
                
                self.noteArray = noteArray
                
                if noteArray.count > 0 {
                    tv.isHidden = false
                    tv.reloadData()
                } else {
                    tv.isHidden = true
                    tv.reloadData()
                }
                
                if noteArray.count > 1 {
                    deleteBarButton.isEnabled = true
                } else {
                    deleteBarButton.isEnabled = false
                }
            }
        }
    }
    
    @IBAction func deleteAllNotesTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Are you sure you want to delete all tasks?", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { UIAlertAction in
            
            self.noteArray.forEach { note in
                DatabaseManager.instance.deleteNote(note: note)
            }
            
            self.fetchData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
            print("Cancel Pressed")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addNoteTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "AddNote", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "AddNoteViewController") as! AddNoteViewController
        navigationController?.show(viewController, sender: nil)
    }
    
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        let note = noteArray[indexPath.row]
        
        cell.config(note: note, completion: {self.reloadTable()})
        
        return cell
    }
    
    func reloadTable() {
        fetchData()
        tv.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = noteArray[indexPath.row]
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "EditNote", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "EditNoteViewController") as! EditNoteViewController
        viewController.note = note
        navigationController?.show(viewController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let note = noteArray[indexPath.row]
        
        if editingStyle == .delete {
            DatabaseManager.instance.deleteNote(note: note)
            fetchData()
        }
    }
    
    
}
