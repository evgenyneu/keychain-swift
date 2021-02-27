import Foundation

#if canImport(SwiftUI) && canImport(Combine)
import SwiftUI
import Combine

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13, *)
public struct KeychainStorage<Value>: DynamicProperty where Value: Codable {
    @ObservedObject private var service: Service<Value>

    public init(key: String, keychain: KeychainSwift, wrappedValue value: Value) {
        service = Service(
            key: key,
            keychain: keychain,
            defaultValue: value
        )
    }

    public init(key: String, keychain: KeychainSwift) where Value: ExpressibleByNilLiteral {
        service = Service(
            key: key,
            keychain: keychain,
            defaultValue: nil
        )
    }

    public var wrappedValue: Value {
        get { service.value }
        set { service.value = newValue }
    }

    public var projectedValue: Binding<Value> {
        Binding(
            get: { service.value },
            set: { service.value = $0 }
        )
    }

    public var publisher: AnyPublisher<Value, Never> {
        service.objectWillChange
            .prepend(())
            .map { [unowned service] in service.value }
            .eraseToAnyPublisher()
    }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13, *)
private extension KeychainStorage {
    final class Service<Value>: ObservableObject where Value: Codable {

        private let key: String
        private let keychain: KeychainSwift
        private let defaultValue: Value

        private var subscribers = [AnyCancellable]()

        init(key: String, keychain: KeychainSwift, defaultValue: Value) {
            self.key = key
            self.defaultValue = defaultValue
            self.keychain = keychain
        }

        private func load() {
            NotificationCenter.default
                .publisher(for: kKeychainStoreDidChanged)
                .sink(receiveValue: { [weak self] _ in
                    self?.objectWillChange.send()
                }).store(in: &subscribers)
        }
    }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13, *)
private extension KeychainStorage.Service {
    var kKeychainStoreDidChanged: Notification.Name {
        .init("Keychain.\(key).didChange")
    }

    func postValueDidChange() {
        NotificationCenter.default.post(
            name: kKeychainStoreDidChanged,
            object: nil
        )
    }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13, *)
extension KeychainStorage.Service {
    var value: Value {
        get {
            guard
                let data = keychain.getData(key),
                let value = try? JSONDecoder().decode(Value.self, from: data)
            else { return defaultValue }

            return value
        }

        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                keychain.delete(key)
                postValueDidChange()
                return
            }

            keychain.set(data, forKey: key)
            postValueDidChange()
        }
    }
}
#endif
