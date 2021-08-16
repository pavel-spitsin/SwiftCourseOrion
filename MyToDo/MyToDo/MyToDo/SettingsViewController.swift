//
//  SettingsViewController.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 16.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    var task = Task()
    var numberOfRows: Int = 1
    let notificationManager = NotificationManager()
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func doneBarButtonAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationManager.removeNotifications(withIdentifiers: [task.notificationIdentifier])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        notificationManager.notificationAuthorization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        switch task.notificationTime {
        case nil:
            return
        default:
            notificationManager.createNotification(identifier: task.notificationIdentifier, title: "Напоминание", message: task.task, date: task.notificationTime!)
        }
    }
}

    
    //MARK: - UITableViewDataSource
    
extension SettingsViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if task.notificationTime != nil {
            numberOfRows = 2
        }
        
        return numberOfRows
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnedCell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
            cell.switchDelegate = self
            
            if task.notificationTime != nil {
                cell.timeSwitch.isOn = true
            }
            
            returnedCell = cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableViewCell", for: indexPath) as! TimeTableViewCell
            cell.timeDelegate = self
            
            if task.notificationTime != nil {
                cell.timePicker.date = task.notificationTime!
            }
            
            returnedCell = cell
        }
        return returnedCell
    }
}


//MARK: - SwitchSelectionDelegate

extension SettingsViewController: SwitchSelectionDelegate {

    func switchSelectedPosition(position: Bool) {
        tableView.beginUpdates()
        switch position {
        case true:
            numberOfRows = 2
            tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            task.notificationTime = nil
        default:
            numberOfRows = 1
            tableView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }
        tableView.endUpdates()
    }
}


//MARK: - TimeTableViewCellDelegate

extension SettingsViewController: TimeTableViewCellDelegate {
    
    func setTimeForNotification(time: Date) {
        task.notificationTime = time
    }
}
