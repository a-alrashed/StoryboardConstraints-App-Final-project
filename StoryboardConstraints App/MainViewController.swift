//
//  MainViewController.swift
//  StoryboardConstraints App
//
//  Created by Azzam R Alrashed on 14/12/2020.
//

import UIKit


class MainViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var morningBirdsImage: UIImageView!
    @IBOutlet weak var nightStarsImage: UIImageView!
    @IBOutlet weak var nightfilterView: UIView!
    
    @IBOutlet weak var sunMoonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = getHijriCalendearDate()
           //"Date in system calendar:2014-09-25 09:53:00 +0000, in Hijri:1435-11-30"
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var nightSwitch: UISwitch!
    @IBAction func didChangeSwitchValue(_ sender: UISwitch) {
        if nightSwitch.isOn {
            titleLabel.text = "اذكار المساء"
            nightAnimation()
        } else {
            titleLabel.text = "اذكار الصباح"
            morningAnimation()
        }
        mainCollectionView.reloadData()
        mainCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
    }
    
    
    fileprivate func nightAnimation() {
        UIView.animate(withDuration: 2) {
            self.nightStarsImage.alpha = 1
            self.morningBirdsImage.alpha = 0
            self.nightfilterView.alpha = 0.5
            self.view.backgroundColor = #colorLiteral(red: 0.4681420326, green: 0.423650682, blue: 0.6468107104, alpha: 1)
            self.titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.dateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.sunMoonView.transform = CGAffineTransform.identity.rotated(by: .pi )
        }
    }
    
    fileprivate func morningAnimation() {
        UIView.animate(withDuration: 2) {
            self.nightStarsImage.alpha = 0
            self.morningBirdsImage.alpha = 1
            self.nightfilterView.alpha = 0
            self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.5254901961, alpha: 1)
            self.titleLabel.textColor = #colorLiteral(red: 0.1607536674, green: 0.07421364635, blue: 0.1699104011, alpha: 1)
            self.dateLabel.textColor = #colorLiteral(red: 0.1607536674, green: 0.07421364635, blue: 0.1699104011, alpha: 1)
            self.sunMoonView.transform = CGAffineTransform.identity.rotated(by: .pi * 2 )
        }
    }
    
    fileprivate func getHijriCalendearDate() -> String {
        let hijriCalendar = Calendar(identifier: .islamicCivil)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar")
        formatter.calendar = hijriCalendar
        formatter.dateFormat = "EEE dd MMMM yyyy"
        
        return formatter.string(from: Date())
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FinishedReadingDelegate {
    
    func presentNextCell() {
        let contentOffset = CGFloat(floor(mainCollectionView.contentOffset.x + mainCollectionView.bounds.size.width))
        mainCollectionView.setContentOffset(CGPoint(x: contentOffset, y: mainCollectionView.contentOffset.y), animated: true)
                
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if nightSwitch.isOn {
            return nightContentArray.count
        } else {
            return morningContentArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCollectionViewCell
        
        if nightSwitch.isOn {
            cell.configure(text: nightContentArray[indexPath.row].text, numberOfTapsNeeded: nightContentArray[indexPath.row].numberOfTapsNeeded)
        } else {
            cell.configure(text: morningContentArray[indexPath.row].text, numberOfTapsNeeded: morningContentArray[indexPath.row].numberOfTapsNeeded)
        }
        cell.cellDelegate = self as FinishedReadingDelegate
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width , height: collectionView.bounds.size.height - 50)
    }
    
    
    
    
}
