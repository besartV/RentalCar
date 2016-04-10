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

class FindViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, EPCalendarPickerDelegate {
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
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
    
    var cities: [String] = []
    var places: [(Int,String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
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
    
    //MARK: UICalendarPicker
    func dateFromGesture(sender: UITapGestureRecognizer) {
        self.fromCalendarPicker = EPCalendarPicker(startYear: 2016, endYear: 2017, multiSelection: false, selectedDates: [])
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
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: Selector(self.donePressed()))
        
        items.append(spaceButton)
        items.append(spaceButton)
        items.append(doneButton)
        toolbar.barStyle = UIBarStyle.Black
        toolbar.barTintColor = Util.UIColorFromHex(0x4E83AA)
        toolbar.setItems(items, animated: true)
        
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
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: Selector(self.donePressed()))
        
        items.append(spaceButton)
        items.append(spaceButton)
        items.append(doneButton)
        toolbar.barStyle = UIBarStyle.Black
        toolbar.barTintColor = Util.UIColorFromHex(0x4E83AA)
        toolbar.setItems(items, animated: true)
        
        self.placesPickerView.delegate = self
        self.placesPickerView.dataSource = self
        self.placesPickerView.frame = CGRectMake(0, 0, 500, 250)
        self.place.inputAccessoryView = toolbar
        self.place.inputView = self.placesPickerView
    }
    
    func donePressed() {
        print("TEST DONEPRESED")
        self.city.resignFirstResponder()
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
        switch pickerView {
        case self.citiesPickerView:
            self.city.text = self.cities[row]
            print("pick this... " + self.cities[row])
            self.places.removeAll()
            request(.GET, Global.APP_URL + "/findPlaces/" + self.cities[row]).responseJSON(completionHandler: { (response) in
                print(response)
                let json: JSON = JSON(response.result.value!)
                let data = json["data"].dictionaryValue
                print(data)
                for (id, place) in data {
                    print(place)
                    self.places.append((Int(id)!,place.stringValue))
                    //self.places.append(place.string!)
                }
                print(self.places)
            })
        case self.placesPickerView:
            self.place.text = self.places[row].1
        default:
            return
        }
    }
    
    //MARK: SEARCH
    
    @IBAction func searchAction(sender: AnyObject) {
        if self.city.text != "" && self.place.text  != "" {
            if let idPlace = self.places.indexOf({$0.1 == self.place.text!}) {
                //let id = self.places[found]
                print("SEARCH...\n\(self.formatteDateParams(self.dateFrom))\n\(self.formatteDateParams(self.dateTo))\n\(self.city.text!)\n\(idPlace)")
                request(.GET, Global.APP_URL + "/find", parameters: [
                    "start" : self.formatteDateParams(self.dateFrom),
                    "end": self.formatteDateParams(self.dateTo),
                    "city": self.city.text!,
                    "place": idPlace
                    ], headers: ["X-CSRF-TOKEN": Global.token]).responseJSON(completionHandler: { (response) in
                        //Todo....
                        print(response)
                    })
            }
        } else {
            Util.alert(self,title: "Login Failed!", message: "Please put all information")
        }
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
    
    //Mark: Util
    private func loadData() {
        request(.GET, Global.APP_URL + "/findCities").responseJSON { (response) in
            print(response.result.value)
            let json: JSON = JSON(response.result.value!)
            let data = json["data"].array
            print(data)
            for city in data! {
                print(city)
                self.cities.append(city.string!)
            }
            print(self.cities)
        }
    }
}