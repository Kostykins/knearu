//
//  HomeTableViewController.h
//  Nearu
//
//  Created by Matt Kostelecky on 5/10/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "RecentActivityTableViewController.h"

@interface HomeTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property BOOL isSelected;
@property HomeViewController *homeController;
@property RecentActivityTableViewController *tableController;

- (void)getVisibleCells;

@end
