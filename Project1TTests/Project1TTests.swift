//
//  Project1TTests.swift
//  Project1TTests
//
//  Created by Curtis Colly on 2/9/20.
//  Copyright © 2020 Snaap. All rights reserved.
//

import XCTest
@testable import Project1T

class Project1TTests: XCTestCase {

    func testLoadingImages() {
        // Given
        let sut = ViewController()
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(sut.pictures.count, 10, "There should be 10 pictures.")
    }
    
    func testTableExists() {
        // Given
        let sut = ViewController()
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertNotNil(sut.tableView)
    }
    
    func testTableViewHasCorrectRowCount() {
        // Given
        let sut = ViewController()
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, sut.pictures.count)
    }
    
    func testEachCellHasTheCorrectText() {
           // Given
           let sut = ViewController()
           
           // When
           sut.loadViewIfNeeded()
           
           // Then
           for (index, picture) in sut.pictures.enumerated() {
               let indexPath = IndexPath(item: index, section: 0)
               let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.textLabel?.text, picture)
               
           }
       }
    
    func testCellsHaveDisclosureIndicators() {
        // Given
        let sut = ViewController()
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        for index in sut.pictures.indices {
            let indexPath = IndexPath(item: index, section: 0)
            let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.accessoryType, .disclosureIndicator)
        }
    }
    
    func testViewControllerHasLargeTitles() {
        // Given
        let sut = ViewController()
        _ = UINavigationController(rootViewController: sut)
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertTrue(sut.navigationController?.navigationBar.prefersLargeTitles ?? false)
    }
    
    func testNavigationBarHasStormViewerTitle() {
        // Given
        let sut = ViewController()
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(sut.title, "Storm Viewer")
    }
    
    func testDetailImageViewExists() {
        // Given
        let sut = DetailViewController()
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertNotNil(sut.imageView)
    }
    
    func testDetailViewIsImageView() {
        // Given
        let sut = DetailViewController()
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(sut.view, sut.imageView)
    }
    
    func testImageViewBackgroundColorIsWhite() {
        // Given
        let sut = DetailViewController()
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(sut.view.backgroundColor, UIColor.white)
    }
    
    func testImageViewContentModeIsScaleAspectFit() {
        // Given
        let sut = DetailViewController()
        let comparableView = UIImageView()
        comparableView.contentMode = .scaleAspectFit
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(sut.view.contentMode, comparableView.contentMode )
    }
    
    func testDetailLoadsImage() {
        // Given
        let filenameToTest = "nssl0049.jpg"
        let imageToLoad = UIImage(named: filenameToTest, in: Bundle.main, compatibleWith: nil)
        
        let sut = DetailViewController()
        sut.selectedImage = filenameToTest
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(sut.imageView.image, imageToLoad)
    }
    
    func testSelectingImageShowsDetail() {
        // Given
        let sut = ViewController()
        let navigationController = UINavigationController(rootViewController: sut)
        let testIndexPath = IndexPath(row: 0, section: 0)
        
        // When
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)
        
        // Create an expectation
        let expectation = XCTestExpectation(description: "Selecting a table view cell")
        
        // ...then fulfill it asynchronously
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(navigationController.topViewController is DetailViewController)
    }
    
    func testSelectingImageShowsDetailImage() {
        // Given
        let sut = ViewController()
        let navigationController = UINavigationController(rootViewController: sut)
        let testIndexPath = IndexPath(row: 0, section: 0)
        let filenameToTest = "nssl0049.jpg"
        let imageToLoad = UIImage(named: filenameToTest, in: Bundle.main, compatibleWith: nil)
        
        // When
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)
        
        let expectation = XCTestExpectation(description: "Selecting a table view cell.")
        
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1)
        
        guard let detail = navigationController.topViewController as? DetailViewController else {
            XCTFail("Didn't push to a detail view controller")
            return
        }
        
        detail.loadViewIfNeeded()
        
        XCTAssertEqual(detail.imageView.image, imageToLoad)
    }


}
