/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
import Foundation

struct Toy: Codable {
  var name: String
}

struct Employee: Encodable {
  var name: String
  var id: Int
  var favoriteToy: Toy
    
    // 1
    enum CodingKeys: CodingKey {
      case name, id, gift
    }

    func encode(to encoder: Encoder) throws {
      // 2
      var container = encoder.container(keyedBy: CodingKeys.self)
      // 3
      try container.encode(name, forKey: .name)
      try container.encode(id, forKey: .id)
      // 4
      try container.encode(favoriteToy.name, forKey: .gift)
    }

}

extension Employee: Decodable {
  init(from decoder: Decoder) throws {
    
    // 1
    let container = try decoder.container(keyedBy: CodingKeys.self)
    // 2
    name = try container.decode(String.self, forKey: .name)
    id = try container.decode(Int.self, forKey: .id)
    // 3
    let gift = try container.decode(String.self, forKey: .gift)
    favoriteToy = Toy(name: gift)
    
    // 1
    enum CodingKeys: CodingKey {
      case name, id, gift
    }
    // 2
    enum GiftKeys: CodingKey {
      case toy
    }
    // 3
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(name, forKey: .name)
      try container.encode(id, forKey: .id)
      // 4
      var giftContainer = container
        .nestedContainer(keyedBy: GiftKeys.self, forKey: .gift)
      try giftContainer.encode(favoriteToy, forKey: .toy)
    }
  }
}

let toy = Toy(name: "Teddy Bear")
let employee = Employee(name: "John Appleseed", id: 7, favoriteToy: toy)

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let data = try encoder.encode(employee)
let string = String(data: data, encoding: .utf8)!

let sameEmployee = try decoder.decode(Employee.self, from: data)


