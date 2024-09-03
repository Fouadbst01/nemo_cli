struct LaunchResponse: Decodable {
    let fairings: String?
    let net: Bool
    let rocket: String
    let success: Bool
    let details: String?
    let crew: [Crew]?
    let launchpad: String?
    let flightNumber: Int?
    let name: String?
    let dateUTC: String?
    let dateUnix: Int?
    let dateLocal: String?
    let datePrecision: String?
    let upcoming: Bool?
    let autoUpdate: Bool?
    let tbd: Bool?
    let launchLibraryID: String?
    let id: String?

    enum CodingKeys: String ,CodingKey {
        case fairings
        case net
        case rocket
        case success
        case details
        case crew
        case launchpad
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case upcoming
        case autoUpdate = "auto_update"
        case tbd
        case launchLibraryID = "launch_library_id"
        case id
    }
}

struct Crew: Decodable {
    let crew: String?
    let role: String?
}