//
//  SongModels.swift
//  testAppSwift
//
//  Created by Salman Afzal on 07/08/2024.
//

import Foundation

struct MusicResponse: Codable {
    let results: [Song]
}

struct Song: Codable {
    let trackName: String
    let artistName: String
    let previewUrl: String
}
