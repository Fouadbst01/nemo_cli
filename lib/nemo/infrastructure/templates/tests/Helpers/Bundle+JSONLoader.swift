import Foundation

extension Bundle {
    func loadDataFromJSON(filename: String) -> Data? {
        guard let url = self.url(forResource: filename, withExtension: "json") else { return nil }
        return try? Data(contentsOf: url)
    }
}