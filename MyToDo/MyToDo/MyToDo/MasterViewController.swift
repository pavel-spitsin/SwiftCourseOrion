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

class MasterViewController: UIViewController {
    
    var startIndexPath = IndexPath()
    var endIndexPath: IndexPath? = nil

    weak var delegate: TaskListSelectionDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    @IBAction func addBarButtonAction(_ sender: UIBarButtonItem) {
        createAlertController()
    }
    
    
    //MARK: - UIViewControllerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
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
    
    func clearIndicator() {
        for cell in tableView.visibleCells {
            if let masterCell = cell as? MasterCell {
                masterCell.removeIndicator()
            }
        }
    }
}


//MARK: - UITableViewDataSource

extension MasterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskManager.shared().taskListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath) as! MasterCell
        cell.nameLabel.text = TaskManager.shared().taskListArray[indexPath.row].name

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
        
        if tableView.visibleCells.count == 0 {
            detailViewController.addTaskButton.isHidden = true
        }
    }
}


// MARK: - UITableViewDelegate

extension MasterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadDetailViewControllerForTaskList(taskList: TaskManager.shared().taskListArray[indexPath.row])
    }
}


// MARK: - UITableViewDragDelegate

extension MasterViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        startIndexPath = indexPath
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}


// MARK: - UITableViewDropDelegate

extension MasterViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        endIndexPath = destinationIndexPath
        
        if (destinationIndexPath != nil) {

            clearIndicator()

            let destinationCell = tableView.cellForRow(at: IndexPath(row: (destinationIndexPath?.row)!, section: 0)) as! MasterCell
            
            if startIndexPath.row > endIndexPath!.row {
                destinationCell.addUpperIndicator()
            } else {
                destinationCell.addLowerIndicator()
            }
        }
        
        if session.localDragSession != nil { // Drag originated from the same app.
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            
        }
            return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let element = TaskManager.shared().taskListArray[startIndexPath.row]
        TaskManager.shared().taskListArray.remove(at: startIndexPath.row)
        
        switch endIndexPath {
        case nil:
            TaskManager.shared().taskListArray.insert(element, at: TaskManager.shared().taskListArray.count)
        default:
            TaskManager.shared().taskListArray.insert(element, at: endIndexPath!.row)
        }
        
        clearIndicator()
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidExit session: UIDropSession) {
        clearIndicator()
    }
}
