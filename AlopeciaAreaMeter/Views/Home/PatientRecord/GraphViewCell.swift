//
//  GraphViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Mujtaba Hassan on 26/03/2024.
//

import UIKit
import Charts

class GraphViewCell: UITableViewCell {

    @IBOutlet weak var chartView: ScatterChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
