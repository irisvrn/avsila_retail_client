//
//  ScannerViewController2.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 27.12.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController2: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var video = AVCaptureVideoPreviewLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //create a session
        let session = AVCaptureSession()
        
        //define capture device
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) //6:50
        
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            print("Error")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        if Model.shared.BarCodeType == "Code39" {
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.code39] //types of data ean13, code128, qr ...
        } else
        {
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.code128]
        }
        video = AVCaptureVideoPreviewLayer(session: session)
        //fill the intire screen
        
        video.frame = view.layer.bounds //view.bounds
        view.layer.addSublayer(video)
        
        //self.view.bringSubviewToFront(square) // картинку квадратик
        
        session.startRunning()
        // Do any additional setup after loading the view.
    }
    
    //changed function
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.code39 || object.type == AVMetadataObject.ObjectType.code128
                {
                    print(object.stringValue)
                    
                    let alert = UIAlertController(title: "Номер карты", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Переснять", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (nil) in
                        UIPasteboard.general.string = object.stringValue
                        Model.shared.discountCartNumber = object.stringValue!
                        //self.dismiss(animated: true, completion: nil)
                        //self.navigationController?.dismiss(animated: true, completion: nil)
                        self.navigationController?.popViewController(animated: true)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getdiscountcartnumber"), object: self)
                        
                    }))
                    
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }



}
