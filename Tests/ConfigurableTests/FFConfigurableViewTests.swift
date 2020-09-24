import XCTest
import UIKit
import Configurable

final class FFConfigurableViewTests: XCTestCase {
    func testExample() {
        let testView = TestView.fromNib()
        let data = TestItem()
        
        testView.configure(with: data)
        
        let expectedTitle = "Snatch"
        let expectedText = "You should never underestimate the predictability of stupidity."
        let expectedColor = UIColor.gray
        XCTAssertEqual(testView.titleLabel.text, expectedTitle)
        XCTAssertEqual(testView.textLabel.text, expectedText)
        XCTAssertEqual(testView.backgroundColor, expectedColor)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

struct TestItem: Identifiable {
    var id: String = UUID().uuidString
    var title: String? = "Snatch"
    var text: String? = "You should never underestimate the predictability of stupidity."
    var author: String = "Bullet Tooth Tony"
    var color: UIColor? = .gray
}

extension TestItem: TestDisplayable {
    var testTitle: String? {
        title
    }
    
    var testText: String? {
        text
    }
    
    var testViewColor: UIColor? {
        color
    }
}

protocol TestDisplayable: Displayable {
    var id: String { get }
    var testTitle: String? { get }
    var testText: String? { get }
    var testViewColor: UIColor? { get }
}

class TestView: UIView, Configurable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var data: TestDisplayable? {
        didSet {
            updateView()
        }
    }
    
    func configure(with displayable: Displayable) {
        guard let displayable = displayable as? TestDisplayable else {
            preconditionFailure("Use the correct displayable: TestDisplayable")
        }
        
        data = displayable
    }
    
    private func updateView() {
        titleLabel.text = data?.testTitle
        textLabel.text = data?.testText
        self.backgroundColor = data?.testViewColor?.withAlphaComponent(0.5)
    }

}
