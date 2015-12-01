//
//  ViewController.m
//  CIFaceFeature_Lena
//
//  Created by Simon Lucey on 11/30/15.
//  Copyright © 2015 CMU_16432. All rights reserved.
//

#import "ViewController.h"

// Include iostream and std namespace so we can mix C++ code in here
#include <iostream>
using namespace std;

@interface ViewController () {
    // Setup the view
    UIImageView *imageView_;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1. Setup the your imageView_ view, so it takes up the entire App screen......
    imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    
    // 2. Important: add OpenCV_View as a subview
    [self.view addSubview:imageView_];
    
    // Ensure aspect ratio looks correct
    imageView_.contentMode = UIViewContentModeScaleAspectFit;
    
    // 3. Load the image and display
    UIImage *image = [UIImage imageNamed:@"lena.png"];
    if(image != nil) imageView_.image = image; // Display the image if it is there....
    else cout << "Cannot read in the file" << endl;
    
    // 4. Initialize the face detector and its options
    NSDictionary *detectorOptions = @{ CIDetectorAccuracy : CIDetectorAccuracyLow };
    CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:detectorOptions];
    
    // 5. Apply the image through the face detector
    NSArray *features = [faceDetector featuresInImage:[CIImage imageWithCGImage: [image CGImage]]];

    // 6. Loop through each detected face
    for(CIFaceFeature* faceFeature in features) {
        
        // Check facial features
        
        // Smile
        if(faceFeature.hasSmile) cout << "Lena is Smiling" << endl;
        else cout << "Lena is Not Smiling" << endl;
 
        // Head angle
        if(faceFeature.hasFaceAngle) cout << "Lena's head is at an angle of " << faceFeature.faceAngle << endl;
        else cout << "Lena's head is not at an angle" << endl;
        
        // Left Eye location
        CGPoint lEye = faceFeature.leftEyePosition;
        if(faceFeature.hasLeftEyePosition)
            cout << "Lena's left eye is positioned at (" << lEye.x << "," << lEye.y << ")" << endl;
        else
            cout << "Lena's left eye is occluded!!" << endl;
    }
}
@end
