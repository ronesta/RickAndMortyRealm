//
//  StorageManager.swift
//  RickAndMortyRealm
//
//  Created by Ибрагим Габибли on 03.11.2024.
//

import Foundation
import UIKit
import RealmSwift

class StorageManager: NSObject {
    static let shared = StorageManager()

    private override init() {
        super.init()
    }

    private var realm: Realm {
        return try! Realm()
    }

    public func createOrUpdateCharacter(id: Int64,
                                        gender: String,
                                        image: String,
                                        location: String,
                                        name: String,
                                        species: String,
                                        status: String,
                                        imageData: Data?) {
        let character = RealmCharacter()
        character.id = id
        character.gender = gender
        character.image = image
        character.location = location
        character.name = name
        character.species = species
        character.status = status
        character.imageData = imageData

        do {
            try realm.write {
                realm.add(character, update: .modified)
            }
        } catch {
            print("Error saving character: \(error)")
        }
    }

    func saveCharacters(_ characters: [(character: Character, imageData: Data?)]) {
        do {
            try realm.write {
                for (character, imageData) in characters {
                    let realmCharacter = RealmCharacter()
                    realmCharacter.id = Int64(character.id)
                    realmCharacter.gender = character.gender
                    realmCharacter.image = character.image
                    realmCharacter.location = character.location.name
                    realmCharacter.name = character.name
                    realmCharacter.species = character.species
                    realmCharacter.status = character.status
                    realmCharacter.imageData = imageData

                    realm.add(realmCharacter, update: .modified)
                }
            }
        } catch {
            print("Error saving characters: \(error)")
        }
    }

    public func fetchCharacters() -> [RealmCharacter] {
        return Array(realm.objects(RealmCharacter.self))
    }

    func fetchImageData(forCharacterId id: Int64) -> Data? {
        if let realmCharacter = realm.object(ofType: RealmCharacter.self, forPrimaryKey: id) {
            return realmCharacter.imageData
        }
        return nil
    }
}
