//
//  QuestionViewControllerTest.swift
//  EssDevQuizTests
//
//  Created by admin on 28.06.2024.
//

import Foundation
import XCTest
@testable import EssDevQuiz

class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderHeaderQuestionText() {
        let sut = makeSUT(question: "Q1")
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_renderOptions() {
        var sut = makeSUT(options: [])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
        
        sut = makeSUT(options: ["A1"])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)

    }
    
    func test_viewDidLoad_withOneOptions_renderOneOptionText() {
        let sut = makeSUT(question: "Q1", options: ["A1"])
        let cell = sut.tableView.cell(row: 0, section: 0)
        
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWithSelectedOption() {
        var receivedAnswer = [String]()
        let sut = makeSUT(question: "Q1", options: ["A1", "A2"]) {
            receivedAnswer = $0
        }
        
        sut.tableView.select(row: 0, section: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1, section: 0)
        
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doNotNotifiesDelegate() {
        var callbackCount = 0
        let sut = makeSUT(question: "Q1", options: ["A1", "A2"]) { _ in
            callbackCount += 1
        }
        
        sut.tableView.select(row: 0, section: 0)
        
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0, section: 0)
        
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionSelected_withMultipleSelection_notifiesDelegateWithSelectedOptions() {
        var receivedAnswer = [String]()
        let sut = makeSUT(question: "Q1", options: ["A1", "A2"]) {
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0, section: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1, section: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
        
    }
    
    func test_optionDeselected_withMultipleSelection_notifiesDelegateWithSelectedOptions() {
        var receivedAnswer = [String]()
        let sut = makeSUT(question: "Q1", options: ["A1", "A2"]) {
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0, section: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1, section: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
        
        sut.tableView.deselect(row: 1, section: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1"])
        
    }
    
    //MARK: - Helpers
    
    func makeSUT(question: String = "",
                 options: [String] = [],
                 selection: @escaping (([String]) -> Void) = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question,
                                         options: options,
                                         selection: selection)
        _ = sut.view
        return sut
    }
}
