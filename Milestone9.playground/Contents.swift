import UIKit

// -- MARK: Challenge #1
extension UIView {
    func bounceOut(with duration: Double) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

let v = UIView()
v.bounceOut(with: 3)

// -- MARK: Challenge #2

extension Int {
    func times(_ closure: () -> Void) {
        guard self > 0 else { return }
        for _ in 0..<self { closure() }
    }
}

3.times { print("hi") }

// -- MARK: Challenge #3

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let index = self.firstIndex(of: item) {
            self.remove(at: index)
        }
    }
}

var things = ["one","two","one"]

things.remove(item: "one")
print(things)
