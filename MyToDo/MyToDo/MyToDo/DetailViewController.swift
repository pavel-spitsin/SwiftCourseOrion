//
//  DetailViewController.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import UIKit

extension Notification.Name {
    static let ScrollToLastCell = NSNotification.Name("ScrollToLastCell")
}

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailCellDelegate, TaskListSelectionDelegate, UIScrollViewDelegate, UISearchBarDelegate {

    var taskList: TaskList? {
        didSet {
            reloadInputViews()
        }
    }

    var filteredTasks = [Task]()

    let ghostTextView = UITextView()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    @IBAction func addTaskAction(_ sender: UIButton) {
        let newTask = Task()
        taskList?.taskArray.append(newTask)
        
        if searchBar.text == "" {
            filteredTasks = taskList!.taskArray
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: (taskList?.taskArray.count)! - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        ghostTextView.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(ghostTextView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        addTaskButton.layer.cornerRadius = addTaskButton.bounds.height / 2
        addTaskButton.layer.shadowColor = UIColor.black.cgColor
        addTaskButton.layer.shadowOpacity = 0.8
        addTaskButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addTaskButton.layer.shadowRadius = 10
        addTaskButton.isHidden = true
    }

    
    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberForFeturn = Int()
        
        switch TaskManager.shared().taskListArray.count {
        case 0:
            numberForFeturn = 0
        default:
            numberForFeturn = filteredTasks.count
        }
        
        return numberForFeturn
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        cell.delegate = self
        
        cell.textView.text = filteredTasks[indexPath.row].task
        
        cell.indexPath = indexPath
        
        switch taskList?.taskArray[indexPath.row].isCompleted {
        case true:
            cell.isCheckmarkActive(active: true)
        default:
            cell.isCheckmarkActive(active: false)
        }
        
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
    
    
    //MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: Notification.Name.ScrollToLastCell, object: nil)
    }
    

    //MARK: - UISearchBarDelegate
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredTasks = []
        
        if searchText == "" {
            for task in taskList!.taskArray {
                filteredTasks.append(task)
            }
        }
        
        for task in taskList!.taskArray {
            if task.task.uppercased().contains(searchText.uppercased()) {
                filteredTasks.append(task)
            }
        }
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    
    //MARK: - DetailCellDelegate

    func textChangedInCell(cell: DetailCell) {
        tableView.beginUpdates()
        taskList?.taskArray[cell.indexPath.row].task = cell.textView.text
        tableView.endUpdates()
    }
    
    func deleteRow(at rowIndex: Int) {
        taskList?.taskArray.remove(at: rowIndex)
        tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
    }
    
    
    //MARK: - TaskListSelectionDelegate
    
    func taskListSelected(_ newTaskList: TaskList) {
        taskList = newTaskList
        navigationItem.title = taskList?.name
        
        guard tableView != nil else {return}
        tableView.reloadData()
    }
    
    
    //MARK: - Functions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: duration as! TimeInterval) {
                    self.tableViewBottomConstraint.constant = keyboardSize.size.height
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]

        DispatchQueue.main.async {
            UIView.animate(withDuration: duration as! TimeInterval) {
                self.tableViewBottomConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    func keyboardDidShow(notification: NSNotification) {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        
        let lastVisibleCell = self.tableView.visibleCells.last as! DetailCell
        let lastRow: Int = (self.taskList?.taskArray.count)! - 1

        if lastVisibleCell.indexPath.row < lastRow {
            NotificationCenter.default.addObserver(self, selector: #selector(focusOnLastCellTextView), name: .ScrollToLastCell, object: nil)
            
            self.tableView.scrollToRow(at: IndexPath(row: lastRow, section: 0), at: .bottom, animated: true)
            
        } else {
            focusOnLastCellTextView()
        }
    }
    
    @objc
    func focusOnLastCellTextView() {
        let lastCell = tableView.cellForRow(at: IndexPath(row: (taskList?.taskArray.count)! - 1, section: 0)) as! DetailCell
        lastCell.textView.becomeFirstResponder()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ScrollToLastCell, object: nil)
    }
    
}
