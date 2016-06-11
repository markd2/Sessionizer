
import UIKit

class SessionEditorViewController: UIViewController {
    
    var sessionTimer: NSTimer?
    let startTime = NSDate().timeIntervalSince1970
    
    @IBOutlet var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    
    @IBAction func logMessage(sender: UIButton) {
        print("logging for \(sender.tag)")
    }
    
    
    func updateTimeLabel(time: NSTimeInterval) {
        let hours = Int(time) / (60 * 60)
        let minutes = (Int(time) - (hours * 60 * 60)) / 60
        let seconds = Int(time) - (hours * 60 * 60) - minutes * 60
        
        let text = NSString.init(format: "%02d:%02d:%02d", hours, minutes, seconds) as String
        timeLabel.text = text
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
        let elapsedTime = NSDate().timeIntervalSince1970 - startTime
        updateTimeLabel(elapsedTime)
    }
    
    
}