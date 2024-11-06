//
//  Character.swift
//  RickAndMortyRealm
//
//  Created by Ибрагим Габибли on 03.11.2024.
//

import Foundation

struct PostCharacters: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: Location
    let image: String
}

struct Location: Decodable {
    let name: String
}
