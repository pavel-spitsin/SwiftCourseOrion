//
//  ViewController.swift
//  SwiftFileManager
//
//  Created by Pavel Spitcyn on 02.07.2021.
//

import UIKit

class ViewController: UIViewController {

    let fileManager = FileManager()
    let tempDir = NSTemporaryDirectory()
    let fileName = "file.txt"
    
    func checkDirectory() -> String? {
        do {
            let filesInDirectry = try fileManager.contentsOfDirectory(atPath: tempDir)
            
            let files = filesInDirectry
            if files.count > 0 {
                if files.first == fileName {
                    print("file.txt found")
                    return files.first
                } else {
                    print("File not found")
                    return nil
                }
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    

    @IBAction func createFileBtnPressed(_ sender: UIButton) {
        
        let path = (tempDir as NSString).appendingPathComponent(fileName)
        let contentsOfFile = "Some Text Here"
        
        // Записываем в файл
        do {
            try contentsOfFile.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            print("File text.txt created at temp directory")
        } catch let error as NSError {
            print("could't create file text.txt because of error: \(error)")
        }
    }
    
    @IBAction func readFileBtnPressed(_ sender: UIButton) {
        
        // Читаем
        let directoryWithFiles = checkDirectory() ?? "Empty"
                
        let path = (tempDir as NSString).appendingPathComponent(directoryWithFiles)

        do {
            let contentsOfFile = try NSString(contentsOfFile: path, encoding:String.Encoding.utf8.rawValue)
            print("content of the file is: \(contentsOfFile)")
        } catch let error as NSError {
            print("there is an file reading error: \(error)")
        }
    }
    
    @IBAction func deleteFileBtnPressed(_ sender: UIButton) {

        let directoryWithFiles = checkDirectory() ?? "Empty"
        do {
            let path = (tempDir as NSString).appendingPathComponent(directoryWithFiles)
            try fileManager.removeItem(atPath: path)
            print("file deleted")
        } catch let error as NSError {
            print("error occured while deleting file: \(error.localizedDescription)")
        }
    }
    
    @IBAction func viewDirectoryBtnPressed(_ sender: UIButton) {
        // Смотрим содержимое папки
        let directoryWithFiles = checkDirectory() ?? "Empty"
        print("Contents of Directory =  \(directoryWithFiles)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    
    
}

