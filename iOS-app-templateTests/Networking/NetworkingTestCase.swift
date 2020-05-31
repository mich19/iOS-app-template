//
//  NetworkingTestCase.swift
//  iOS-app-templateTests
//
//  Created by Michel Franco Téllez on 31/05/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import XCTest
@testable import iOS_app_template

class NetworkingTestCase: XCTestCase {
    let httpClient = HTTPClient()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPostService() {
        let expectation = XCTestExpectation(description: "Post service success")
        httpClient.excecute(service: TestServices.post(comment: Comment(id: 4, body: "some coment l", postId: 3))) { (result: HTTPObjectResult<Comment>) in
            switch result {
            case let .success(httpStatus: status, response: response):
                expectation.fulfill()
            case .failure(error: let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 15)
    }
    
    func testGetArrayService() {
        let expectation = XCTestExpectation(description: "Get service success")
        httpClient.excecute(service: TestServices.get) { (result: HTTPArrayResult<Post>) in
            switch result {
            case let .success(httpStatus: status, response: response):
                expectation.fulfill()
            case .failure(error: let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 15)
    }
    
    func testGetService() {
        let expectation = XCTestExpectation(description: "Get service success")
        httpClient.excecute(service: TestServices.profile) { (result: HTTPObjectResult<Profile>) in
            switch result {
            case let .success(httpStatus: status, response: response):
                expectation.fulfill()
            case .failure(error: let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 15)
    }

}


enum TestServices: HTTPService {
    case post(comment: Comment)
    case get
    case profile
    
    var host: String {
        return "https://my-json-server.typicode.com"
    }
    
    var endPoint: String {
        switch self {
        case .post:
            return "mich19/Fake-JSON-Server/comments"
        case .get:
            return "mich19/Fake-JSON-Server/posts"
        case .profile:
            return "mich19/Fake-JSON-Server/profile"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .post:
            return .post
        case .get, .profile:
            return .get
        }
    }
    
    var extraHeaders: [String : String]? {
        return ["Authentication": "=ijoduhfdjw9whj2781+"]
    }
    
    var queryParams: [String : String]? {
        switch self {
        case .get:
            return ["id": "1"]
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .post(comment: let comment):
            return comment.toRequestBodyData()
        default:
            return nil
        }
    }
    
}

struct Comment: Codable {
    var id: Int
    var body: String
    var postId: Int
}

struct Post: Codable {
    var id: Int
    var title: String
}

struct Profile: Codable {
    var name: String
    var lastName: String
    var age: Int
    var city: String
}
