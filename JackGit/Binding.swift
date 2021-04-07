//
//  Binding.swift
//  JackGit
//
//  Created by Ruchi Agrawal on 4/6/21.
//


import Foundation

class Observable<T>{
    var bind: (T) -> () = {_ in}
    
    var value: T {
        didSet {
            bind(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}

