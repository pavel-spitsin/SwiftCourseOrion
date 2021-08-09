//
//  MasterViewController.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MasterCellDelegate {

    var numderOfRows: Int = 10
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTaskButton: UIButton!
    
    @IBAction func addTaskAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskButton.layer.cornerRadius = addTaskButton.bounds.height / 2
        addTaskButton.layer.shadowColor = UIColor.black.cgColor
        addTaskButton.layer.shadowOpacity = 0.8
        addTaskButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addTaskButton.layer.shadowRadius = 10
    }
    
    
    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numderOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath) as! MasterCell
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            numderOfRows -= 1
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    

    //MARK: - MasterCellDelegate
    
    func textChanged() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func deleteEmptyRow(at indexPath: IndexPath) {
        numderOfRows -= 1
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
    //MARK: - Actions
    
    
}
