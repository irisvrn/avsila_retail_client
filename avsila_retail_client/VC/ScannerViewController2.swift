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
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.ean13] //types of data ean13, code128, qr ...
        
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
                if object.type == AVMetadataObject.ObjectType.ean13
                {
                    print(object.stringValue)
                    
                    let alert = UIAlertController(title: "Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                        UIPasteboard.general.string = object.stringValue
                    }))
                    
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
