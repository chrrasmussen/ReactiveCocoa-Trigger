import UIKit
import ReactiveSwift
import ReactiveCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let config = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: config)

        let request = URLRequest(url: Bundle.main.url(forResource: "Test", withExtension: "txt")!)

        for i in 1...200 {
            print("Requesting: #\(i)")
            let task = urlSession.reactive.data(with: request)

            task.startWithCompleted {
                print("Completed: #\(i)")
            }

            // This is the problematic code. Remove comment from line 26 to introduce bug.
            let viewController = UIViewController()
//            _ = viewController.reactive.trigger(for: #selector(UIViewController.viewDidAppear(_:)))
            // Observing the returned signal does not change anything. This one line is enough to break the URLSession.
        }
    }
}
