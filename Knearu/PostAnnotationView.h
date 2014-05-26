//
//  PostAnnotationView.h
//  Nearu
//
//  Created by Matt Kostelecky on 5/31/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MapViewController.h"

@interface PostAnnotationView : MKAnnotationView

@property MapViewController *mapController;

@property (strong, nonatomic) UIColor *postColor;


@end
