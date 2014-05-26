//
//  PostAnnotationView.m
//  Nearu
//
//  Created by Matt Kostelecky on 5/31/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PostAnnotationView.h"
#import "KnearuMapAnnotation.h"



static CGFloat kMaxViewWidth = 100.0;

static CGFloat kViewWidth = 60;
static CGFloat kViewLength = 60;

static CGFloat kLeftMargin = 5.0;
static CGFloat kRightMargin = 5.0;
static CGFloat kTopMargin = 5.0;

@interface PostAnnotationView ()
@property (nonatomic, strong) UILabel *annotationLabel;
@property (nonatomic, strong) UIButton *annotationButton;
@property (nonatomic, strong) UIImageView *annotationImage;

@end

@implementation PostAnnotationView

// determine the MKAnnotationView based on the annotation info and reuseIdentifier
//
- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil)
    {
        self.backgroundColor = [UIColor clearColor];
        
        // offset the annotation so it won't obscure the actual lat/long location
        self.centerOffset = CGPointMake(0.0, 0.0);
        
        // add the annotation's label
        _annotationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.annotationLabel.font = [UIFont fontWithName:@"eurofurence" size:10];
        self.annotationLabel.textColor = [UIColor whiteColor];
        
        // compute the optimum width of our annotation, based on the size of our annotation label
        CGFloat optimumWidth = self.annotationLabel.frame.size.width + kRightMargin + kLeftMargin;
        CGRect frame = self.frame;
        if (optimumWidth < kViewWidth)
            frame.size = CGSizeMake(kViewWidth, kViewLength);
        else if (optimumWidth > kMaxViewWidth)
            frame.size = CGSizeMake(kMaxViewWidth, kViewLength);
        else
            frame.size = CGSizeMake(optimumWidth, kViewLength);
        self.frame = frame;
        
        self.annotationLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.annotationLabel.backgroundColor = [UIColor clearColor];
        CGRect newFrame = self.annotationLabel.frame;
        newFrame.origin.x = kLeftMargin;
        newFrame.origin.y = kTopMargin;
        newFrame.size.width = self.frame.size.width - kRightMargin - kLeftMargin;
        self.annotationLabel.frame = newFrame;
        [self addSubview:self.annotationLabel];
        
        // add the annotation's image
        // the annotation image snaps to the width and height of this view
        _annotationImage = [[UIImageView alloc] init];
        self.annotationImage.frame = CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-26);
       // self.annotationImage.layer.borderWidth = 3;
        //self.annotationImage.layer.borderColor = [[UIColor colorWithRed:.84 green:.67 blue:.43 alpha:1] CGColor];
        [self addSubview:self.annotationImage];
        
        _annotationButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height-20)];
        self.annotationButton.backgroundColor = [UIColor clearColor];
        [self.annotationButton addTarget:self action:@selector(checkPost:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.annotationButton];
    }
    
    return self;
}

- (void)setAnnotation:(id <MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    
    // this annotation view has custom drawing code.  So when we reuse an annotation view
    // (through MapView's delegate "dequeueReusableAnnoationViewWithIdentifier" which returns non-nil)
    // we need to have it redraw the new annotation data.
    //
    // for any other custom annotation view which has just contains a simple image, this won't be needed
    //
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    KnearuMapAnnotation *mapItem = (KnearuMapAnnotation *)self.annotation;
    if (mapItem != nil)
    {
        
        self.postColor = self.mapController.currentPostColor;
        UIBezierPath *outerCirclePath =
        [UIBezierPath bezierPathWithArcCenter:CGPointMake(30.0, 30.0) radius:20 startAngle:0 endAngle:2*M_PI clockwise:NO];
        outerCirclePath.lineWidth = 2.0;
        [self.postColor setFill];
        [outerCirclePath fill];
        
        [[UIColor whiteColor] setFill];
        
        //[[UIColor colorWithRed:.95 green:.35 blue:.3 alpha:1] setFill];
        // draw the rounded box
        UIBezierPath *circlePath =
        [UIBezierPath bezierPathWithArcCenter:CGPointMake(30.0, 30.0) radius:18 startAngle:0 endAngle:2*M_PI clockwise:NO];
        circlePath.lineWidth = 2.0;
        self.annotationImage.image = self.mapController.thumbnailPic.image;
        [circlePath fill];
        
       // get the right vertical size
      //  self.annotationLabel.textAlignment = NSTextAlignmentCenter;
        
    }
}

- (void)checkPost:(UIButton *)sender{

    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.alpha = 0.5;
                     }
                     completion:^(BOOL finished){
                         if(finished) {
                             [UIView animateWithDuration:0.4
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseInOut
                                              animations:^ {
                                                  self.alpha = 1;
                                                  [self.mapController getDatView];
                                                  
                                              }
                                              completion:nil];

                         }
                     }];

}
@end
