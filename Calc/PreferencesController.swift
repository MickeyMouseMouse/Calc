import Cocoa

class PreferencesController: NSViewController {
    @IBOutlet weak var onOffDarkMode: NSSwitch!

    override func viewDidAppear() {
        let appearance: String
        
        // get current appearance
        switch NSApp.appearance {
        case NSAppearance(named: .darkAqua):
            appearance = "Dark"
        case NSAppearance(named: .aqua):
            appearance = "Light"
        case _:
            appearance = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") ?? "Light"
        }
        
        if appearance == "Light" {
            onOffDarkMode.state = .off
        } else {
            onOffDarkMode.state = .on
        }
    }
 
    // change app appearance (light <=> dark)
    @IBAction func toggle(_ sender: Any) {
        if onOffDarkMode.state == .on {
            NSApp.appearance = NSAppearance(named: .darkAqua)
        } else {
            NSApp.appearance = NSAppearance(named: .aqua)
        }
    }
}
