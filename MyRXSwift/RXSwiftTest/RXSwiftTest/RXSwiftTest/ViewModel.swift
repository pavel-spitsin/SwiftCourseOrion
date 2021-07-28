//
//  ViewModel.swift
//  RXSwiftTest
//
//  Created by Pavel Spitcyn on 23.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {

    private struct Constants {
        static let URLPrefix = "https://api.openweathermap.org/data/2.5/weather?q="
        static let URLPostfix = "6ff8efe4468789d6356e9c9418279457"
    }
 
    let disposeBag = DisposeBag()
 
    var searchText = PublishSubject<String?>()
    
    var cityName = PublishSubject<String>()
    var degrees = PublishSubject<String>()
    
    
    var weather:Weather? {
        
        didSet {
            
            if let name = weather?.name {
                DispatchQueue.main.async {
                    self.cityName.onNext(name)
                }
            }
            
            if let temp = weather?.degrees {
                DispatchQueue.main.async {
                    self.degrees.onNext("\(temp)°C")
                }
            }
        }
    }
    
    
    init() {

        let jsonRequest = searchText
            .map { text in
                return URLSession.shared.rx.json(url: URL.init(string: Constants.URLPrefix + text! + "&units=metric" + "&appid=" + Constants.URLPostfix)!)
        }
        .switchLatest()

        jsonRequest.subscribe { json in
            self.weather = Weather(json: json)
        }
        .disposed(by: disposeBag)
    }
}

