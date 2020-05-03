//
//  DatabaseManager.swift
//  keepsolid-notes
//
//  Created by Alex Rudoi on 35//20.
//  Copyright © 2020 Alex Rudoi. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager {
    
    static var instance = DatabaseManager()
    
    func addNote(name: String, description: String, completion: (_ finished: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let note = Note(context: managedContext)
        note.noteName = name
        note.noteDescription = description
        
        do {
            try managedContext.save()
            print("Note saved")
            completion(true)
        } catch {
            print("Failed to save the note: ", error.localizedDescription)
            completion(false)
        }
    }
    
    func fetchData(completion: (_ complete: Bool, _ noteArray: [Note]?) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            let noteArray = try managedContext.fetch(request) as! [Note]
            print("Data fetched")
            completion(true, noteArray)
        } catch {
            print("Unable to fetch data: ", error.localizedDescription)
            completion(false, nil)
        }
    }
    
    func deleteNote(note: Note) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(note)
        
        do {
            try managedContext.save()
            print("Note deleted")
        } catch {
            print("Failed to delete the note: ", error.localizedDescription)
        }
    }
    
    func updateNote() {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        do {
            try managedContext.save()
            print("Note updated")
        } catch {
            print("Failed to update the note: ", error.localizedDescription)
            
        }
    }
    
}
