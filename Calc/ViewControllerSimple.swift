import Cocoa

class ViewControllerSimple: NSViewController {
    @IBOutlet weak var button0: NSButton!
    @IBOutlet weak var button1: NSButton!
    @IBOutlet weak var button2: NSButton!
    @IBOutlet weak var button3: NSButton!
    @IBOutlet weak var button4: NSButton!
    @IBOutlet weak var button5: NSButton!
    @IBOutlet weak var button6: NSButton!
    @IBOutlet weak var button7: NSButton!
    @IBOutlet weak var button8: NSButton!
    @IBOutlet weak var button9: NSButton!
    @IBOutlet weak var buttonComma: NSButton!
    @IBOutlet weak var buttonEquals: NSButton!
    @IBOutlet weak var buttonPlus: NSButton!
    @IBOutlet weak var buttonMinus: NSButton!
    @IBOutlet weak var buttonMultiply: NSButton!
    @IBOutlet weak var buttonDivide: NSButton!
    @IBOutlet weak var buttonBackSpace: NSButton!
    @IBOutlet weak var buttonClear: NSButton!
    @IBOutlet weak var field: NSTextField!
    
    var result: Double?
    var sign: Int8? = nil // 0 = +, 1 = -, 2 = *, 3 = /
    var newOperand = false
    var counted = true
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set listener for keys
        NSEvent.addLocalMonitorForEvents(matching: .keyUp) {
            if self.keyUp(with: $0) { return nil } else { return $0 }
        }
    }
    */

    func addDigit(_ digit: String) {
        if counted && !newOperand {
            result = nil
            sign = nil
            field.stringValue = ""
            counted = false
        }
        
        if field.stringValue == "0" || field.stringValue == "Error" || newOperand {
            field.stringValue = ""
            counted = false
            newOperand = false
        }
        
        field.stringValue += digit
    }
    
    @IBAction func pushButton0(_ sender: Any) {
        addDigit("0")
    }
    
    @IBAction func pushButton1(_ sender: Any) {
        addDigit("1")
    }
    
    @IBAction func pushButton2(_ sender: Any) {
        addDigit("2")
    }
    
    @IBAction func pushButton3(_ sender: Any) {
        addDigit("3")
    }
    
    @IBAction func pushButton4(_ sender: Any) {
        addDigit("4")
    }
    
    @IBAction func pushButton5(_ sender: Any) {
        addDigit("5")
    }
    
    @IBAction func pushButton6(_ sender: Any) {
        addDigit("6")
    }
    
    @IBAction func pushButton7(_ sender: Any) {
        addDigit("7")
    }
    
    @IBAction func pushButton8(_ sender: Any) {
        addDigit("8")
    }
    
    @IBAction func pushButton9(_ sender: Any) {
        addDigit("9")
    }
    
    @IBAction func pushComma(_ sender: Any) {
        if newOperand { field.stringValue = "" }
        
        field.stringValue += "."
        counted = false
    }
    
    @IBAction func pushPlus(_ sender: Any) {
        if !counted { calculate() }
        sign = 0
        newOperand = true
    }
    
    @IBAction func pushMinus(_ sender: Any) {
        if !counted { calculate() }
        sign = 1
        newOperand = true
    }
    
    @IBAction func pushMultiply(_ sender: Any) {
        if !counted { calculate() }
        sign = 2
        newOperand = true
    }
    
    @IBAction func pushDivide(_ sender: Any) {
        if !counted { calculate() }
        sign = 3
        newOperand = true
    }
    
    @IBAction func backspace(_ sender: Any) {
        if counted {
            result = nil
            sign = nil
            counted = false
        }
        
        if (field.stringValue.count == 1 || field.stringValue == "Error") {
            field.stringValue = "0"
        } else {
            field.stringValue = String(field.stringValue.prefix(field.stringValue.count - 1))
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        field.stringValue = "0"
        result = nil
        sign = nil
        newOperand = false
        counted = false
    }
    
    @IBAction func pushEquals(_ sender: Any) {
        calculate()
    }
    
    /*
    func keyUp(with event: NSEvent) -> Bool {
        guard let locWindow = self.view.window,
            NSApplication.shared.keyWindow === locWindow else { return false }
        
        switch event.characters {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            addDigit(event.characters!)
        case "+":
            pushPlus(buttonPlus!)
        case "-":
            pushMinus(buttonMinus!)
        case "*":
            pushMultiply(buttonMultiply!)
        case "/":
            pushDivide(buttonDivide!)
        case ",", ".":
            pushComma(buttonComma!)
        case "\r": // enter
            calculate()
        case "\u{7F}": // back space
            backspace(buttonBackSpace!)
        case _:
            return false
        }
        
        return true
    }
    */
    
    func calculate() {
        if (result == nil) {
            result = Double(field.stringValue)
            if result == nil { error() }
            return
        }
        
        if sign == nil || newOperand  { return }
        
        let operand = Double(field.stringValue)
        if operand == nil {
            error()
            return
        }
        
        switch sign {
        case 0:
            result! += operand!
        case 1:
            result! -= operand!
        case 2:
            result! *= operand!
        case _:
            if operand != 0.0 {
                result! /= operand!
            } else {
                error()
                return
            }
        }
    
        counted = true
        sign = nil
        field.stringValue = doubleOrInt(result!)
    }
    
    func doubleOrInt(_ number: Double) -> String {
        let range = -0.00001...0.00001
        if range.contains(number - Double(Int(number))) {
            return String(Int(number))
        } else {
            return String(number)
        }
    }
    
    func error() {
        field.stringValue = "Error"
        result = nil
        sign = nil
        newOperand = false
        counted = false
    }
}
