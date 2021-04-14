//
//  ViewController.swift
//  QRcode
//
//  Created by RuiJun haung on 2020/8/14.
//  Copyright © 2020 RuiJun haung. All rights reserved.
//

import UIKit
import AVFoundation
import SafariServices

class ViewController: UIViewController ,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    @IBOutlet weak var camview: UIView!
    
    @IBOutlet weak var codeTextLable: UILabel!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var alumButton: UIButton!
    var captureSession:AVCaptureSession?
    var previewLayer:AVCaptureVideoPreviewLayer!
    var QRCodeString:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstView = UIView(frame: CGRect(x:0,y:0,width:100,height:100))
        self.view.addSubview(firstView)
        webButton.layer.cornerRadius = 10.0
        webButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    func setQRCideScan() {
        //實體化一個AVCaptureSession物件
        captureSession = AVCaptureSession()
        //AVCaptureDevice可以抓到相機和其屬性
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video)else{
            return
        }
        let videoInput:AVCaptureDeviceInput
        do{
            videoInput = try AVCaptureDeviceInput(device:videoCaptureDevice)
            }
        catch let error{
            
            print(error)
            return
        }
        if (captureSession?.canAddInput(videoInput) ?? false ){
            captureSession?.addInput(videoInput)
            
        }else{
            return
        }
        //AVCaptureMetaDataOutput輸出影音資料，先實體化AVCaptureMetaDataOutput物件
        let metaDataOutput = AVCaptureMetadataOutput()
        if(captureSession?.canAddOutput(metaDataOutput) ?? false){
            
            captureSession?.addOutput(metaDataOutput)
            //關鍵！執行緒處理QRCode
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            //metadataOutput.metadataObjectTypes表示要處理哪些類型的資料，處理QRcode
            metaDataOutput.metadataObjectTypes = [.qr,.ean8 ,.ean13 , .pdf417]
            
        }else{
            return
        }
        //用AVCaptureVideoPreviewLayer來呈現Session上的資料
        previewLayer = AVCaptureVideoPreviewLayer(session:captureSession!)
        //顯示size
        previewLayer.videoGravity = .resizeAspectFill
        //呈現在camView上面
        previewLayer.frame = camview.layer.frame
        //加入畫面
        view.layer.addSublayer(previewLayer)
        //顯示scan Area Window 框框
        let size = 300
        let sWidth = Int(view.frame.size.width)
        let xPos = (sWidth/2) - (size/2)
        let scanRect = CGRect(x: CGFloat(xPos),y: 100,width: CGFloat(size),height: CGFloat(size))
        //設定scan Area window 框框
        let scanAreaView = UIView()
        scanAreaView.layer.borderColor = UIColor.gray.cgColor
        scanAreaView.layer.borderWidth = 2
        scanAreaView.frame = scanRect
        view.addSubview(scanAreaView)
        view.bringSubviewToFront(scanAreaView)
        
        //開始影像擷取呈現鏡頭的畫面
        captureSession?.startRunning()
        
        
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession?.startRunning()
        if let metadataObject = metadataObjects.first{
            //AVMetadataMachineReadableCodeObject是從Output擷取到barcode內容
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else{
                return}
            //將讀取到的內容轉成string
            guard let stringvalue = readableObject.stringValue else {
                return
            }
            //掃到QRcode後的震動提示
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            //將String資料放到label上
            codeTextLable.text = stringvalue
            //存取QRcodeURL
            QRCodeString = stringvalue
        }
    }
    //畫面不顯示即停止掃描
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if(captureSession?.isRunning == true){
            
            captureSession?.stopRunning()
        }
        
    }
    //掃描條碼的按鈕
    
    @IBAction func sacnAlbumButton(_ sender: Any) {
        let photoController = UIImagePickerController()
        photoController.delegate = self
        photoController.sourceType = .photoLibrary
        present(photoController,animated: true,completion: nil)
        
        
    }
    //取得相片後讀取QRcode
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh]),let ciImage = CIImage(image: pickedImage),let features = detector.features(in: ciImage) as? [CIQRCodeFeature] else{return}
        let qrCodeLink = features.reduce(""){ $0 + ($1.messageString ?? "")}
        codeTextLable.text = qrCodeLink
        QRCodeString = qrCodeLink
        //一定要加上這一句不然選完照片會卡住
        picker.dismiss(animated: true, completion: nil)
    }
    //開啟網頁
    @IBAction func openWebButton(_ sender: Any) {
            let url  = URL(string: QRCodeString)
        let safariVC = SFSafariViewController(url: url!)
        present(safariVC,animated: true,completion: nil)
    }
    //清空codeTextLabel
    @IBAction func removeQRCode(_ sender: Any) {
        
        QRCodeString.removeAll()
        codeTextLable.text = ""
    }
}

