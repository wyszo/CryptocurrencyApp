
# CryptocurrencyApp

A sample Swift project to display cryptocurrency market prices, demonstrating knowledge of: good app architecture, unit testing, dependency injection. 

Data is fetched from a static JSON file hosted on Amazon S3. 

## Tech stack

- Swift 5
- PromiseKit
- Firebase analytics
- Resolver (Dependency injection)
- SwiftyMocky (unit testing)

PromiseKit is a well-known library that simplifies writing asynchronous code.

Resolver solves a problem where dependencies of view controllers/presenters further in the flow have to be passed down the flows even to the objects that don't need them, so they can be passed further along. It also introduces some syntactic sugar to be able to automatically resolve dependencies marked with @Injected keyword. 

SwiftyMocky is a great framework for automatically generating mocks from protocol definitions and providing a Given statement for stubbing return values and Verify for asserting that the methods have been executed on a mock with expected parameters. 

## Screenshots

![Home](images/home.jpg) ![CryptocurrencyDetail](images/crypto_detail.jpg)
