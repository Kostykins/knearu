//
//  MapViewController.h
//  Nearu
//
//  Created by Matt Kostelecky on 5/10/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KnearuCameraViewController.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UINavigationControllerDelegate, UITextViewDelegate, KnearuCameraViewControllerDelegate>
- (void)getDatView;

@property (strong, nonatomic) UIColor *currentPostColor;
@property (nonatomic, strong) UILabel *currentAnnotationLabel;
@property (strong, nonatomic) UIImageView *thumbnailPic;
@property (strong, nonatomic) UIImage *imageFromThumbnail;

//-(UIImage *)resizeImage:(UIImage *)image width:(CGFloat)desiredWidth height:(CGFloat)desiredHeight;
@end
