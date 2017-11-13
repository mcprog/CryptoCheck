//
//  MDashboardVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/1/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
import SwiftCharts
class MDashboardVC: TabBarChildVC {
    
    @IBOutlet weak var amtLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var rHashLabel: UILabel!
    @IBOutlet weak var cHashLabel: UILabel!
    @IBOutlet weak var aHashLabel: UILabel!
    @IBOutlet weak var blackView: UIImageView!
    
    var cnt = 0
    
    fileprivate var chart: Chart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let labelSettings = ChartLabelSettings(font: UIFont.boldSystemFont(ofSize: 13), fontColor: .red, rotation: 0, rotationKeep: ChartLabelDrawerRotationKeep.center, shiftXOnRotation: false, textAlignment: .left)
        let labelSettings2 = ChartLabelSettings(font: UIFont.boldSystemFont(ofSize: 13), fontColor: .blue, rotation: 0, rotationKeep: ChartLabelDrawerRotationKeep.center, shiftXOnRotation: false, textAlignment: .left)
        
        var displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd.MM.yy"
        
        
        let yValues = MDashboardVC.getReportedCoords(histories: getHistories(), formatter: displayFormatter)
        let yValues2 = MDashboardVC.getReportedCoords(histories: getHistories(), formatter: displayFormatter)
        let xValues = MDashboardVC.getDateCoords(histories: getHistories(), formatter: displayFormatter)
        
        
        
        let chartPoints = MDashboardVC.getChartPoints(xs: xValues, ys: yValues)
        let chartPoints2 = MDashboardVC.getChartPoints(xs: xValues, ys: yValues2)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
        let yModel2 = ChartAxisModel(axisValues: yValues2, axisTitleLabel: ChartAxisLabel(text: "Axis title current", settings: labelSettings2.defaultVertical()))
        let y = blackView.bounds.minY + blackView.bounds.maxY + 25
        let chartFrame = CGRect(x: 0, y: 375, width: view.bounds.size.width - 20, height: view.bounds.size.height - 450)
        
        var chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 20
        chartSettings.spacingBetweenAxesY = 20
        chartSettings.labelsSpacing = 10
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let coordsSpace2 = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel2)
        let (xAxisLayer2, yAxisLayer2, innerFrame2) = (coordsSpace2.xAxisLayer, coordsSpace2.yAxisLayer, coordsSpace2.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: .red, animDuration: 1, animDelay: 0)
        let lineModel2 = ChartLineModel(chartPoints: chartPoints, lineColor: .blue, animDuration: 1, animDelay: 10)

        let chartPointLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel], delayInit: true)
        let chartPointLineLayer2 = ChartPointsLineLayer(xAxis: xAxisLayer2.axis, yAxis: yAxisLayer2.axis, lineModels: [lineModel2], delayInit: true)
        
        let guidelinesLayerSettings = ChartGuideLinesLayerSettings(linesColor: .black, linesWidth: 0.3)
        let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: guidelinesLayerSettings)
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                xAxisLayer2,
                yAxisLayer2,
                chartPointLineLayer,
                chartPointLineLayer2
            ]
        )
        
        view.addSubview(chart.view)
        chartPointLineLayer.initScreenLines(chart)
        chartPointLineLayer2.initScreenLines(chart)
        self.chart = chart
        update()
    }
    
    static func getChartPoints(xs: [ChartAxisValue], ys: [ChartAxisValue]) -> [ChartPoint] {
        var i = 0
        var array = [ChartPoint]()
        for x in xs {
            if (i > 5) {
                break
            }
            array.append(ChartPoint(x: x, y: ys[i]))
            i += 1
        }
        return array
    }
    
    static func getDateCoords(histories: [HistoryModel], formatter: DateFormatter) -> [ChartAxisValueDate] {
        var array = [ChartAxisValueDate]()
        var i = 0
        for h in histories {
            if (i > 5){
                break
            }
            array.append(ChartAxisValueDate(date: h.date, formatter: formatter))
            i += 1
        }
        return array
    }
    
    static func getReportedCoords(histories: [HistoryModel], formatter: DateFormatter) -> [ChartAxisValueDouble] {
        var array = [ChartAxisValueDouble]()
        var i = 0
        for h in histories {
            if i > 5 {
                break
            }
            array.append(ChartAxisValueDouble(Utility.toMH(hash: h.reported)))
            i += 1
        }
        return array
    }
    
    static func getCurrentCoords(histories: [HistoryModel], formatter: DateFormatter) -> [ChartAxisValueDouble] {
        var array = [ChartAxisValueDouble]()
        var i = 0
        for h in histories {
            if i > 5 {
                break
            }
            array.append(ChartAxisValueDouble(Utility.toMH(hash: h.current)))
            i += 1
        }
        return array
    }
    
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
