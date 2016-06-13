
import UIKit


enum Action: Int {
    // These correlate to the button tags in the storyboard
    case Cool = 0
    case Important = 1
    case Note = 2
    case WTF = 3
    case ZZZZ = 4
    
    func name() -> String {
        switch self {
        case Cool: return "Cool     "
        case Important: return "Important"
        case Note: return "Note     "
        case WTF: return "WTF      "
        case ZZZZ: return "ZZZZ     "
        }
    }
}

class SessionEditorViewController: UIViewController {
    
    var sessionTimer: NSTimer?
    let startTime = NSDate().timeIntervalSince1970
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var documentTextView: UITextView!
    
    var filename = "\(NSUUID().UUIDString).txt"
    
    var documentText: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        documentTextView.text = ""
        documentTextView.selectable = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    func saveFile() {
        let fm = NSFileManager.defaultManager()
        let documentDirectory = try! fm.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        let fileURL = documentDirectory.URLByAppendingPathComponent(filename)
        try! documentText.writeToURL(fileURL, atomically: true, encoding: NSUTF8StringEncoding)
    }
    
    
    @IBAction func logMessage(sender: UIButton) {
        let tag = sender.tag
        guard let action = Action(rawValue: tag) else {
            print("unexpected button tag: \(tag).  No corresponding enum")
            return
        }
        logAction(action)
    }
    
    
    func logAction(action: Action) {
        let nowLabelText = labelTextForElapsedTime()
        let actionName = action.name()
        let commentText = commentTextField.text

        let textToLog = "\(nowLabelText) \(actionName) \(commentText ?? "")\n"
        
        documentText += textToLog
        
        documentTextView.text = documentText
        saveFile()
        
        commentTextField.text = ""
        commentTextField.resignFirstResponder()
    }
    
    
    func labelTextForElapsedTime() -> String {
        let elapsedTime = NSDate().timeIntervalSince1970 - startTime
        
        let hours = Int(elapsedTime) / (60 * 60)
        let minutes = (Int(elapsedTime) - (hours * 60 * 60)) / 60
        let seconds = Int(elapsedTime) - (hours * 60 * 60) - minutes * 60
        
        let text = NSString.init(format: "%02d:%02d:%02d", hours, minutes, seconds) as String
        return text
    }
    
}



extension SessionEditorViewController {
    func startTimer() {
        sessionTimer = 
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, 
                                                   selector: #selector(SessionEditorViewController.lubDub(_:)), 
                                                   userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        sessionTimer?.invalidate()
        sessionTimer = nil
    }
    
    func lubDub(timer: NSTimer) {
        timeLabel.text = labelTextForElapsedTime()
    }
}