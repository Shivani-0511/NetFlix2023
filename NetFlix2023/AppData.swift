//
//  AppData.swift
//  NetFlix2023
//
//  Created by Apple on 21/03/23.
//

import Foundation
struct NetFlixApp{
    let sectionType : String
    let movies : [Movie]
}
struct Movie{
    let movieName : String
    let trailerUrl : String
    var imageURLString:String?
    
}

