//
//  News.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

struct Article: Codable {
    let articles: [News] //მასივი გვჭირდება
}

struct News: Codable { // არ იყო ქოდეიბლ რაც არტიკლს აერორება
    let author: String?
    let title: String?
    let urlToImage: String?
}
