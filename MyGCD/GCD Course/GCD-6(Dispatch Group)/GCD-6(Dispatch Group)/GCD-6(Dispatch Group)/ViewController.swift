//
//  ViewController.swift
//  GCD-6(Dispatch Group)
//
//  Created by Pavel Spitcyn on 24.06.2021.
//

import UIKit

class ViewController: UIViewController {

    var str = "https://images.wallpaperscraft.ru/image/para_zvezdnoe_nebo_art_123338_3000x3000.jpg"
    
    let imageURLs = ["https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "https://images.all-free-download.com/images/graphiclarge/explosion_fireball_picture_165528.jpg", "https://images.wallpaperscraft.ru/image/planeta_kosmos_fotoshop_129003_3000x3000.jpg", "https://images.wallpaperscraft.ru/image/para_zvezdnoe_nebo_art_123338_3000x3000.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        //1
        let dispatchGroupTest1 = DispatchGroupTest1()
        dispatchGroupTest1.loadInfo()
        */
        
        /*
        //2
        let dispatchGroupTest2 = DispatchGroupTest2()
        dispatchGroupTest2.loadInfo()
        */
        
        //3
        let view1 = EightImage(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
        view1.backgroundColor = UIColor.red
        view.addSubview(view1)
        
        var images = [UIImage]()
        
        func asyncLoadImage(imageURL: URL, runQueue: DispatchQueue, completionQueue: DispatchQueue, completion: @escaping (UIImage?, Error?) -> ()) {
            runQueue.async {
                do {
                    let data = try Data(contentsOf: imageURL)
                    completionQueue.async { completion(UIImage(data: data), nil)}
                } catch let error {
                    completionQueue.async { completion(nil, error) }
                }
            }
        }
        
        func asyncGroup() {
            let aGroup = DispatchGroup()
            
            for i in 0...3 {
                aGroup.enter()
                asyncLoadImage(imageURL: URL(string: imageURLs[i])!,
                               runQueue: .global(),
                               completionQueue: .main) { result, error in
                    guard let image1 = result else { return }
                    images.append(image1)
                    aGroup.leave()
                }
            }
            
            aGroup.notify(queue: .main) {
                for i in 0...3 {
                    view1.ivs[i].image = images[i]
                }
            }
        }
        
        
        func asyncUrlSession() {
            for i in 4...7 {
                let url = URL(string: imageURLs[i - 4])
                let request = URLRequest(url: url!)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        view1.ivs[i].image = UIImage(data: data!)
                    }
                }
                task.resume()
            }
        }
        
        asyncUrlSession()
        asyncGroup()
    }
}

/*
//1
class DispatchGroupTest1 {
    private let queueSerial = DispatchQueue(label: "The Swift Developer")
    
    private let groupRed = DispatchGroup()
    
    func loadInfo() {
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("1")
        }
        
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("2")
        }
        
        groupRed.notify(queue: .main) {
            print("groupRed finish all")
        }
    }
}
*/

/*
//2
class DispatchGroupTest2 {
    private let queueConc = DispatchQueue(label: "The Swift Developer", attributes: .concurrent)
    
    private let groupBlack = DispatchGroup()
    
    func loadInfo() {
        groupBlack.enter()
        queueConc.async {
            sleep(1)
            print("1")
            self.groupBlack.leave()
        }
        
        groupBlack.enter()
        queueConc.async {
            sleep(2)
            print("2")
            self.groupBlack.leave()
        }
        
        groupBlack.wait()
        
        print("Finish all")
        
        groupBlack.notify(queue: .main) {
            print("groupBlack finish all")
        }
    }
}
*/

//3
class EightImage: UIView {
    public var ivs = [UIImageView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        for i in 0...7 {
            ivs[i].contentMode = .scaleAspectFit
            self.addSubview(ivs[i])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


