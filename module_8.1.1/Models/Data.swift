import Foundation

struct Datas: Codable {
    let id: Int
    let avatar_url: String
    let name: String
    let bio: String
    let company: String
    let blog: String
    let location: String
    let email: String?
    let followers: Int
    let following: Int
}
