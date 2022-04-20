//
//  RXApiServiceTests.swift
//  MuslimPrayerAppTests
//
//  Created by Shahul Hamed Shaik (HLB) on 16/04/2022.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

class RXApiServiceTests: XCTestCase {
    
    var disposeBag: DisposeBag?
    var viewModel: ESolatViewModel?
    var testScheduler: TestScheduler?
    var rxApiService: MockRXApiService?

    override func setUp() {
        super.setUp()
        
        disposeBag = DisposeBag()
        viewModel = ESolatViewModel()
        testScheduler = TestScheduler(initialClock: 0)
        rxApiService = MockRXApiService()
    }

    override func tearDown() {
        disposeBag = nil
        viewModel = nil
        testScheduler = nil
        rxApiService = nil
        super.tearDown()
    }
    
    func testRXAPiService() {
        let apiRequest = APIRequest(path: APIRequest.pathTakwimSolat, queryParameterItems: [String: String]())
        rxApiService!.performRequest(apiRequest: apiRequest).subscribe(
            onNext: { (solatData: TakwimSolatData) in
                self.viewModel?.takwimSolatData.onNext(DataManager.getTakwimSolatData())
            }, onError: { error in
                print(error)
            },
            onCompleted: {
                print("onCompleted")
            },
            onDisposed: {
                print("onDisposed")
            }).disposed(by: rxApiService!.disposeBag)
    }
    
    func testGetSomeData() {
        // setup
        let expectation = self.expectation(description: "request succeeded")
        let apiRequest = APIRequest(path: APIRequest.pathTakwimSolat, queryParameterItems: [String: String]())
        
        rxApiService?.verifyInput = { (data) in
            XCTAssertNotNil(data)
        }
        
        rxApiService?.output = DataManager.getTakwimSolatDataWithHttpResponse()
        
        let service = SomeService(remoteClient: rxApiService!)

        let observable = service.getSomeData(request: apiRequest.request())
        
        // verify
        observable
            .subscribe(onNext: { data in
                XCTAssertNotNil(data)
                expectation.fulfill()
            })
            .disposed(by: disposeBag!)
        
        waitForExpectations(timeout: 1, handler: nil)
    }

}
