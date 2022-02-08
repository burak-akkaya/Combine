import Combine
import Foundation

var subscriptions = Set<AnyCancellable>()

sample(of: "Filter") {
    let values = ["Swift-UI", "ObjectiveC-UI", "Swift-Core", "ObjectiveC-Core","Swift-Alamofire", "ObjectiveC-Alamofire"]

    let publisher = values.publisher

    publisher.filter { value in
        return value.hasPrefix("Swift")
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}

sample(of: "Filter on DataProducer") {
    let dataProducer = DataProducer(data:  [
        "Data1",
        "Data2",
        "Data3",
        "NotData1",
        "Data4",
        "Data5",
        "Data6",
        "Data7",
        "NotData2",
    ])

    let publisher = dataProducer.subject.eraseToAnyPublisher()

    publisher.filter { value in
        return value.hasPrefix("Data")
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}
