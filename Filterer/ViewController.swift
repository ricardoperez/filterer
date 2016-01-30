//
//  ViewController.swift
//  Filterer
//
//  Created by Ricardo Perez on 1/30/16.
//  Copyright © 2016 Ricardo Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var filteredImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageToggle: UIButton!
    
    @IBAction func onImageToggle(sender: UIButton) {
        if imageToggle.selected{
            let imageOrg = UIImage(named: "bob")
            imageView.image = imageOrg
            imageToggle.selected = false
        }else{
            imageView.image = filteredImage
            imageToggle.selected = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "bob")!
        let rgbaImage = RGBAImage(image: image)!
        let avgRed = 107
        
        //imageToggle.setTitle("Show original Image", forState: .Selected)
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width{
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                let redDelta = Int(pixel.red) - avgRed
                
                var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                
                if (Int(pixel.red) < avgRed){
                    modifier = 1
                }
                
                pixel.red = UInt8(max(min(255,
                    Int(round(Double(avgRed) + modifier * Double(redDelta)))), 0))
                rgbaImage.pixels[index] = pixel
            }
        }
    
        filteredImage = rgbaImage.toUIImage()
        
        print("Finish method")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

