//
//  ResultViewCOntrollerTest.swift
//  EssDevQuizTests
//
//  Created by admin on 02.07.2024.
//

import Foundation
import XCTest
@testable import EssDevQuiz

class ResultViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderResult() {
        let sut = makeSUT(summary: "A summary")
        
        XCTAssertEqual(sut.headerLabel.text, "A summary")
    }
    
    func test_viewDidLoad_renderAnswers() {
        var sut = makeSUT(answers: [])
        
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
        
        let answer = makeAnswer()
        sut = makeSUT(answers: [answer])
        
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 1)
    }
    
    func test_viewDidLoad_witCorrectAnswer_renderCorrectAnswerCell() {
        //Given
        let answer = makeAnswer(question: "Question 1?",
                                answer: "Answer 1")
        
        let sut = makeSUT(answers: [answer])
        // When
        let cell = sut.tableView.cell(row: 0, section: 0) as? CorrectAnswerCell
        // Then
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Question 1?")
        XCTAssertEqual(cell?.answerLabel.text, "Answer 1")
    }
    
    func test_viewDidLoad_withWrongAnswer_renderWrongAnswerCell() {
        //Given
        let answer = makeAnswer(question: "Question 1?",
                                answer: "Answer 1",
                                correctAnswer: "Answer 2")
        
        let sut = makeSUT(answers: [answer])
        // When
        let cell = sut.tableView.cell(row: 0, section: 0) as? WrongAnswerCell
        // Then
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Question 1?")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "Answer 1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "Answer 2")
    }
    
    //MARK: - Helpers
    private func makeSUT(summary: String = "",
                         answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    private func makeAnswer(question: String = "",
                            answer: String = "",
                            correctAnswer: String? = nil) -> PresentableAnswer {
        
        PresentableAnswer(question: question,
                          answer: answer,
                          correctAnswer: correctAnswer)
    }
}
