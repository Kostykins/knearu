//
//  RecentActivityTableViewCell.h
//  Knearu
//
//  Created by Matt Kostelecky on 6/20/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentActivityTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *lastActivityLabel;
- (void)animateImageView:(UITableView *)tableView;
@end
