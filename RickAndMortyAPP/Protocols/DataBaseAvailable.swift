//
//  DataBaseManagerAvailable.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 21.12.2021.
//

import Foundation
import UIKit

protocol DataBaseAvailable {
    var dataBase: DataBase? { get }
}

extension DataBaseAvailable {
    var dataBase: DataBase? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.dataBase
    }
}
