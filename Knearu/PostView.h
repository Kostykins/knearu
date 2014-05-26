//
//  PostView.h
//  Knearu
//
//  Created by Matt Kostelecky on 5/23/14.
//  Copyright (c) 2014 Matt Kostelecky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostView : UIView

@property (weak, nonatomic) UIImage *userImage;
@property (strong, nonatomic) UILabel *userName;
@property (strong, nonatomic) UILabel *locationText;
@property (strong, nonatomic) UILabel *descriptionText;


@end
