//
//  ViewController.swift
//  LuckyDraw
//

import UIKit
import SwiftCSV

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
//
//
//        guard let path = Bundle.main.path(forResource: "test", ofType: "csv") else { return }
//
//        do {
////            let csvFile: CSV = try CSV(url: URL(fileURLWithPath: path))
//            let csvFile: CSV! = try CSV(
//                    name: "test2",
//                    extension: "csv",
//                    bundle: .main,
//                    delimiter: ",",
//                    encoding: .utf8)
//
//            print(csvFile.header)
//            print(csvFile.namedRows)
//            print(csvFile.namedColumns)
//
//            // Access each row as an array (array not guaranteed to be equal length to the header)
//            try csvFile.enumerateAsArray { array in
//                print("sss \(array.first)")
//            }
//            // Access them as a dictionary
//            try csvFile.enumerateAsDict { dict in
////                print(dict)
//                print(dict["staffID"])
//                print(dict["Name"])
//            }
//
//        } catch let error {
//            print(error)
//        }
    }


}

