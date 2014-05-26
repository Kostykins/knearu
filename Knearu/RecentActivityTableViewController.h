//
//  RecentActivityTableViewController.h
//  Nearu
//
//  Created by Matt Kostelecky on 5/12/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentActivityTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (void)getVisibleCells;

@end
