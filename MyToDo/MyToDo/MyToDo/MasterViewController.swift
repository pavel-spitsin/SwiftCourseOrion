//
//  MasterViewController.swift
//  MyToDo
//
//  Created by Павел on 10.08.2021.
//

import UIKit

protocol TaskListSelectionDelegate: AnyObject {
    func taskListSelected(_ newTaskList: TaskList)
}

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: TaskListSelectionDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    @IBAction func addBarButtonAction(_ sender: UIBarButtonItem) {
        createAlertController()
    }
    
    
    //MARK: - UIViewControllerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskManager.shared().taskListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath)
        cell.textLabel?.text = TaskManager.shared().taskListArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            TaskManager.shared().taskListArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        

        guard let detailViewController = (splitViewController?.viewControllers.last as? UINavigationController)?.topViewController as? DetailViewController else { return }
        
        if TaskManager.shared().taskListArray.last != nil {
            loadDetailViewControllerForTaskList(taskList: TaskManager.shared().taskListArray.last!)
        } else {
            detailViewController.tableView.reloadData()
        }
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadDetailViewControllerForTaskList(taskList: TaskManager.shared().taskListArray[indexPath.row])
    }
    
    
    // MARK: - Functions
    
    func createAlertController() {
        let alert = UIAlertController(title: "New tasklist", message: "Enter tasklist name", preferredStyle: .alert)
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
            let newTaskList = TaskList()
            TaskManager.shared().taskListArray.append(newTaskList)
            
            switch alert.textFields?[0].text {
            case "":
                newTaskList.name = "New TaskList" + String(TaskManager.shared().taskListArray.count)
            default:
                newTaskList.name = (alert.textFields?[0].text)!
            }
            self.tableView.reloadData()
            self.loadDetailViewControllerForTaskList(taskList: newTaskList)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadDetailViewControllerForTaskList(taskList: TaskList) {
        delegate?.taskListSelected(taskList)

        if let detailViewController = delegate as? DetailViewController,
           let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
            
            DispatchQueue.main.async {
                detailViewController.addTaskButton.isHidden = false
            }
        }
    }
    
}
