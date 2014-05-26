//
//  HomeTableViewCell.m
//  Knearu
//
//  Created by Matt Kostelecky on 6/18/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

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
            self.showProfileButton.frame = CGRectMake(tableView.frame.size.width - 100, tableView.frame.size.height - 45, 100, 45);
            if(self.mostRecentPost.frame.size.height == tableView.frame.size.height - 125){
                self.thumbnailImage.frame = CGRectMake(30, 35, 40, 40);
                self.nameLabel.frame = CGRectMake(80, 25, 220, 30);
                self.lastActivityLabel.frame = CGRectMake(85, 48, 210, 30);
                self.mostRecentPost.frame = CGRectMake(40, 80, 220, tableView.frame.size.height - 125);
                self.mostRecentPostTextView.frame = CGRectMake(40, 80, 220, tableView.frame.size.height - 125);

                
            } else {
                self.mostRecentPost.frame = CGRectMake(40, 55, 220, 200);
                self.mostRecentPostTextView.frame = CGRectMake(40, 55, 220, 200);

            }
        }];
    }
    else{
        [UIView animateWithDuration:.1 animations:^{
           
            self.showProfileButton.frame = CGRectMake(tableView.frame.size.width - 100, tableView.frame.size.height - 45, 100, 45);
            if(self.mostRecentPost.frame.size.height == tableView.frame.size.height - 125){
                self.thumbnailImage.frame = CGRectMake(30, 35, 40, 40);
                self.nameLabel.frame = CGRectMake(80, 25, 220, 30);
                self.lastActivityLabel.frame = CGRectMake(85, 48, 210, 30);
                self.mostRecentPost.frame = CGRectMake(40, 80, 285, tableView.frame.size.height - 125);
                self.mostRecentPostTextView.frame = CGRectMake(40, 80, 285, tableView.frame.size.height - 125);
            } else {
                self.mostRecentPost.frame = CGRectMake(40, 55, 285, 200);
                self.mostRecentPostTextView.frame = CGRectMake(40, 55, 285, 200);
            }
        }];
    }
}

- (void)animateWhenSelected:(UITableView *)tableView{

    if(tableView.frame.size.width == 260){
        [UIView animateWithDuration:.2 animations:^{
            self.thumbnailImage.frame = CGRectMake(30, 35, 40, 40);
            self.nameLabel.frame = CGRectMake(80, 25, 220, 30);
            self.lastActivityLabel.frame = CGRectMake(85, 48, 210, 30);
            self.mostRecentPost.frame = CGRectMake(40, 80, 220, tableView.frame.size.height - 125);
            self.mostRecentPostTextView.frame = CGRectMake(40, 80, 220, tableView.frame.size.height - 125);
        }completion:^(BOOL finished){
            self.showProfileButton.alpha = 1;
        }];
        
    } else{
        [UIView animateWithDuration:.2 animations:^{
            self.thumbnailImage.frame = CGRectMake(30, 35, 40, 40);
            self.nameLabel.frame = CGRectMake(80, 25, 220, 30);
            self.lastActivityLabel.frame = CGRectMake(85, 48, 210, 30);
            self.mostRecentPost.frame = CGRectMake(40, 80, 285, tableView.frame.size.height - 125);
            self.mostRecentPostTextView.frame = CGRectMake(40, 80, 285, tableView.frame.size.height - 125);
        }completion:^(BOOL finished){
            self.showProfileButton.alpha = 1;
        }];
    }
    
}
- (void)animateWhenDeselected:(UITableView *)tableView{

    if(tableView.frame.size.width == 260){
        [UIView animateWithDuration:.2 animations:^{
            self.mostRecentPost.frame = CGRectMake(40, 55, 220, 200);
            self.mostRecentPostTextView.frame = CGRectMake(40, 55, 220, 200);
            self.thumbnailImage.frame = CGRectMake(30, 10, 40, 40);
            self.nameLabel.frame = CGRectMake(80, 2, 220, 30);
            self.lastActivityLabel.frame = CGRectMake(85, 23, 210, 30);
        }completion:^(BOOL finished){
            self.showProfileButton.alpha = 0;
           // [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            
        }];

    } else{
        [UIView animateWithDuration:.2 animations:^{
            self.mostRecentPost.frame = CGRectMake(40, 55, 285, 200);
            self.mostRecentPostTextView.frame = CGRectMake(40, 55, 285, 200);
            self.thumbnailImage.frame = CGRectMake(30, 10, 40, 40);
            self.nameLabel.frame = CGRectMake(80, 2, 220, 30);
            self.lastActivityLabel.frame = CGRectMake(85, 23, 210, 30);
        }completion:^(BOOL finished){
           self.showProfileButton.alpha = 0;
           // [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    
}
@end
