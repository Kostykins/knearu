//
//  KnearuCameraViewController.h
//  Knearu
//
//  Created by Matt Kostelecky on 7/4/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

@protocol KnearuCameraViewControllerDelegate <NSObject>
-(void) cameraViewControllerDismissed:(UIImage *)imageFromCamera;
@end

@interface KnearuCameraViewController : UIViewController

@property (nonatomic, assign) id<KnearuCameraViewControllerDelegate>   cameraDelegate;

@end
