//
//  MainCollectionViewCell.swift
//  StoryboardConstraints App
//
//  Created by Azzam R Alrashed on 14/12/2020.
//

import UIKit

protocol FinishedReadingDelegate: class {
    func presentNextCell()
}

class MainCollectionViewCell: UICollectionViewCell {
    
    weak var cellDelegate: FinishedReadingDelegate?
    
    var numberOfTapsNeeded:Float = 1
    var numberOftapsDone:Float = 0
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func didTabCell(_ sender: Any) {
        
        numberOftapsDone += 1
        progressView.progress = numberOftapsDone / numberOfTapsNeeded
        if progressView.progress == 1 {
            self.cellDelegate?.presentNextCell()
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        } else {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
    
    func configure(text: String, numberOfTapsNeeded: Int) {
        self.numberOftapsDone = 0 
        self.progressView.progress = 0
        self.label.text = text
        self.numberOfTapsNeeded = Float(numberOfTapsNeeded)
    }
}
