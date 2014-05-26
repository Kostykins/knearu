//
//  HomeTableViewCell.h
//  Knearu
//
//  Created by Matt Kostelecky on 6/18/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *thumbnailImage;
@property (strong, nonatomic) UILabel *lastActivityLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIView *mostRecentPost;
@property (strong, nonatomic) UITextView *mostRecentPostTextView;
@property (strong, nonatomic) UIButton *showProfileButton;

@end
