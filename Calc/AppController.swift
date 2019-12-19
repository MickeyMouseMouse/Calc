import Cocoa

class AppController: NSObject {
    @IBOutlet weak var menuGitHub: NSMenuItem!
    @IBOutlet weak var menuPreferences: NSMenuItem!
    @IBOutlet weak var menuSimple: NSMenuItem!
    @IBOutlet weak var menuPro: NSMenuItem!
    
    var mode = true // true = simple mode, false = pro mode
    
    @IBAction func openGitHub(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/MickeyMouseMouse/Calc")!)
    }
    
    @IBAction func simpleMode(_ sender: Any) {
        if mode { return } else { mode = !mode }
        
        NSApplication.shared.mainWindow?.close() // close current window
        
        // open new window with Simple mode
        let controller = NSStoryboard(name: "Main", bundle: nil)
            .instantiateController(withIdentifier: "Simple") as! NSViewController
        
        let myWindow = NSWindow(contentViewController: controller)
        myWindow.styleMask.remove(.resizable)
        NSApp.activate(ignoringOtherApps: true)
        myWindow.makeKeyAndOrderFront(self)
        NSWindowController(window: myWindow).showWindow(self)
    }
    
    @IBAction func proMode(_ sender: Any) {
        if !mode { return } else { mode = !mode }
        
        NSApplication.shared.mainWindow?.close() // close current window
        
        // open new window with Pro mode
        let controller = NSStoryboard(name: "Main", bundle: nil)
            .instantiateController(withIdentifier: "Pro") as! NSViewController
        
        let myWindow = NSWindow(contentViewController: controller)
        myWindow.styleMask.remove(.resizable)
        NSApp.activate(ignoringOtherApps: true)
        myWindow.makeKeyAndOrderFront(self)
        NSWindowController(window: myWindow).showWindow(self)
    }
}
