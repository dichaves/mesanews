//
//  News.swift
//  Mesa News
//
//  Created by Diana Monteiro on 15/11/20.
//

import Foundation

struct AllNews: Codable {
    let pagination: Pagination
    let data: [SingleNews]
}

struct Pagination: Codable {
    let current_page: Int
    let per_page: Int
    let total_pages: Int
    let total_items: Int
}

struct SingleNews: Codable {
    let title: String
    let description: String
    let content: String
    let author: String
    let published_at: String // formato de data?
    let highlight: Bool
    let url: String
    let image_url: String
}
