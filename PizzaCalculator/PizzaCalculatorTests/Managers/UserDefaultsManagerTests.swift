//
//  ContentView-ViewModel-Tests.swift
//  PizzaCalculatorTests
//
//  Created by Zachary Adams on 2/25/24.
//

import XCTest
@testable import PizzaCalculator

final class UserDefaultsManagerTests: XCTestCase {
    
    private class MockUserDefaultsManager: UserDefaults {
        var dictionary: [String: Any] = [:]
        
        override func set(_ value: Any?, forKey defaultName: String) {
            dictionary[defaultName] = value
        }
        
        override func bool(forKey defaultName: String) -> Bool {
            return dictionary[defaultName] as? Bool ?? false
        }
        
        override func integer(forKey defaultName: String) -> Int {
            return dictionary[defaultName] as? Int ?? -1
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetIsMakingPizza() {
        let mockUserDefaults = MockUserDefaultsManager()
        UserDefaultsManager.setIsMakingPizza(true, userDefaults: mockUserDefaults)
        
        XCTAssertTrue(mockUserDefaults.dictionary.contains(where: { (key: String, value: Any?) in
            key == UserDefaultsManager.makingPizzKey
        }))
        
        XCTAssertEqual(true, mockUserDefaults.dictionary[UserDefaultsManager.makingPizzKey] as? Bool)
    }
    
    func testGetIsMakingPizza() {
        let mockUserDefaults = MockUserDefaultsManager()
        mockUserDefaults.dictionary[UserDefaultsManager.makingPizzKey] = true
        
        XCTAssertEqual(true, UserDefaultsManager.getIsMakingPizza(userDefaults: mockUserDefaults))
    }
    
    func testSetNumPizzas() {
        let mockUserDefaults = MockUserDefaultsManager()
        UserDefaultsManager.setNumPizzas(3, userDefaults: mockUserDefaults)
        
        XCTAssertTrue(mockUserDefaults.dictionary.contains(where: { (key: String, value: Any?) in
            key == UserDefaultsManager.numPizzasKey
        }))
        
        XCTAssertEqual(3, mockUserDefaults.dictionary[UserDefaultsManager.numPizzasKey] as? Int)
    }
    
    func testGetNumPizzas() {
        let mockUserDefaults = MockUserDefaultsManager()
        mockUserDefaults.dictionary[UserDefaultsManager.numPizzasKey] = 5
        
        XCTAssertEqual(5, UserDefaultsManager.getNumPizzas(userDefaults: mockUserDefaults))
    }
    
    func testSetCurrentStep() {
        let mockUserDefaults = MockUserDefaultsManager()
        UserDefaultsManager.setCurrentStep(5, userDefaults: mockUserDefaults)
        
        XCTAssertTrue(mockUserDefaults.dictionary.contains(where: { (key: String, value: Any?) in
            key == UserDefaultsManager.currentStepKey
        }))
        
        XCTAssertEqual(5, mockUserDefaults.dictionary[UserDefaultsManager.currentStepKey] as? Int)
    }
    
    func testGetCurrentStep() {
        let mockUserDefaults = MockUserDefaultsManager()
        mockUserDefaults.dictionary[UserDefaultsManager.currentStepKey] = 10
        
        XCTAssertEqual(10, UserDefaultsManager.getCurrentStep(userDefaults: mockUserDefaults))
    }

}
