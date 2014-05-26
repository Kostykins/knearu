//
//  RecentActivityTableViewController.m
//  Nearu
//
//  Created by Matt Kostelecky on 5/12/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RecentActivityTableViewController.h"
#import "RecentActivityTableViewCell.h"
#import "RecentPostViewController.h"

@interface RecentActivityTableViewController ()

@end

@implementation RecentActivityTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tableView.separatorColor = [UIColor colorWithRed:.97 green:.85 blue:.7 alpha:1];
    //self.tableView.scrollEnabled = NO;
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecentActivityTableViewCell *cell = [[RecentActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Recent Activity Cell"];
    UIView *myView = [[UIView alloc] init];
    
    if(tableView.frame.size.width == 260){
        cell.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 218, 30)];
        cell.lastActivityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 218, 30)];
    }
    else {
        cell.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 218, 30)];
        cell.lastActivityLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, 218, 30)];
    }
    
    cell.nameLabel.font = [UIFont fontWithName:@"eurofurence" size:18];
    cell.nameLabel.text = [NSString stringWithFormat:@"found twenty dollas"];
    cell.nameLabel.textColor = [UIColor blackColor];
    cell.nameLabel.alpha = .8;
    cell.nameLabel.textAlignment = NSTextAlignmentRight;
    
    cell.lastActivityLabel.font = [UIFont fontWithName:@"eurofurence light" size:16];
    cell.lastActivityLabel.text = [NSString stringWithFormat:@"in my pocket"];
    cell.lastActivityLabel.textColor = [UIColor blackColor];
    cell.lastActivityLabel.textAlignment = NSTextAlignmentRight;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    myView.backgroundColor = [UIColor colorWithRed:.98 green:.87 blue:.81 alpha:1];
    cell.backgroundView = myView;
    cell.nameLabel.backgroundColor = myView.backgroundColor;
    cell.lastActivityLabel.backgroundColor = myView.backgroundColor;
    [cell.contentView addSubview:cell.lastActivityLabel];
    [cell.contentView addSubview:cell.nameLabel];

    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:.97 green:.85 blue:.7 alpha:1];
    cell.selectedBackgroundView = selectionColor;

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{;
    //self.navigationItem.titleView.layer.shadowOpacity = 0;
    RecentPostViewController *secondController = [[RecentPostViewController alloc] init];
    [self.navigationController pushViewController:secondController animated:YES];
   // [self.navigationController.navigationItem.backBarButtonItem setStyle:UIBarButtonItemStyleBordered];
   // [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:.8 green:.25 blue:.27 alpha:1]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width - 10, 25)];
    headerView.backgroundColor = [UIColor colorWithRed:.85 green:.35 blue:.37 alpha:1];
    headerLabel.text = [NSString stringWithFormat:@"recent posts"];
    headerLabel.font = [UIFont fontWithName:@"eurofurence" size:16];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    headerLabel.layer.shadowOffset = CGSizeMake(1, 2);
    headerLabel.layer.shadowOpacity = .7;
    
    [headerView addSubview:headerLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (void)getVisibleCells{
    NSArray *placeHolderArray = self.tableView.visibleCells;
    for (RecentActivityTableViewCell *obj in placeHolderArray) {
        [obj animateImageView:self.tableView];
    }

}

@end
