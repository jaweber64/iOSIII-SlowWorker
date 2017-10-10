//
//  ViewController.swift
//  SlowWorker
//
//  Created by Janet Weber on 10/6/17.
//  Copyright © 2017 Weber Software Solutions. All rights reserved.
//
//  This project is from Chapter 15 of the book "Beginning iPhone Development with Swift -
//  Exploring the iOS SDK".  Grand Central Dispatch, Background Processing and You.

//  This project simulates some different tasks that all really just sleep for a specified
//  amount of time and then return something.  If they are all run sequentially, it takes
//  about 10 seconds, but if they are run at the same time, it takes only 7 seconds.
//
//  Also implemented are aesthetics for the user (i.e. button cannot be pressed again
//  until all tasks are complete and spinner indicates work is being done).

import UIKit

class ViewController: UIViewController {
    @IBOutlet var startButton: UIButton!
    @IBOutlet var resultstTextView: UITextView!
    @IBOutlet var spinner : UIActivityIndicatorView!
    
    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 1)
        return "HI there"
    }
    
    func processData(data: String)  -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    func calculateFirstResult(data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        return "Number of chars: \(data.count)"
    }
    
    func calculateSecondResult(data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }
    
    @IBAction func doWork(sender: AnyObject) {
        let startTime = NSDate()
        self.resultstTextView.text = ""
        startButton.isEnabled = false
        spinner.startAnimating()    
        let queue = DispatchQueue.global(qos: .default)
        queue.async() {
            let fetchedData = self.fetchSomethingFromServer()
            let processedData = self.processData(data: fetchedData)
            //let firstResult = self.calculateFirstResult(data: processedData)
            //let secondResult = self.calculateSecondResult(data: processedData)
            var firstResult: String!
            var secondResult: String!
            let group = DispatchGroup()
            
            queue.async(group: group) {
                firstResult = self.calculateFirstResult(data: processedData)
            }
            
            queue.async(group: group) {
                secondResult = self.calculateSecondResult(data: processedData)
            }
            
            group.notify(queue: queue) {
                let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
                DispatchQueue.main.async() {
                    self.resultstTextView.text = resultsSummary
                    self.startButton.isEnabled = true
                    self.spinner.stopAnimating()
                }
                let endTime = NSDate()
                print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds\n")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

