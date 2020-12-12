import Combine

struct Hoge {
    
    let value: Int
    
}

struct HogeError: Error {
    
    static func message(_ hoge: Hoge) -> String {
        "An Error Occured: value = \(hoge.value)"
    }
    
}

extension Hoge: CombineCompatible { }

// MARK:- Subscription

final class HogeSubscription<S: Subscriber>: Subscription where S.Input == Hoge {
    
    private var subscriber: S?
    
    init(subscriber: S, input: Hoge) {
        self.subscriber = subscriber
        _ = self.subscriber?.receive(input)
    }
    
    func request(_ demand: Subscribers.Demand) { }
    
    func cancel() {
        subscriber = nil
    }
}

// MARK:- Publisher

final class HogePublisher: Publisher {
    
    typealias Output = Hoge
    
    typealias Failure = HogeError
    
    let input: Hoge
    
    init(input: Hoge) {
        self.input = input
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = HogeSubscription(subscriber: subscriber, input: input)
        subscriber.receive(subscription: subscription)
    }
    
}
