//
//  JackProject.swift
//  JackGit
//
//  Created by Ruchi Agrawal on 4/6/21.
//

import Foundation

struct JackProject: Decodable,Identifiable{
    var id :Int? = 0
    var name:String? = "Unknown"
    var description: String? = "Not available"
    var language: String? = "Not available"
    var open_issues: Int? = 0
    var watchers: Int? = 0
}
