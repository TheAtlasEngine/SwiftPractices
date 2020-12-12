protocol CombineCompatible { }

extension CombineCompatible where Self == Hoge {
    
    var publisher: HogePublisher {
        .init(input: self)
    }
}
