//
//  Cancellable.swift
//  RickAndMortyAPP
//
//  Created by Brusik on 27.01.2022.
//

import Foundation

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {
    
}
