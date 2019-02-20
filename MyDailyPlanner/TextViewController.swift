//
//  TextViewController.swift
//  MyDailyPlanner
//
//  Created by Ivan Ignatkov on 2019-01-30.
//  Copyright © 2019 TechCompetence. All rights reserved.
//

import Foundation
import UIKit


class TextViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var textLabelName: UILabel!
    
    var name = ""
    var text = ""
    var item = 0
    
    func initData(name: String, text: String, item: Int) {
        self.name = name
        self.text = text
        self.item = item
    }

    
    @IBAction func addNote(_ sender: Any) {
        self.view.endEditing(true)
        setDescription(noteText.text, atItem: item)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabelName.text = name
        noteText.text = text
        
        noteText.font = UIFont(name: "Times New Roman", size: 19)
        noteText.isEditable = true
        noteText.autocorrectionType = .yes
        noteText.layer.cornerRadius = 10
        
        // makes web links clickable//
       
        
        noteText.delegate = self
    }
    
    
    
    /*
    private func textViewDidBeginEditing(_ textField: UITextField) {
        
        if noteText.text == "Type something here.." {
            noteText.text = ""
            noteText.textColor = UIColor.black
            noteText.font = UIFont(name: "Verdana", size: 17)
            noteText.font = UIFont.boldSystemFont(ofSize: 17)
        
        }
    }
 */
 
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
        if noteText.text == /*"Type something here..."*/ "" {
            noteText.text = ""
            noteText.textColor = UIColor.black
            noteText.font = UIFont(name: "Times New Roman", size: 19)
            //noteText.font = UIFont.boldSystemFont(ofSize: 17)
            
        }
        return true
    }
    
   // private func textViewDidEndEditing(_ textField: UITextField) {
       
        
        
   // }
    
   // func textFieldShouldReturn(textField: UITextField) -> Bool {
    //  noteText.resignFirstResponder()
    //    return true;
    //}

    //textfield func for the touch on BG
     //func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
     //   noteText.resignFirstResponder()
       // self.view.endEditing(true)
        
   // }


}
