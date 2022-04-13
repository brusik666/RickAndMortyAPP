//
//  DataBaseManagerAvailable.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 21.12.2021.
//

import Foundation
import UIKit

protocol DataBaseAvailable {
    var dataBase: DataBase { get }
}

extension DataBaseAvailable {
    var dataBase: DataBase {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.dataBase
    }
}
