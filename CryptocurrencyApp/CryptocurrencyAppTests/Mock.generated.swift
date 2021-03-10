// Generated using Sourcery 1.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 4.0.1

import SwiftyMocky
import XCTest
import Foundation
import PromiseKit
@testable import CryptocurrencyApp


// MARK: - AnalyticsProviderProtocol

open class AnalyticsProviderProtocolMock: AnalyticsProviderProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func screenView(_: ScreenId) {
        addInvocation(.m_screenView)
		let perform = methodPerformValue(.m_screenView) as? () -> Void
		perform?()
    }

    open func cryptocurrencyListItemSelected(_: Cryptocurrency) {
        addInvocation(.m_cryptocurrencyListItemSelected)
		let perform = methodPerformValue(.m_cryptocurrencyListItemSelected) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_screenView
        case m_cryptocurrencyListItemSelected

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_screenView, .m_screenView): return .match

            case (.m_cryptocurrencyListItemSelected, .m_cryptocurrencyListItemSelected): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_screenView: return 0
            case .m_cryptocurrencyListItemSelected: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_screenView: return ".screenView(_:)()"
            case .m_cryptocurrencyListItemSelected: return ".cryptocurrencyListItemSelected(_:)()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func screenView() -> Verify { return Verify(method: .m_screenView)}
        public static func cryptocurrencyListItemSelected() -> Verify { return Verify(method: .m_cryptocurrencyListItemSelected)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func screenView(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_screenView, performs: perform)
        }
        public static func cryptocurrencyListItemSelected(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_cryptocurrencyListItemSelected, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - CryptoDataProviderProtocol

open class CryptoDataProviderProtocolMock: CryptoDataProviderProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getCryptocurrencies() -> Promise<CryptocurrencyList> {
        addInvocation(.m_getCryptocurrencies)
		let perform = methodPerformValue(.m_getCryptocurrencies) as? () -> Void
		perform?()
		var __value: Promise<CryptocurrencyList>
		do {
		    __value = try methodReturnValue(.m_getCryptocurrencies).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getCryptocurrencies(). Use given")
			Failure("Stub return value not specified for getCryptocurrencies(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getCryptocurrencies

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getCryptocurrencies, .m_getCryptocurrencies): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getCryptocurrencies: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getCryptocurrencies: return ".getCryptocurrencies()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getCryptocurrencies(willReturn: Promise<CryptocurrencyList>...) -> MethodStub {
            return Given(method: .m_getCryptocurrencies, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getCryptocurrencies(willProduce: (Stubber<Promise<CryptocurrencyList>>) -> Void) -> MethodStub {
            let willReturn: [Promise<CryptocurrencyList>] = []
			let given: Given = { return Given(method: .m_getCryptocurrencies, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Promise<CryptocurrencyList>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCryptocurrencies() -> Verify { return Verify(method: .m_getCryptocurrencies)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCryptocurrencies(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getCryptocurrencies, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - HttpClient

open class HttpClientMock: HttpClient, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func sendRequest(method: HttpMethod,                     path: String,                     queryParameters: [String: String]?) -> Promise<Data> {
        addInvocation(.m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(Parameter<HttpMethod>.value(`method`), Parameter<String>.value(`path`), Parameter<[String: String]?>.value(`queryParameters`)))
		let perform = methodPerformValue(.m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(Parameter<HttpMethod>.value(`method`), Parameter<String>.value(`path`), Parameter<[String: String]?>.value(`queryParameters`))) as? (HttpMethod, String, [String: String]?) -> Void
		perform?(`method`, `path`, `queryParameters`)
		var __value: Promise<Data>
		do {
		    __value = try methodReturnValue(.m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(Parameter<HttpMethod>.value(`method`), Parameter<String>.value(`path`), Parameter<[String: String]?>.value(`queryParameters`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for sendRequest(method: HttpMethod,                     path: String,                     queryParameters: [String: String]?). Use given")
			Failure("Stub return value not specified for sendRequest(method: HttpMethod,                     path: String,                     queryParameters: [String: String]?). Use given")
		}
		return __value
    }

    open func sendRequest(metadata: RequestMetadata) -> Promise<Data> {
        addInvocation(.m_sendRequest__metadata_metadata(Parameter<RequestMetadata>.value(`metadata`)))
		let perform = methodPerformValue(.m_sendRequest__metadata_metadata(Parameter<RequestMetadata>.value(`metadata`))) as? (RequestMetadata) -> Void
		perform?(`metadata`)
		var __value: Promise<Data>
		do {
		    __value = try methodReturnValue(.m_sendRequest__metadata_metadata(Parameter<RequestMetadata>.value(`metadata`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for sendRequest(metadata: RequestMetadata). Use given")
			Failure("Stub return value not specified for sendRequest(metadata: RequestMetadata). Use given")
		}
		return __value
    }

    open func sendRequest(method: HttpMethod,                     path: String) -> Promise<Data> {
        addInvocation(.m_sendRequest__method_methodpath_path(Parameter<HttpMethod>.value(`method`), Parameter<String>.value(`path`)))
		let perform = methodPerformValue(.m_sendRequest__method_methodpath_path(Parameter<HttpMethod>.value(`method`), Parameter<String>.value(`path`))) as? (HttpMethod, String) -> Void
		perform?(`method`, `path`)
		var __value: Promise<Data>
		do {
		    __value = try methodReturnValue(.m_sendRequest__method_methodpath_path(Parameter<HttpMethod>.value(`method`), Parameter<String>.value(`path`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for sendRequest(method: HttpMethod,                     path: String). Use given")
			Failure("Stub return value not specified for sendRequest(method: HttpMethod,                     path: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(Parameter<HttpMethod>, Parameter<String>, Parameter<[String: String]?>)
        case m_sendRequest__metadata_metadata(Parameter<RequestMetadata>)
        case m_sendRequest__method_methodpath_path(Parameter<HttpMethod>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(let lhsMethod, let lhsPath, let lhsQueryparameters), .m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(let rhsMethod, let rhsPath, let rhsQueryparameters)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMethod, rhs: rhsMethod, with: matcher), lhsMethod, rhsMethod, "method"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "path"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQueryparameters, rhs: rhsQueryparameters, with: matcher), lhsQueryparameters, rhsQueryparameters, "queryParameters"))
				return Matcher.ComparisonResult(results)

            case (.m_sendRequest__metadata_metadata(let lhsMetadata), .m_sendRequest__metadata_metadata(let rhsMetadata)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMetadata, rhs: rhsMetadata, with: matcher), lhsMetadata, rhsMetadata, "metadata"))
				return Matcher.ComparisonResult(results)

            case (.m_sendRequest__method_methodpath_path(let lhsMethod, let lhsPath), .m_sendRequest__method_methodpath_path(let rhsMethod, let rhsPath)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMethod, rhs: rhsMethod, with: matcher), lhsMethod, rhsMethod, "method"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "path"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_sendRequest__metadata_metadata(p0): return p0.intValue
            case let .m_sendRequest__method_methodpath_path(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_sendRequest__method_methodpath_pathqueryParameters_queryParameters: return ".sendRequest(method:path:queryParameters:)"
            case .m_sendRequest__metadata_metadata: return ".sendRequest(metadata:)"
            case .m_sendRequest__method_methodpath_path: return ".sendRequest(method:path:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func sendRequest(method: Parameter<HttpMethod>, path: Parameter<String>, queryParameters: Parameter<[String: String]?>, willReturn: Promise<Data>...) -> MethodStub {
            return Given(method: .m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(`method`, `path`, `queryParameters`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func sendRequest(metadata: Parameter<RequestMetadata>, willReturn: Promise<Data>...) -> MethodStub {
            return Given(method: .m_sendRequest__metadata_metadata(`metadata`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func sendRequest(method: Parameter<HttpMethod>, path: Parameter<String>, willReturn: Promise<Data>...) -> MethodStub {
            return Given(method: .m_sendRequest__method_methodpath_path(`method`, `path`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func sendRequest(method: Parameter<HttpMethod>, path: Parameter<String>, queryParameters: Parameter<[String: String]?>, willProduce: (Stubber<Promise<Data>>) -> Void) -> MethodStub {
            let willReturn: [Promise<Data>] = []
			let given: Given = { return Given(method: .m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(`method`, `path`, `queryParameters`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Promise<Data>).self)
			willProduce(stubber)
			return given
        }
        public static func sendRequest(metadata: Parameter<RequestMetadata>, willProduce: (Stubber<Promise<Data>>) -> Void) -> MethodStub {
            let willReturn: [Promise<Data>] = []
			let given: Given = { return Given(method: .m_sendRequest__metadata_metadata(`metadata`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Promise<Data>).self)
			willProduce(stubber)
			return given
        }
        public static func sendRequest(method: Parameter<HttpMethod>, path: Parameter<String>, willProduce: (Stubber<Promise<Data>>) -> Void) -> MethodStub {
            let willReturn: [Promise<Data>] = []
			let given: Given = { return Given(method: .m_sendRequest__method_methodpath_path(`method`, `path`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Promise<Data>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func sendRequest(method: Parameter<HttpMethod>, path: Parameter<String>, queryParameters: Parameter<[String: String]?>) -> Verify { return Verify(method: .m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(`method`, `path`, `queryParameters`))}
        public static func sendRequest(metadata: Parameter<RequestMetadata>) -> Verify { return Verify(method: .m_sendRequest__metadata_metadata(`metadata`))}
        public static func sendRequest(method: Parameter<HttpMethod>, path: Parameter<String>) -> Verify { return Verify(method: .m_sendRequest__method_methodpath_path(`method`, `path`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func sendRequest(method: Parameter<HttpMethod>, path: Parameter<String>, queryParameters: Parameter<[String: String]?>, perform: @escaping (HttpMethod, String, [String: String]?) -> Void) -> Perform {
            return Perform(method: .m_sendRequest__method_methodpath_pathqueryParameters_queryParameters(`method`, `path`, `queryParameters`), performs: perform)
        }
        public static func sendRequest(metadata: Parameter<RequestMetadata>, perform: @escaping (RequestMetadata) -> Void) -> Perform {
            return Perform(method: .m_sendRequest__metadata_metadata(`metadata`), performs: perform)
        }
        public static func sendRequest(method: Parameter<HttpMethod>, path: Parameter<String>, perform: @escaping (HttpMethod, String) -> Void) -> Perform {
            return Perform(method: .m_sendRequest__method_methodpath_path(`method`, `path`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - RouterProtocol

open class RouterProtocolMock: RouterProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func createRootViewController() -> UINavigationController? {
        addInvocation(.m_createRootViewController)
		let perform = methodPerformValue(.m_createRootViewController) as? () -> Void
		perform?()
		var __value: UINavigationController? = nil
		do {
		    __value = try methodReturnValue(.m_createRootViewController).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func presentCryptoDetailViewController(_ cryptocurrency: Cryptocurrency) {
        addInvocation(.m_presentCryptoDetailViewController__cryptocurrency(Parameter<Cryptocurrency>.value(`cryptocurrency`)))
		let perform = methodPerformValue(.m_presentCryptoDetailViewController__cryptocurrency(Parameter<Cryptocurrency>.value(`cryptocurrency`))) as? (Cryptocurrency) -> Void
		perform?(`cryptocurrency`)
    }


    fileprivate enum MethodType {
        case m_createRootViewController
        case m_presentCryptoDetailViewController__cryptocurrency(Parameter<Cryptocurrency>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_createRootViewController, .m_createRootViewController): return .match

            case (.m_presentCryptoDetailViewController__cryptocurrency(let lhsCryptocurrency), .m_presentCryptoDetailViewController__cryptocurrency(let rhsCryptocurrency)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCryptocurrency, rhs: rhsCryptocurrency, with: matcher), lhsCryptocurrency, rhsCryptocurrency, "_ cryptocurrency"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_createRootViewController: return 0
            case let .m_presentCryptoDetailViewController__cryptocurrency(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_createRootViewController: return ".createRootViewController()"
            case .m_presentCryptoDetailViewController__cryptocurrency: return ".presentCryptoDetailViewController(_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func createRootViewController(willReturn: UINavigationController?...) -> MethodStub {
            return Given(method: .m_createRootViewController, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createRootViewController(willProduce: (Stubber<UINavigationController?>) -> Void) -> MethodStub {
            let willReturn: [UINavigationController?] = []
			let given: Given = { return Given(method: .m_createRootViewController, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (UINavigationController?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func createRootViewController() -> Verify { return Verify(method: .m_createRootViewController)}
        public static func presentCryptoDetailViewController(_ cryptocurrency: Parameter<Cryptocurrency>) -> Verify { return Verify(method: .m_presentCryptoDetailViewController__cryptocurrency(`cryptocurrency`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createRootViewController(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_createRootViewController, performs: perform)
        }
        public static func presentCryptoDetailViewController(_ cryptocurrency: Parameter<Cryptocurrency>, perform: @escaping (Cryptocurrency) -> Void) -> Perform {
            return Perform(method: .m_presentCryptoDetailViewController__cryptocurrency(`cryptocurrency`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - URLRequestSender

open class URLRequestSenderMock: URLRequestSender, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func send(request: URLRequest) -> Promise<Data> {
        addInvocation(.m_send__request_request(Parameter<URLRequest>.value(`request`)))
		let perform = methodPerformValue(.m_send__request_request(Parameter<URLRequest>.value(`request`))) as? (URLRequest) -> Void
		perform?(`request`)
		var __value: Promise<Data>
		do {
		    __value = try methodReturnValue(.m_send__request_request(Parameter<URLRequest>.value(`request`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for send(request: URLRequest). Use given")
			Failure("Stub return value not specified for send(request: URLRequest). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_send__request_request(Parameter<URLRequest>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_send__request_request(let lhsRequest), .m_send__request_request(let rhsRequest)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher), lhsRequest, rhsRequest, "request"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_send__request_request(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_send__request_request: return ".send(request:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func send(request: Parameter<URLRequest>, willReturn: Promise<Data>...) -> MethodStub {
            return Given(method: .m_send__request_request(`request`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func send(request: Parameter<URLRequest>, willProduce: (Stubber<Promise<Data>>) -> Void) -> MethodStub {
            let willReturn: [Promise<Data>] = []
			let given: Given = { return Given(method: .m_send__request_request(`request`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Promise<Data>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func send(request: Parameter<URLRequest>) -> Verify { return Verify(method: .m_send__request_request(`request`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func send(request: Parameter<URLRequest>, perform: @escaping (URLRequest) -> Void) -> Perform {
            return Perform(method: .m_send__request_request(`request`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

