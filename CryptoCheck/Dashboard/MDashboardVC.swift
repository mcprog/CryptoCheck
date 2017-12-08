//
//  MDashboardVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/1/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
import Charts
class MDashboardVC: TabBarChildVC {
    
    @IBOutlet weak var amtLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var rHashLabel: UILabel!
    @IBOutlet weak var cHashLabel: UILabel!
    @IBOutlet weak var aHashLabel: UILabel!
    @IBOutlet weak var blackView: UIImageView!
    
    @IBOutlet weak var chartView: LineChartView!
    var cnt = 0
    
    let purp = UIColor(displayP3Red: 174 / 255.0, green: 113 / 255.0, blue: 230.0 / 255.0, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateGraph()
        
    }
    
    func updateGraph() {
        
        
        
        
        let line1 = LineChartDataSet(values: getReportedCoords(histories: getHistories()), label: "reported")
        
        let line2 = LineChartDataSet(values: getAverageCoords(histories: getHistories()), label: "average")
        
        let line3 = LineChartDataSet(values: getCurrentCoords(histories: getHistories()), label: "current")
        
        line1.colors = [.red]
        line1.drawCirclesEnabled = false
        line2.colors = [.green]
        line2.drawCirclesEnabled = false
        line3.colors = [.blue]
        line3.drawCirclesEnabled = false
        
        
        let dataObj = LineChartData(dataSets: [line1, line2, line3])
        
        
        chartView.data = dataObj
        chartView.rightAxis.enabled = false
        chartView.xAxis.enabled = false
        
        
        chartView.notifyDataSetChanged()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        
        
        
        /*let yValues = MDashboardVC.getReportedCoords(histories: getHistories(), formatter: displayFormatter)
        print("yVales")
        print(yValues)
        //let yValues2 = MDashboardVC.getReportedCoords(histories: getHistories(), formatter: displayFormatter)
        let xValues = MDashboardVC.getDateCoords(histories: getHistories(), formatter: displayFormatter)
        print("xVales")
        print(xValues)*/
        
        
        
        
        update()
    }
    
    /*static func getChartPoints(xs: [ChartAxisValue], ys: [ChartAxisValue]) -> [ChartPoint] {
        var i = 0
        var array = [ChartPoint]()
        for x in xs {
            /*if (i > 5) {
                break
            }*/
            array.append(ChartPoint(x: x, y: ys[i]))
            i += 1
        }
        return array
    }
    */
    func getReportedCoords(histories: [HistoryModel]) -> [ChartDataEntry] {
        var array = [ChartDataEntry]()
        var i = 0
        for h in histories {
            /*if (i > 5){
                break
            }*/
            array.append(ChartDataEntry(x: h.date.timeIntervalSince1970, y: h.reported))
            i += 1
        }
        return array
    }
    
    func getAverageCoords(histories: [HistoryModel]) -> [ChartDataEntry] {
        var array = [ChartDataEntry]()
        
        for h in histories {
            /*if (i > 5){
             break
             }*/
            array.append(ChartDataEntry(x: h.date.timeIntervalSince1970, y: h.average))
            
        }
        return array
    }
    
    func getCurrentCoords(histories: [HistoryModel]) -> [ChartDataEntry] {
        var array = [ChartDataEntry]()
        
        for h in histories {
            /*if (i > 5){
             break
             }*/
            array.append(ChartDataEntry(x: h.date.timeIntervalSince1970, y: h.current))
            
        }
        return array
    }
    
    /*static func getReportedCoords(histories: [HistoryModel], formatter: DateFormatter) -> [ChartAxisValueDouble] {
        var array = [ChartAxisValueDouble]()
        var i = 0
        for h in histories {
            /*if i > 5 {
                break
            }*/
            array.append(ChartAxisValueDouble(Utility.toMH(hash: h.reported)))
            i += 1
        }
        return array
    }
    
    static func getCurrentCoords(histories: [HistoryModel], formatter: DateFormatter) -> [ChartAxisValueDouble] {
        var array = [ChartAxisValueDouble]()
        var i = 0
        for h in histories {
            /*if i > 5 {
                break
            }*/
            array.append(ChartAxisValueDouble(Utility.toMH(hash: h.current)))
            i += 1
        }
        return array
    }*/
    
    func update() {
        setClock()
        setHashrate()
    }
    
    private func setHashrate() {
        let mine = getMine()
        let rMH = String(format: "%.1f", Utility.toMH(hash: mine.reported!))
        let aMH = String(format: "%.1f", Utility.toMH(hash: mine.average!))
        let cMH = String(format: "%.1f", Utility.toMH(hash: mine.current!))
        rHashLabel.text = "\(rMH) MH/s"
        aHashLabel.text = "\(aMH) MH/s"
        cHashLabel.text = "\(cMH) MH/s"
    }
    
    private func setClock() {
        cnt += 1
        print("settung clock \(cnt)")
        let now = Date()
        var mostRecent: Date?
        for w in getMine().workers! {
            if let date = w.lastSeen {
                if (mostRecent == nil) {
                    mostRecent = date
                }
                else if (mostRecent! < date) {
                    mostRecent = date
                }
            }
        }
        let seconds = now.timeIntervalSince(mostRecent!)
        if (seconds < 60) {
            amtLabel.text = "\(Int(seconds))"
            unitsLabel.text = "secs ago"
        }
        else if (seconds < 3600) {
            amtLabel.text = "\(Int(seconds / 60))"
            unitsLabel.text = "mins ago"
        }
        else if (seconds < 86400) {
            amtLabel.text = "\(Int(seconds / 3600))"
            unitsLabel.text = "hrs ago"
        } else {
            amtLabel.text = "\(Int(seconds / 86400))"
            unitsLabel.text = "days ago"
        }
        
    }
    
    
    
    @IBAction func unwindFromWorkers(segue: UIStoryboardSegue) {
        
    }
    
    
    
   
    
}
