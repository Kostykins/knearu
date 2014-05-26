//
//  PostView.m
//  Knearu
//
//  Created by Matt Kostelecky on 5/23/14.
//  Copyright (c) 2014 Matt Kostelecky. All rights reserved.
//

#import "PostView.h"

@implementation PostView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userName = [[UILabel alloc] initWithFrame:CGRectMake(80, 8, 260, 30)];
        self.locationText = [[UILabel alloc] initWithFrame:CGRectMake(80, 38, 260, 18)];
        self.descriptionText = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 320, 30)];
        
        self.userName.font = [UIFont fontWithName:@"eurofurence" size:24];
        self.locationText.font = [UIFont fontWithName:@"eurofurence" size:14];
        self.descriptionText.font = [UIFont fontWithName:@"eurofurence light" size:18];
        
        self.userName.textColor = [UIColor darkGrayColor];
        self.locationText.textColor = [UIColor lightGrayColor];
        self.descriptionText.textColor = [UIColor grayColor];
        
        [self addSubview:self.userName];
        [self addSubview:self.locationText];
        //[self addSubview:self.descriptionText];

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *mainRect = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [[UIColor whiteColor] setFill];
    [mainRect fill];
    
    UIBezierPath *picBorderOutline = [UIBezierPath bezierPathWithArcCenter:CGPointMake(42, 40) radius:28 startAngle:0 endAngle:2*M_PI clockwise:NO];
    [[UIColor darkGrayColor] setFill];
    [picBorderOutline fill];
    UIBezierPath *picBorderInside= [UIBezierPath bezierPathWithArcCenter:CGPointMake(42, 40) radius:26 startAngle:0 endAngle:2*M_PI clockwise:NO];
    [[UIColor whiteColor] setFill];
    [picBorderInside fill];
}


@end
