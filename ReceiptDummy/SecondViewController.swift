//
//  SecondViewController.swift
//  ImagePicker
//
//  Created by Wenting Wang on 2018-06-18.
//  Copyright © 2018 Wenting Wang. All rights reserved.
//

import UIKit
import TesseractOCR

class SecondViewController: UIViewController, G8TesseractDelegate {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageView2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func ShowLocation(_ sender: UIButton) {
         performSegue(withIdentifier: "segue2", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.text = "test"
        imageView2.image = pickedImage
        
        if let tesseract = G8Tesseract(language:"eng") {
            tesseract.delegate = self
            tesseract.image = pickedImage?.g8_blackAndWhite()
//            tesseract.image = UIImage(named: "receipt1")?.g8_blackAndWhite()
            tesseract.recognize()
            
            textView.text = tesseract.recognizedText
        }
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recogonition Progress \(tesseract.progress)%")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
