//
//  HomeViewController.h
//  Nearu
//
//  Created by Matt Kostelecky on 5/10/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController : UIViewController <CLLocationManagerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property UIImagePickerController *imagePicker;


@end
