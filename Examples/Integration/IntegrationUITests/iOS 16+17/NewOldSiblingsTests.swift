import InlineSnapshotTesting
import TestCases
import XCTest

@MainActor
final class iOS16_17_NewOldSiblingsTests: BaseIntegrationTests {
  override func setUp() {
    super.setUp()
    self.app.buttons["iOS 16 + 17"].tap()
    self.app.buttons["Siblings"].tap()
    self.clearLogs()
    //SnapshotTesting.isRecording = true
  }

  func testBasics() {
    self.app.buttons.matching(identifier: "Increment").element(boundBy: 0).tap()
    XCTAssertEqual(self.app.staticTexts["1"].exists, true)
    self.assertLogs {
      """
      BasicsView.body
      StoreOf<BasicsView.Feature>.scope
      StoreOf<NewOldSiblingsView.Feature>.scope
      """
    }

    self.app.buttons.matching(identifier: "Decrement").element(boundBy: 1).tap()
    XCTAssertEqual(self.app.staticTexts["-1"].exists, true)
    self.assertLogs {
      """
      ObservableBasicsView.body
      StoreOf<BasicsView.Feature>.scope
      StoreOf<NewOldSiblingsView.Feature>.scope
      """
    }
  }

  func testResetAll() {
    self.app.buttons.matching(identifier: "Increment").element(boundBy: 0).tap()
    XCTAssertEqual(self.app.staticTexts["1"].exists, true)
    self.app.buttons.matching(identifier: "Decrement").element(boundBy: 1).tap()
    XCTAssertEqual(self.app.staticTexts["-1"].exists, true)
    self.clearLogs()
    self.app.buttons["Reset all"].tap()
    XCTAssertEqual(self.app.staticTexts["1"].exists, false)
    XCTAssertEqual(self.app.staticTexts["-1"].exists, false)
    XCTAssertEqual(self.app.staticTexts["0"].exists, true)
    self.assertLogs {
      """
      BasicsView.body
      StoreOf<BasicsView.Feature>.scope
      StoreOf<NewOldSiblingsView.Feature>.scope
      StoreOf<NewOldSiblingsView.Feature>.scope
      """
    }
  }

  func testResetSelf() {
    self.app.buttons.matching(identifier: "Increment").element(boundBy: 0).tap()
    XCTAssertEqual(self.app.staticTexts["1"].exists, true)
    self.app.buttons.matching(identifier: "Decrement").element(boundBy: 1).tap()
    XCTAssertEqual(self.app.staticTexts["-1"].exists, true)
    self.clearLogs()
    self.app.buttons["Reset self"].tap()
    XCTAssertEqual(self.app.staticTexts["1"].exists, false)
    XCTAssertEqual(self.app.staticTexts["-1"].exists, false)
    XCTAssertEqual(self.app.staticTexts["0"].exists, true)
    self.assertLogs {
      """
      BasicsView.body
      StoreOf<BasicsView.Feature>.scope
      StoreOf<NewOldSiblingsView.Feature>.scope
      StoreOf<NewOldSiblingsView.Feature>.scope
      """
    }
  }
}