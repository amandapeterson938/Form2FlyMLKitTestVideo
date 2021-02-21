//
//  ViewController.swift
//  videoPlayer
//
//  Created by Amanda Peterson on 2/11/21.
//

import UIKit
import AVKit
import MLKit

class ViewController: UIViewController {

    @IBOutlet weak var myImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func watchVidBtn(_ sender: Any) {
        if let path = Bundle.main.path(forResource: "personVideo", ofType: "mov") {
            let pathURL = NSURL(fileURLWithPath: path)
            let video = AVURLAsset(url: (pathURL as URL), options: nil)
            let videoLength = video.duration
            let videoSec = Float(video.duration.seconds)
            
            let generator = AVAssetImageGenerator(asset: video)
            
            print(videoSec)
            
            var frameForTimes = [NSValue]()
            
            var curSec = Float(0.0)
            var cnt = Float(0)
            let numOfFrames = Float(30)
            let secInc = Float(1 / numOfFrames)
            while((curSec + secInc) < videoSec) {
                print(curSec)
                frameForTimes.append(curSec as NSValue)
                curSec = Float((secInc * cnt))
                cnt = cnt + 1
            } //end while (fills frameForTimes)
            print(cnt)
            
            
            var testcounter = 0
            let options = AccuratePoseDetectorOptions()
            options.detectorMode = .stream
            let poseDetector = PoseDetector.poseDetector(options: options)

            generator.generateCGImagesAsynchronously(forTimes: frameForTimes, completionHandler: {requestedTime, image, actualTime, result, error in
                DispatchQueue.main.async {
                    if let image = image {
                        let visionImg = VisionImage(image: UIImage(cgImage: image))
                        
                        DispatchQueue.global(qos: .background).async {
                            //background thread
                            var results: [Pose]?
                            do {
                                results = try poseDetector.results(in:visionImg)
                            }
                            catch let error {
                                print("Failed to detect pose with error: \(error.localizedDescription).")
                                return
                            }
                            guard let detectedPoses = results, !detectedPoses.isEmpty else {
                                return
                            }
                            
                            DispatchQueue.main.async {
                                for pose in detectedPoses {
                                    let noseLM = (pose.landmark(ofType: .nose))
                                    let leftEyeInnerLM = (pose.landmark(ofType: .leftEyeInner))
                                    let leftEyeLM = (pose.landmark(ofType: .leftEye))
                                    let leftEyeOuterLM = (pose.landmark(ofType: .leftEyeOuter))
                                    let rightEyeInnerLM = (pose.landmark(ofType: .rightEyeInner))
                                    let rightEyeLM = (pose.landmark(ofType: .rightEye))
                                    let rightEyeOuterLM = (pose.landmark(ofType: .rightEyeOuter))
                                    let leftEarLM = (pose.landmark(ofType: .leftEar))
                                    let rightEarLM = (pose.landmark(ofType: .rightEar))
                                    let mouthLeftLM = (pose.landmark(ofType: .mouthLeft))
                                    let mouthRightLM = (pose.landmark(ofType: .mouthRight))
                                    let leftShoulderLM = (pose.landmark(ofType: .leftShoulder))
                                    let rightShoulderLM = (pose.landmark(ofType: .rightShoulder))
                                    let leftElbowLM = (pose.landmark(ofType: .leftElbow))
                                    let rightElbowLM = (pose.landmark(ofType: .rightElbow))
                                    let leftWristLM = (pose.landmark(ofType: .leftWrist))
                                    let rightWristLM = (pose.landmark(ofType: .rightWrist))
                                    let leftPinkyFingerLM = (pose.landmark(ofType: .leftPinkyFinger))
                                    let rightPinkyFingerLM = (pose.landmark(ofType: .rightPinkyFinger))
                                    let leftIndexFingerLM = (pose.landmark(ofType: .leftIndexFinger))
                                    let rightIndexFingerLM = (pose.landmark(ofType: .rightIndexFinger))
                                    let leftThumbLM = (pose.landmark(ofType: .leftThumb))
                                    let rightThumbLM = (pose.landmark(ofType: .rightThumb))
                                    let leftHipLM = (pose.landmark(ofType: .leftHip))
                                    let rightHipLM = (pose.landmark(ofType: .rightHip))
                                    let leftKneeLM = (pose.landmark(ofType: .leftKnee))
                                    let rightKneeLM = (pose.landmark(ofType: .rightKnee))
                                    let leftAnkleLM = (pose.landmark(ofType: .leftAnkle))
                                    let rightAnkleLM = (pose.landmark(ofType: .rightAnkle))
                                    let leftHeelLM = (pose.landmark(ofType: .leftHeel))
                                    let rightHeelLM = (pose.landmark(ofType: .rightHeel))
                                    let leftToeLM = (pose.landmark(ofType: .leftToe))
                                    let rightToeLM = (pose.landmark(ofType: .rightToe))
                                    
                                    
                                    
                                    // print("Nose: \(testcounter) \(noseLM.position)")
                                    
                                    
                                    
                                    let imgDr = UIImage(cgImage: image)
                                    
                                    UIGraphicsBeginImageContext(imgDr.size)
                                    imgDr.draw(at: CGPoint.zero)
                                    let context = UIGraphicsGetCurrentContext()
                                    
                                    context?.setStrokeColor(UIColor.red.cgColor)
                                    context?.setAlpha(0.5)
                                    context?.setLineWidth(10.0)
                                    
                                    
                                    
                                    self.checkFrameLike(noseLM, context!)
                                    self.checkFrameLike(leftEyeInnerLM, context!)
                                    self.checkFrameLike(leftEyeLM, context!)
                                    self.checkFrameLike(leftEyeOuterLM, context!)
                                    self.checkFrameLike(rightEyeInnerLM, context!)
                                    self.checkFrameLike(rightEyeLM, context!)
                                    self.checkFrameLike(rightEyeOuterLM, context!)
                                    self.checkFrameLike(leftEarLM, context!)
                                    self.checkFrameLike(rightEarLM, context!)
                                    self.checkFrameLike(mouthLeftLM, context!)
                                    self.checkFrameLike(mouthRightLM, context!)
                                    self.checkFrameLike(leftShoulderLM, context!)
                                    self.checkFrameLike(rightShoulderLM, context!)
                                    self.checkFrameLike(leftElbowLM, context!)
                                    self.checkFrameLike(rightElbowLM, context!)
                                    self.checkFrameLike(leftWristLM, context!)
                                    self.checkFrameLike(rightWristLM, context!)
                                    self.checkFrameLike(leftPinkyFingerLM, context!)
                                    self.checkFrameLike(rightPinkyFingerLM, context!)
                                    self.checkFrameLike(leftIndexFingerLM, context!)
                                    self.checkFrameLike(rightIndexFingerLM, context!)
                                    self.checkFrameLike(leftThumbLM, context!)
                                    self.checkFrameLike(rightThumbLM, context!)
                                    self.checkFrameLike(leftHipLM, context!)
                                    self.checkFrameLike(rightHipLM, context!)
                                    self.checkFrameLike(leftKneeLM, context!)
                                    self.checkFrameLike(rightKneeLM, context!)
                                    self.checkFrameLike(leftAnkleLM, context!)
                                    self.checkFrameLike(rightAnkleLM, context!)
                                    self.checkFrameLike(leftHeelLM, context!)
                                    self.checkFrameLike(rightHeelLM, context!)
                                    self.checkFrameLike(leftToeLM, context!)
                                    self.checkFrameLike(rightToeLM, context!)
                                    
                                    
                                    
                                    
                                    context?.drawPath(using: .stroke)
                                    
                                    let myImage = UIGraphicsGetImageFromCurrentImageContext()
                                    UIGraphicsEndImageContext()
                                    
                                    self.myImgView.image = myImage
                                    
                                } //end for pose in detectedPoses
                            } // end dispatchqueue main async for detecting poses in image
                        }//end dispatchqueue pose detector
                        
                        //self.myImgView.image = UIImage(cgImage: image)
                        DispatchQueue.global(qos: .background).async { //Background thread
                            //print(image.hashValue)
                        } //end background async
                        
                        
                        //self.myImgView.image = UIImage(cgImage: image)
                    }
                }
                usleep(30000) 
                testcounter = testcounter + 1
            }) // end generator to put image frames in Poses
            generator.cancelAllCGImageGeneration()
            print("Will this show!")
        } //end if path of vdeo
    } //end watchVidBtn
    
    // Check if the landmark.inFrameLikelihood is > 0.5 if it is add the circle
    func checkFrameLike(_ landMark: PoseLandmark, _ lmContext: CGContext) {
        if landMark.inFrameLikelihood > 0.5 {
            let landMarkPos = landMark.position
            lmContext.addEllipse(in: CGRect(x: landMarkPos.x, y: landMarkPos.y, width: 10, height: 10))
        }//end if
    }//end checkFrameLike    
}

