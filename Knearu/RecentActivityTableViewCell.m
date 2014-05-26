//
//  RecentActivityTableViewCell.m
//  Knearu
//
//  Created by Matt Kostelecky on 6/20/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import "RecentActivityTableViewCell.h"

@implementation RecentActivityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)animateImageView:(UITableView *)tableView{
    
    if(tableView.frame.size.width == 260){
        [UIView animateWithDuration:.1 animations:^{
            self.nameLabel.frame = CGRectMake(0, 8, 218, 30);
            self.lastActivityLabel.frame = CGRectMake(0, 35, 218, 30);
        }];
    }
    else{
        [UIView animateWithDuration:.1 animations:^{
            self.nameLabel.frame = CGRectMake(60, 8, 218, 30);
            self.lastActivityLabel.frame = CGRectMake(60, 35, 218, 30);
        }];
    }
}
@end
