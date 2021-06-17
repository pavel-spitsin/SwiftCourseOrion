//
//  ViewController.swift
//  MyTableView
//
//  Created by Pavel Spitcyn on 04.06.2021.
//

import UIKit
import AVFoundation

var array: [String] = ["Позвонить маме", "Купить хлеба", "Написать приложение", "Отметить с друзьями"]

var tapCounter: Int = 0
var buttonEditTapCounter: Int = 0

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBAction func editCells(_ sender: UIBarButtonItem) {
        
        buttonEditTapCounter += 1
        
        switch buttonEditTapCounter {
        case 1:
            editButton.title = "Cancel"; tableView.setEditing(true, animated: true)
        default:
            buttonEditTapCounter = 0; editButton.title = "Edit"; tableView.setEditing(false, animated: true)
        }
        
        /*
        let systemSoundID: SystemSoundID = 1002
        AudioServicesPlaySystemSound(systemSoundID)
*/
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let string = array[sourceIndexPath.row]
        
        array.remove(at: sourceIndexPath.row)
        array.insert(string, at: destinationIndexPath.row)

        print(array)
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            array.remove(at: indexPath.row)
            let a = [indexPath]
            tableView.deleteRows(at: a, with: .automatic)
        default:
            break
        }
        
    }
    
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch tapCounter {
        case 0:
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .red
            tableView.cellForRow(at: indexPath)?.isSelected = false
            tapCounter += 1
        default:
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .black
            tableView.cellForRow(at: indexPath)?.isSelected = false
            tapCounter = 0
        }
        
    }

    

    
    
    
}

