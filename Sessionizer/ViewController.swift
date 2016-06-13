import UIKit

class ViewController: UIViewController {

    @IBOutlet var sessionsTableView : UITableView!
    let callReuseIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sessionsTableView.registerClass(UITableViewCell.self,
                                             forCellReuseIdentifier: callReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func newSession() {
        print("OOK");
    }
}


extension ViewController : UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", 
                                                               forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "Spork \(indexPath.row)"
        
        return cell
    }

}