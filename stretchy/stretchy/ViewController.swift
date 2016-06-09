//
//  ViewController.swift
//  stretchy
//
//  Created by Zach Smoroden on 2016-06-09.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navView: UIView!
    var stackView: UIStackView = UIStackView(frame: CGRectZero)
    
    var snackVerticalConstraint: NSLayoutConstraint!
    
    var snacksLabel:UILabel!
    
    var data:[String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Horizontal
        stackView.distribution = .FillEqually
        
        navView.addSubview(stackView)
        
        stackView.bottomAnchor.constraintEqualToAnchor(navView.bottomAnchor).active = true
        stackView.leadingAnchor.constraintEqualToAnchor(navView.leadingAnchor).active = true
        stackView.trailingAnchor.constraintEqualToAnchor(navView.trailingAnchor).active = true
        stackView.heightAnchor.constraintEqualToConstant(100).active = true
        
        let img1 = UIButton(frame: CGRectZero)
        img1.setBackgroundImage(UIImage(named: "oreos"), forState: .Normal)
        img1.addTarget(self, action: #selector(addSnack(_:)), forControlEvents: .TouchUpInside)
        img1.tag = 1
        
        let img2 = UIButton(frame: CGRectZero)
        img2.setBackgroundImage(UIImage(named: "pizza_pockets"), forState: .Normal)
        img2.addTarget(self, action: #selector(addSnack(_:)), forControlEvents: .TouchUpInside)
        img2.tag = 2
        
        let img3 = UIButton(frame: CGRectZero)
        img3.setBackgroundImage(UIImage(named: "pop_tarts"), forState: .Normal)
        img3.addTarget(self, action: #selector(addSnack(_:)), forControlEvents: .TouchUpInside)
        img3.tag = 3
        let img4 = UIButton(frame: CGRectZero)
        img4.setBackgroundImage(UIImage(named: "popsicle"), forState: .Normal)
        img4.addTarget(self, action: #selector(addSnack(_:)), forControlEvents: .TouchUpInside)
        img4.tag = 4
        
        let img5 = UIButton(frame: CGRectZero)
        img5.setBackgroundImage(UIImage(named: "ramen"), forState: .Normal)
        img5.addTarget(self, action: #selector(addSnack(_:)), forControlEvents: .TouchUpInside)
        img5.tag = 5
        
        stackView.addArrangedSubview(img1)
        stackView.addArrangedSubview(img2)
        stackView.addArrangedSubview(img3)
        stackView.addArrangedSubview(img4)
        stackView.addArrangedSubview(img5)
        
        stackView.hidden = true
        
        snacksLabel = UILabel(frame: CGRectZero)
        
        snacksLabel.text = "SNACKS"
        snacksLabel.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(snacksLabel)
        
        snacksLabel.centerXAnchor.constraintEqualToAnchor(navView.centerXAnchor).active = true
        snackVerticalConstraint = snacksLabel.centerYAnchor.constraintEqualToAnchor(navView.centerYAnchor)
        snackVerticalConstraint.active = true
        snackVerticalConstraint.identifier = "snackVert"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func addButton(sender: UIButton) {
        
        for constraint in navView.constraints {
            if constraint.identifier == "snackVert" {
                constraint.active = false
            }
        }
        
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
            
            if self.heightConstraint.constant == 64 {
                self.heightConstraint.constant = 200
                sender.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2 / 2))
                let constraint = self.snacksLabel.centerYAnchor.constraintEqualToAnchor(self.navView.centerYAnchor, constant: -40)
                constraint.identifier = "snackVert"
                constraint.active = true
                
                self.snacksLabel.text = "Add a Snack"
            } else {
                self.heightConstraint.constant = 64
                sender.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                let constraint = self.snacksLabel.centerYAnchor.constraintEqualToAnchor(self.navView.centerYAnchor, constant: 0)
                constraint.identifier = "snackVert"
                constraint.active = true
                
                self.snacksLabel.text = "SNACKS"
            }

            self.stackView.hidden = !self.stackView.hidden
            
            
            self.view.layoutIfNeeded()
            
        }) { (_) in
            
        }
        
    }
    
    func addSnack(sender:UIButton) {
        switch sender.tag {
        case 1:
            data.append("oreo")
        case 2:
            data.append("pizza pocket")
        case 3:
            data.append("pop tarts")
        case 4:
            data.append("popsicle")
        case 5:
            data.append("ramen")
        default:
            print("bad tag")
        }
        tableView.reloadData()
    }
    
    // MARK: - TableView stuff
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        cell.textLabel?.text = data[indexPath.row]
        
        
        
        return cell
    }
}

