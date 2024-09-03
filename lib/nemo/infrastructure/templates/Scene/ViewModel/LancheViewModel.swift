
struct LaunchViewModel {
    let name: String
    let dateLocal: String

    init(response: LaunchResponse) {
        name = response.name ?? ""
        dateLocal = response.dateLocal ?? ""
    }
}