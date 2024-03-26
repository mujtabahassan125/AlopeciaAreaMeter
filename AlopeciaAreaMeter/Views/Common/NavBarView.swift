//
//  NavBarView.swift
//  AlopeciaAreaMeter
//
//  Created by Mujtaba Hassan on 26/03/2024.
//


import UIKit

class NavBarView: UIView {

    @IBOutlet weak var nameLbl: UILabel!
    var contentView: UIView?

 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }

    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NavBarView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
