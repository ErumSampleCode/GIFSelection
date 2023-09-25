//
//  TrendingModel.swift
//  GIFSelection
//
//  Created by Erum Naz on 22/09/23.
//

import Foundation


struct TrendingModel: Codable{
    
    let data : [TRENDING]?
}

struct TRENDING: Codable {
    let type: String?
    let id: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case url = "url"
    }
}


struct GifArray: Decodable {
    var gifs: [Gif]
    enum CodingKeys: String, CodingKey {
        case gifs = "data"
    }
}
/// Contains giph properties
struct Gif: Decodable {
    var gifSources: GifImages
    enum CodingKeys: String, CodingKey {
        case gifSources = "images"
    }
    /// Returns download url of the originial gif
    func getGifURL() -> String{
        return gifSources.original.url
    }
}
/// Stores the original Gif
struct GifImages: Decodable {
    var original: original
    enum CodingKeys: String, CodingKey {
        case original = "original"
    }
}
/// URL to data of Gif
struct original: Decodable {
    var url: String
}
