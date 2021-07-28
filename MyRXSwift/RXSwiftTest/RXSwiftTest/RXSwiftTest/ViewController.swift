//
//  ViewController.swift
//  RXSwiftTest
//
//  Created by Pavel Spitcyn on 23.07.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Binding the UI
        viewModel.cityName.bind(to: cityNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.degrees.bind(to: degreesLabel.rx.text).disposed(by: disposeBag)

        /*
        nameTextField.rx.text.subscribe { text in
            self.viewModel.searchText.onNext(text)
        }
        .disposed(by: disposeBag)*/
        
        
        /*
        nameTextField.rx.controlEvent([.editingChanged])
                .asObservable().subscribe({ [unowned self] _ in
                    print("My text : \(self.nameTextField.text ?? "")")
                }).disposed(by: disposeBag)
*/
        
        nameTextField.rx.controlEvent([.editingChanged])
            .asObservable().subscribe({ _ in
                self.viewModel.searchText.onNext(self.nameTextField.text)
                }).disposed(by: disposeBag)

            
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
    
}


