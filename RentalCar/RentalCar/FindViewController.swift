//
//  FindViewController.swift
//  RentalCar
//
//  Created by Ysée Monnier on 23/03/16.
//  Copyright © 2016 MONNIER Ysee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import EPCalendarPicker

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate: Comparable {
    func addDays(days:Int) -> NSDate{
        let newDate = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: days,
            toDate: self,
            options: NSCalendarOptions(rawValue: 0))
        
        return newDate!
    }
}

class FindViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, EPCalendarPickerDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    //Segue
    var cars: [Car] = []
    
    //Dates
    var fromCalendarPicker: EPCalendarPicker!
    var toCalendarPicker: EPCalendarPicker!
    @IBOutlet weak var dateFromView: UIView!
    @IBOutlet weak var dateToView: UIView!
    var dateFrom: NSDate = NSDate()
    var dateTo: NSDate = NSDate()
    var dateFromString: String = ""
    var dateToString: String = ""
    @IBOutlet weak var toLabel: UILabel!
    
    //PickerView
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var place: UITextField!
    let citiesPickerView = UIPickerView()
    let placesPickerView = UIPickerView()
    
    //Data
    var activeTextField:UITextField?
    var cities: [String] = []
    var places: [(Int,String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        
        //Texfield
        self.city.delegate = self
        self.place.delegate = self
        
        //UIPickerView
        self.initCitiesPickerView()
        self.initPlacesPickerView()
        
        //UIDatePicker
        self.dateFromView.layer.borderColor = UIColor.grayColor().CGColor
        self.dateFromView.layer.borderWidth = 1
        self.dateFromView.layer.cornerRadius = 5
        self.dateToView.layer.borderColor = UIColor.grayColor().CGColor
        self.dateToView.layer.borderWidth = 1
        self.dateToView.layer.cornerRadius = 5
        self.toLabel.layer.cornerRadius = 20
        self.toLabel.layer.borderColor = UIColor.blackColor().CGColor
        self.toLabel.layer.borderWidth = 1
        self.toLabel.layer.backgroundColor = Util.UIColorFromHex(0x5289B2).CGColor
        
        //DatePicker
        let handlerDateFrom = UITapGestureRecognizer(target: self, action: #selector(FindViewController.dateFromGesture(_:)))
        let handlerDateTo = UITapGestureRecognizer(target: self, action: #selector(FindViewController.dateToGesture(_:)))
        self.dateFromView.addGestureRecognizer(handlerDateFrom)
        self.dateToView.addGestureRecognizer(handlerDateTo)
        
        //Menu view
        if revealViewController() != nil {
            menu.target = revealViewController()
            menu.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.navigationController!.navigationBar.barTintColor = Util.UIColorFromHex(0x4E83AA)
        
        print("TEST DATE ::::: \(self.dateFrom)")
    }
    
    override func viewDidAppear(animated: Bool) {
        var subviews = self.dateFromView.subviews.flatMap { $0 as? UILabel }
        print(subviews)
        subviews[0].text = self.extractDay(self.dateFrom)
        subviews[1].text = self.formatteDate(self.dateFrom)
        
        subviews = self.dateToView.subviews.flatMap { $0 as? UILabel }
        subviews[0].text = self.extractDay(self.dateTo)
        subviews[1].text = self.formatteDate(self.dateTo)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Keyboard
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        /*if textField == self.inputEmail {
         self.inputPassword.becomeFirstResponder()
         } else if textField == self.inputPassword {
         self.signIn(self)
         }*/
        return true
    }
    
    //MARK: Textfield
    
    func textFieldDidBeginEditing(textField: UITextField) { // became first responder
        self.activeTextField = textField
    }
    
    //MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("SEGUE")
        if segue.identifier == "ResultSegue" {
            print("SEGUE11\n\(segue.destinationViewController)")
            let destinationVC = segue.destinationViewController as! ResultViewController
            destinationVC.cars = self.cars
        }
    }
    
    //MARK: UICalendarPicker
    func dateFromGesture(sender: UITapGestureRecognizer) {
        self.fromCalendarPicker = EPCalendarPicker(startYear: 2015, endYear: 2017, multiSelection: false, selectedDates: [])
        self.fromCalendarPicker.calendarDelegate = self
        self.fromCalendarPicker.startDate = self.dateFrom
        self.fromCalendarPicker.hightlightsToday = true
        self.fromCalendarPicker.barTintColor = Util.UIColorFromHex(0x5289B2)
        self.fromCalendarPicker.dateSelectionColor = Util.UIColorFromHex(0x5289B2)
        self.fromCalendarPicker.todayTintColor = Util.UIColorFromHex(0x5289B2)
        self.fromCalendarPicker.monthTitleColor = UIColor.blackColor()
        self.fromCalendarPicker.weekdayTintColor = Util.UIColorFromHex(0x5289B2)
        let navigationController = UINavigationController(rootViewController: self.fromCalendarPicker)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func dateToGesture(sender: UITapGestureRecognizer) {
        self.toCalendarPicker = EPCalendarPicker(startYear: 2016, endYear: 2017, multiSelection: false, selectedDates: [])
        self.toCalendarPicker.calendarDelegate = self
        self.toCalendarPicker.startDate = self.dateFrom
        self.toCalendarPicker.hightlightsToday = true
        self.toCalendarPicker.barTintColor = Util.UIColorFromHex(0x5289B2)
        self.toCalendarPicker.dateSelectionColor = Util.UIColorFromHex(0x5289B2)
        self.toCalendarPicker.todayTintColor = Util.UIColorFromHex(0x5289B2)
        self.toCalendarPicker.monthTitleColor = UIColor.blackColor()
        self.toCalendarPicker.weekdayTintColor = Util.UIColorFromHex(0x5289B2)
        let navigationController = UINavigationController(rootViewController: self.toCalendarPicker)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    //MARK: UICalendarPicker Delegate
    func epCalendarPicker(calendar: EPCalendarPicker, didCancel error : NSError) {
        print("User cancelled selection")
        
    }
    func epCalendarPicker(calendar: EPCalendarPicker, didSelectDate date : NSDate) {
        switch calendar {
        case self.fromCalendarPicker:
            print(self.dateFromView.subviews.flatMap{ $0 as? UILabel})
            let subviews = self.dateFromView.subviews.flatMap { $0 as? UILabel }
            subviews[0].text = self.extractDay(date)
            subviews[1].text = self.formatteDate(date)
            self.dateFrom = date
            
            if self.dateTo <= self.dateFrom {
                self.dateTo = self.dateFrom.addDays(2)
                let subviews = self.dateToView.subviews.flatMap { $0 as? UILabel }
                subviews[0].text = self.extractDay(self.dateTo)
                subviews[1].text = self.formatteDate(self.dateTo)
            }
            break
        case self.toCalendarPicker:
            let subviews = self.dateToView.subviews.flatMap { $0 as? UILabel }
            subviews[0].text = self.extractDay(date)
            subviews[1].text = self.formatteDate(date)
            self.dateTo = date
            break
        default:
            break
        }
    }
    
    func epCalendarPicker(calendar: EPCalendarPicker, didSelectMultipleDate dates : [NSDate]) {
        print("User selected dates: \n\(dates)")
        switch calendar {
        case self.fromCalendarPicker: break
        case self.toCalendarPicker: break
        default:
            break
        }
    }
    
    
    //MARK: UIPickerView
    
    private func initCitiesPickerView() {
        self.citiesPickerView.backgroundColor = Util.UIColorFromHex(0xFFFFFF)

        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
        var items = [UIBarButtonItem]()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(FindViewController.donePressed))
        
        items.append(spaceButton)
        items.append(spaceButton)
        items.append(doneButton)
        toolbar.barStyle = UIBarStyle.Black
        toolbar.barTintColor = Util.UIColorFromHex(0x4E83AA)
        toolbar.setItems(items, animated: true)
        toolbar.userInteractionEnabled = true
        
        self.citiesPickerView.delegate = self
        self.citiesPickerView.dataSource = self
        self.citiesPickerView.frame = CGRectMake(0, 0, 500, 250)
        self.city.inputAccessoryView = toolbar
        self.city.inputView = self.citiesPickerView
    }
    
    private func initPlacesPickerView() {
        self.placesPickerView.backgroundColor = Util.UIColorFromHex(0xFFFFFF)
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
        var items = [UIBarButtonItem]()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(FindViewController.donePressed))
        
        items.append(spaceButton)
        items.append(spaceButton)
        items.append(doneButton)
        toolbar.barStyle = UIBarStyle.Black
        toolbar.barTintColor = Util.UIColorFromHex(0x4E83AA)
        toolbar.setItems(items, animated: true)
        toolbar.userInteractionEnabled = true
        
        self.placesPickerView.delegate = self
        self.placesPickerView.dataSource = self
        self.placesPickerView.frame = CGRectMake(0, 0, 500, 250)
        self.place.inputAccessoryView = toolbar
        self.place.inputView = self.placesPickerView
    }
    
    func donePressed() {
        print("TEST DONEPRESED")
        self.activeTextField?.resignFirstResponder()
    }
    
    //MARK: UIPickerView delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case self.citiesPickerView:
            return self.cities.count
        case self.placesPickerView:
            return self.places.count
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case self.citiesPickerView:
            return self.cities[row]
        case self.placesPickerView:
            return self.places[row].1
        default:
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        autoreleasepool {
            
            if Util.isConnectedToNetwork() {
                switch pickerView {
                case self.citiesPickerView:
                    let pvc: ProgressViewController = ProgressViewController()
                    pvc.setLabelActivity("Fetching places...")
                    pvc.showActivityIndicator(self.view)
                    self.city.text = self.cities[row]
                    print("pick this... " + self.cities[row])
                    self.places.removeAll()
                    request(.GET, Global.APP_URL + "/findPlaces/" + self.cities[row]).responseJSON(completionHandler: { (response) in
                        print(response)
                        pvc.hideActivityIndicator()
                        if response.response?.statusCode == 200 {
                            self.places.removeAll()
                            let json: JSON = JSON(response.result.value!)
                            let data = json["data"].dictionaryValue
                            print(data)
                            self.places.append((-1,""))
                            for (id, place) in data {
                                print(place)
                                self.places.append((Int(id)!,place.stringValue))
                                //self.places.append(place.string!)
                            }
                            pvc.hideActivityIndicator()
                            print(self.places)
                        }
                    })
                case self.placesPickerView:
                    self.place.text = self.places[row].1
                default:
                    return
                }
            } else {
                Util.alert(self, title: "Internet Network", message: "Please turn on your 3G or WIFI")
            }
        }
    }
    
    //MARK: SEARCH
    
    @IBAction func searchAction(sender: AnyObject) {
        autoreleasepool {
            if self.city.text != "" && self.place.text  != "" {
                if Util.isConnectedToNetwork() {
                    if let idPlace = self.places.indexOf({$0.1 == self.place.text!}) {
                        //let id = self.places[found]
                        print("SEARCH...\n\(self.formatteDateParams(self.dateFrom))\n\(self.formatteDateParams(self.dateTo))\n\(self.city.text!)\n\(self.places[idPlace].0)")
                        let pvc: ProgressViewController = ProgressViewController()
                        pvc.showActivityIndicator(self.view)
                        pvc.setLabelActivity("Searching...")
                        request(.GET, Global.APP_URL + "/find", parameters: [
                            "start" : self.formatteDateParams(self.dateFrom),
                            "end": self.formatteDateParams(self.dateTo),
                            "city": self.city.text!,
                            "place": self.places[idPlace].0
                            ], headers: ["X-CSRF-TOKEN": Global.token]).responseJSON(completionHandler: { (response) in
                                pvc.hideActivityIndicator()
                                print(response)
                                if response.response?.statusCode == 200 {
                                    self.cars = []
                                    let json: JSON = JSON(response.result.value!)
                                    print("JSON :: \n\(json)")
                                    if (json["data"].array!).isEmpty {
                                        Util.alert(self, title: "Search for a car", message: "Sorry, there are no cars for this places...")
                                        return 
                                    }
                                    for car in json["data"].array! {
                                        print("CAR :: \(car)")
                                        let id: Int = car["id"].int!
                                        let model: String = car["model"].string!
                                        let type: String = car["type"].string!
                                        let sits: Int = Int(car["sits"].string!)!
                                        let fuel: String = car["fuel"].string!
                                        let color: String = car["color"].string!
                                        let description: String = car["description"].string!
                                        let price: Double = Double(car["rental_price"].string!)!
                                        let picture: String = car["picture"].string!
                                        let location_id: Int = Int(car["location_id"].string!)!
                                        self.cars.append(Car(id: id, model: model, type: type, description: description, color: color, fuel: fuel, sits: sits, price: price, picture: picture, loc_id: location_id))
                                    }
                                    self.performSegueWithIdentifier("ResultSegue", sender: self)
                                } else {
                                    Util.alert(self, title: "Search", message: response.result.error!.debugDescription)
                                }
                            })
                    }
                } else {
                    Util.alert(self, title: "Internet Network", message: "Please turn on your 3G or WIFI")
                }
            } else {
                Util.alert(self,title: "Search for a car", message: "Please put all information")
            }
            
        }
    }
    
    //MARK: Menu
    
    @IBAction func menuAction(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userMenuViewController: UserPopoverViewController = storyboard.instantiateViewControllerWithIdentifier("UserPopover") as! UserPopoverViewController
        
        userMenuViewController.modalPresentationStyle = .Popover
        
        let popoverMenuViewController = userMenuViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.barButtonItem = sender as! UIBarButtonItem
        
        self.presentViewController(userMenuViewController, animated: true, completion: nil)
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle{
        return .None
    }
    
    //MARK: NSDate util
    
    private func extractDay(date: NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: date)
        print("extraction day... \(String(components.day))")
        return String(components.day)
    }
    
    private func formatteDateParams(date: NSDate) -> String {
        let formatter = NSDateFormatter();
        formatter.dateFormat = "dd/MM/yyyy";
        formatter.timeZone = NSTimeZone.localTimeZone()
        return formatter.stringFromDate(date);
    }
    
    private func formatteDate(date: NSDate) -> String {
        let formatter = NSDateFormatter();
        formatter.dateFormat = "E | MMMM";
        formatter.timeZone = NSTimeZone.localTimeZone()
        print("ormaatege date... \(formatter.stringFromDate(date))")
        return formatter.stringFromDate(date);
    }
    
    //MARK: Util
    private func loadData() {
        let pvc: ProgressViewController = ProgressViewController()
        pvc.setLabelActivity("Downloading...")
        pvc.showActivityIndicator(self.view)
        if Util.isConnectedToNetwork() {
            request(.GET, Global.APP_URL + "/findCities").responseJSON { (response) in
                self.cities = []
                print(response.result.value)
                let json: JSON = JSON(response.result.value!)
                let data = json["data"].array
                print(data)
                self.cities.append("")
                for city in data! {
                    print(city)
                    self.cities.append(city.string!)
                }
                pvc.hideActivityIndicator()
                print(self.cities)
            }
        } else {
            pvc.hideActivityIndicator()
            Util.alert(self, title: "Internet Network", message: "Please turn on your 3G or WIFI")
        }
    }
}