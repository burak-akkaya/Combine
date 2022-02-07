import Combine
import Foundation

var subscriptions = Set<AnyCancellable>()

execute(of: "Assign") {

    let object = SampleObject()
    ["Combine", "SwiftUI"].publisher
        .assign(to: \.value, on: object)
        .store(in: &subscriptions)

}
