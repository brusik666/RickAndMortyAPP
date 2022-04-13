//
//  NetworkManagerAvailable.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 21.12.2021.
//

import Foundation
import UIKit

protocol NetworkManagerAvailable {
    var networkManager: ApiRequestsController? { get }
}

extension NetworkManagerAvailable {
    var networkManager: ApiRequestsController? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.networkManager
    }
}

