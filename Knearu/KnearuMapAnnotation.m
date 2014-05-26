//
//  KnearuMapAnnotation.m
//  Knearu
//
//  Created by Matt Kostelecky on 6/17/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import "KnearuMapAnnotation.h"

@implementation KnearuMapAnnotation

- (id)init {
    return [self initWithCoordinate:CLLocationCoordinate2DMake(self.coordinate.latitude, self.coordinate.longitude) title:@"PostMarker"];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _title = title;
    }
    return self;
}

@end
