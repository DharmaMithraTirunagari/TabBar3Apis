//
//  PersonModel.swift
//  TabBar3Apis
//
//  Created by Srikanth Kyatham on 12/11/24.
//

struct PersonModel: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    let address: Address?
    let company: Company?
    
}

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

struct Geo: Codable {
    let lat: String?
    let lng: String?
}
