//
//  ViewController.swift
//  RealmTasks
//
//  Created by Pavel Spitcyn on 19.07.2021.
//

import UIKit
import RealmSwift

// MARK: - TaskList class

//Класс для создания модели
class TaskList: Object {
    @objc dynamic var task = ""
    @objc dynamic var completed = false
    
    @objc dynamic var createdAt = NSDate()
}


// MARK: - ViewController class

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let realm = try! Realm() //Доступ к хранилищу
    var items: Results<TaskList>! //Контейнер со свойствами объекта TaskList
    
    var cellId = "Cell" //Идентификатор ячейки
    

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var segmentedButton: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = realm.objects(TaskList.self) //Обращение к базе данных
    }


    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count != 0 {
            return items.count
        }
        
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.task
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    //Delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = items[indexPath.row]
        
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            try! self.realm.write({
                self.realm.delete(editingRow)
                tableView.reloadData()
            })
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
    }

    // MARK: - Actions

    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        addAlertForNewItem()
    }
    
    @IBAction func segmentedButtonAction(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func sortSegmentControlAction(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {
        case 0:
            items = items.sorted(byKeyPath: "task", ascending: true)
        case 1:
            items = items.sorted(byKeyPath: "createdAt", ascending:false)
        default:
            return
        }

        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Functions
    
    func addAlertForNewItem() {
        //create alert
        let alert = UIAlertController(title: "Новая задача",
                                      message: "Пожалуйста, заполните поле",
                                      preferredStyle: .alert)
        
        //Create text field
        var alertTextField: UITextField!
        alert.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "Новая задача"
        }
        
        
        //Создание кнопки для сохранения новых значений
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            
            //Проверяем, не является ли текстовое поле пустым
            guard let text = alertTextField.text, !text.isEmpty else { return }
            
            let task = TaskList()
            task.task = text
            
            try! self.realm.write({
                self.realm.add(task)
            })
            
            //Обновление таблицы
            self.tableView.insertRows(at: [IndexPath.init(row: self.items.count - 1, section: 0)], with: .automatic)
            
            self.tableView.reloadData()
        }
            
        //Создаем кнопку отмены ввода новой задачи
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alert.addAction(saveAction) //Присваиваем алерту кнопку для сохранения результата
        alert.addAction(cancelAction) //Присваиваем алерту кнопку для ввода новой задачи

        present(alert, animated: true, completion: nil)
    }
    
}



