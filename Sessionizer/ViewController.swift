import UIKit

class ViewController: UIViewController {

    @IBOutlet var sessionsTableView : UITableView!
    let callReuseIdentifier = "Cell"
    
    var filenames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sessionsTableView.registerClass(UITableViewCell.self,
                                             forCellReuseIdentifier: callReuseIdentifier)
    }
    
    func reloadFiles() {
        let fm = NSFileManager.defaultManager()

        let documentDirectory = try! fm.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        
        filenames = try! fm.contentsOfDirectoryAtURL(documentDirectory, includingPropertiesForKeys: nil, options: []).map { $0.lastPathComponent! }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadFiles()
        self.sessionsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension ViewController : UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filenames.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", 
                                                               forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "\(filenames[indexPath.row])"
        
        return cell
    }

}