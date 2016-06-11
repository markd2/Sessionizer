
import UIKit

class SessionEditorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logMessage(sender: UIButton) {
        print("logging for \(sender.tag)")
    }

}
