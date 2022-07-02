//
//  MostPopularNews.swift
//  CitrixTask
//
//  Created by Sai Sandeep on 02/07/22.
//

import UIKit

struct MostPopularNews: Codable {
    let status, copyright: String
    let numResults: Int
    let results: [Results]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

struct Results: Codable {
    let uri, url, title, abstract, publishedDate, byline: String
    let media: [Media]

    enum CodingKeys: String, CodingKey {
        case publishedDate = "published_date"
        case byline, title, abstract, media, uri, url
    }
}

struct Media: Codable {
    let type: MediaType
    let mediaMetadata: [MediaMetadatum]

    enum CodingKeys: String, CodingKey {
        case type
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadatum: Codable {
    let url: String
    let format: Format
    let height, width: Int
}

enum Format: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

enum MediaType: String, Codable {
    case image = "image"
}
