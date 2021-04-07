//
//  Model.swift
//  JackGit
//
//  Created by Ruchi Agrawal on 4/6/21.
//

import Foundation

struct Model<T> {
    private var objects = [T]()
    
    mutating func insert(_ element: T) {
        objects.insert(element, at: objects.count)
    }

    mutating func remove(at index: Int) {
        guard objects.indices.contains(index) else {
            return
        }
        objects.remove(at: index)
    }

    var count: Int {
        return objects.count
    }
    
    subscript(index: Int) -> T? {
        return objects.indices.contains(index) ? objects[index] : nil
    }
}
