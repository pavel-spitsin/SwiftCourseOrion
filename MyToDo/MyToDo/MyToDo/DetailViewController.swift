//
//  DetailViewController.swift
//  MyToDo
//
//  Created by Pavel Spitcyn on 09.08.2021.
//

import UIKit
import Speech

class DetailViewController: UIViewController {

    var timer: Timer? = nil
    
    
    var taskList: TaskList? {
        didSet {
            reloadInputViews()
        }
    }

    var filteredTasksArray: [Task]? = nil
    let ghostTextView = UITextView()
    
    //Speech properties
    let audioEngine = AVAudioEngine()
    let speechReconizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    //For localization
    //let speechReconizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier: "ru-RU"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task: SFSpeechRecognitionTask?
    var isStart: Bool = false
    
    //MicAnimation
    var micImageView: UIImageView? = nil
    var waveView: UIView? = nil
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    
    @IBAction func microphoneButtonAction(_ sender: UIButton) {
        
        isStart = !isStart
        
        if isStart {
            startSpeechRecognization()
        } else {
            cancelSpeechRecognization()
        }
    }
    
    @IBAction func addTaskAction(_ sender: UIButton) {
        
        searchBar.text = ""
        searchBarTextChanged(text: "")

        let newTask = Task()
        taskList?.taskArray.append(newTask)
        
        if searchBar.text == "" {
            filteredTasksArray = taskList!.taskArray
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: (taskList?.taskArray.count)! - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        ghostTextView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkSpeechPermission()
        
        searchBar.searchBarStyle = .minimal
        
        sortSegmentControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        
        filteredTasksArray = taskList?.taskArray
        
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


    //MARK: - Functions
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
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

    @objc
    func keyboardWillHide(notification: NSNotification) {
        
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
    
    @objc
    func indexChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            selectCompletedTasks()
        default:
            filteredTasksArray = taskList?.taskArray
        }
        tableView.reloadData()
    }
    
    func selectCompletedTasks() {
        filteredTasksArray = []
        
        guard taskList?.taskArray != nil else { return }
        
        for task in taskList!.taskArray {
            if task .isCompleted {
                filteredTasksArray?.append(task)
            }
        }
    }
    
    func fillFilteredTaskArray(by searchText: String) {
        filteredTasksArray = []
        
        if searchText == "" {
            filteredTasksArray = taskList?.taskArray
        }
        
        for task in taskList!.taskArray {
            if task.task.uppercased().contains(searchText.uppercased()) {
                filteredTasksArray?.append(task)
            }
        }
    }
    
    func checkSpeechPermission() {
        microphoneButton.isEnabled = false
        SFSpeechRecognizer.requestAuthorization { (authState) in
            OperationQueue.main.addOperation {
                switch authState {
                case .authorized:
                    self.microphoneButton.isEnabled = true
                default:
                    self.showAlertView(message: "Not authorized")
                }
            }
        }
    }

    func startSpeechRecognization() {
        
        searchBar.text = ""
        
        startMicLogoAnimation()
        microphoneButton.tintColor = .systemRed
        
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
            
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
            
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            showAlertView(message: "Error comes here for starting the audio listner =\(error.localizedDescription)")
        }
        
        guard let myRecognization = SFSpeechRecognizer() else {
            self.showAlertView(message: "Recognization is not allow on your local")
            return
        }
            
        if !myRecognization.isAvailable {
            self.showAlertView(message: "Recognization is free right now, Please try again after some time.")
        }
            
        task = speechReconizer?.recognitionTask(with: request, resultHandler: { (response, error) in
            
            var isFinal = false
            if let result = response {
                
                let message = result.bestTranscription.formattedString
                self.searchBar.text = message
                
                isFinal = result.isFinal
            }
            if isFinal {
                self.cancelSpeechRecognization()
            }
            else if error == nil {
                self.restartSpeechTimer()
            }
        })
    }
    
    func cancelSpeechRecognization() {
        
        isStart = false
        
        stopMicLogoAnimation()
        searchBar.resignFirstResponder()
        searchBarTextChanged(text: searchBar.text!)
        microphoneButton.tintColor = .systemBlue
        
        request.endAudio()
        task?.finish()
        audioEngine.stop()

        if audioEngine.inputNode.numberOfInputs > 0 {
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        task?.cancel()
    }
    
    func showAlertView(message: String) {
        let alertController = UIAlertController.init(title: "Error ocured...", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func restartSpeechTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
            self.cancelSpeechRecognization()
        })
    }
    
    
    func startMicLogoAnimation() {
        
        waveView = UIView()
        waveView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        waveView?.center = view.center
        waveView?.backgroundColor = UIColor.systemBlue
        waveView?.layer.cornerRadius = (waveView?.bounds.height)! / 2
        view.addSubview(waveView!)
        
        let micSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 0.5, weight: .thin, scale: .small)
        let micImage = UIImage(systemName: "mic.fill", withConfiguration: micSymbolConfiguration)
        micImageView = UIImageView()
        micImageView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        micImageView?.center = view.center
        micImageView?.backgroundColor = UIColor.systemBlue
        micImageView?.layer.cornerRadius = 50
        micImageView?.image = micImage
        micImageView?.tintColor = UIColor.white
        micImageView?.backgroundColor = UIColor.systemBlue
        view.addSubview(micImageView!)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.repeat],
                       animations: {
                        self.waveView?.transform = CGAffineTransform(scaleX: 3, y: 3)
                        self.waveView?.alpha = 0
                       },
                       completion: nil)
    }
    
    func stopMicLogoAnimation() {
        waveView?.removeFromSuperview()
        micImageView?.removeFromSuperview()
    }
}


//MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberForFeturn = Int()
        
        switch TaskManager.shared().taskListArray.count {
        case 0:
            numberForFeturn = 0
        default:
            numberForFeturn = filteredTasksArray?.count ?? 0
        }
        
        return numberForFeturn
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        cell.delegate = self
        cell.textView.text = filteredTasksArray![indexPath.row].task
        cell.indexPath = indexPath
        
        switch filteredTasksArray![indexPath.row].isCompleted {
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
            filteredTasksArray?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}


//MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


//MARK: - DetailCellDelegate

extension DetailViewController: DetailCellDelegate {
    
    func textChangedInCell(cell: DetailCell) {
        tableView.beginUpdates()
        taskList?.taskArray[cell.indexPath.row].task = cell.textView.text
        tableView.endUpdates()
        
    }
    
    func deleteRow(at rowIndex: Int) {
        taskList?.taskArray.remove(at: rowIndex)
        filteredTasksArray?.remove(at: rowIndex)
        
        tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
    }
    
    func showSettingsViewController(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func returnTaskList() -> TaskList {
        return taskList!
    }
}


//MARK: - TaskListSelectionDelegate

extension DetailViewController: TaskListSelectionDelegate {
    
    func taskListSelected(_ newTaskList: TaskList) {
        taskList = newTaskList
        navigationItem.title = taskList?.name
        
        fillFilteredTaskArray(by: "")
        
        guard tableView != nil else { return }
        tableView.reloadData()
    }
}


//MARK: - UIScrollViewDelegate

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: Notification.Name.ScrollToLastCell, object: nil)
    }
}


//MARK: - UISearchBarDelegate

extension DetailViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarTextChanged(text: searchText)
    }
    
    func searchBarTextChanged(text: String) {
        fillFilteredTaskArray(by: text)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        filteredTasksArray = taskList?.taskArray
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}


//MARK: - Notification extensions

extension Notification.Name {
    static let ScrollToLastCell = NSNotification.Name("ScrollToLastCell")
}
