//
//  KnearuMapAnnotation.h
//  Knearu
//
//  Created by Matt Kostelecky on 6/17/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface KnearuMapAnnotation : NSObject <MKAnnotation>

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;


@end
