//
//  CDInsertViewController.swift
//  
//
//  Created by SWUCOMPUTER on 14/06/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class CDInsertViewController: UIViewController,UITextFieldDelegate {
     @IBOutlet var textName: UITextField!
     @IBOutlet var textImportant: UITextField!
     @IBOutlet var textTitle: UITextField!
     @IBOutlet var SWUImageView: UIImageView!
    
    let SWUImage = UIImage(named: "F696E2CC-7EA4-421F-BAD7-53B8868D58D5.jpeg")
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func savePressed(_sender: UIBarButtonItem){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Memo", in: context)
        // friend record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(textName.text, forKey: "name")
        object.setValue(textImportant.text, forKey: "important")
        object.setValue(textTitle.text, forKey: "title")
        object.setValue(Date(), forKey: "date")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }

    

}
