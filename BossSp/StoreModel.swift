
import Foundation

class StoreModel: ObservableObject {
    static let shared = StoreModel()
    
    @Published var stores : [
        (
            strName: String,        // 음식점 이름
            strAddress: String,     // 음식점 주소
            strDescript: String,    // 음식점 설명
            strType: String         // 음식점 종류 (한식, 일식, ...)
        )
    ] = []
    
    private init() { }
}
