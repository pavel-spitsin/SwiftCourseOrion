//
//  DetailViewController.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailCellDelegate, TaskListSelectionDelegate {

    var taskList: TaskList? {
        didSet {
            //refreshUI()
            reloadInputViews()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTaskButton: UIButton!
    
    @IBAction func addTaskAction(_ sender: UIButton) {
        
        let newTask = Task()
        taskList?.taskArray.append(newTask)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: (taskList?.taskArray.count)! - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        tableView.scrollToRow(at: IndexPath(row: (taskList?.taskArray.count)! - 1, section: 0), at: .bottom, animated: true)
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
        return taskList?.taskArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.textView.text = String((taskList?.taskArray[indexPath.row].task)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            taskList?.taskArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    //MARK: - DetailCellDelegate
    
    func textChanged() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func deleteRow(at rowIndex: Int) {
        taskList?.taskArray.remove(at: rowIndex)
        tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
    }
    
    
    //MARK: - TaskListSelectionDelegate
    func taskListSelected(_ newTaskList: TaskList) {
        taskList = newTaskList
    }
}
