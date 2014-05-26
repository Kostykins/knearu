//
//  HomeTableViewController.m
//  Nearu
//
//  Created by Matt Kostelecky on 5/10/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "HomeTableViewController.h"
#import "HomeTableViewCell.m"
#import "RecentPostViewController.h"
#import "KnearuProfileViewController.h"

@class HomeViewController;

@interface HomeTableViewController ()

@property int currentCellHeight;

@property HomeTableViewCell *theCell;

@end

@implementation HomeTableViewController

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
    //  [self.tableView setDelegate:self];
    self.currentCellHeight = -1;
    self.isSelected = NO;
    self.tableView.scrollEnabled = YES;
    self.tableView.separatorColor = [UIColor colorWithRed:.97 green:.85 blue:.7 alpha:1];
    
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    UIView *myView = [[UIView alloc] init];
    cell.thumbnailImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 40, 40)];
    if(tableView.frame.size.width == 260){
            cell.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 2, 220, 30)];
            cell.lastActivityLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 23, 210, 30)];
            cell.mostRecentPost = [[UIView alloc] initWithFrame:CGRectMake(40, 55, 215, 200)];
            cell.mostRecentPostTextView = [[UITextView alloc] initWithFrame:CGRectMake(40, 55, 220, 200)];
    }
    else{
            cell.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 2, 220, 30)];
            cell.lastActivityLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 23, 210, 30)];
            cell.mostRecentPost = [[UIView alloc] initWithFrame:CGRectMake(40, 55, 285, 200)];
            cell.mostRecentPostTextView = [[UITextView alloc] initWithFrame:CGRectMake(40, 55, 285, 200)];
    }
    cell.showProfileButton = [[UIButton alloc]initWithFrame:CGRectMake(tableView.frame.size.width - 100, tableView.frame.size.height - 45, 100, 45)];

    cell.nameLabel.font = [UIFont fontWithName:@"eurofurence" size:20];
    cell.nameLabel.text = [NSString stringWithFormat:@"person hopalicious"];
    cell.nameLabel.textColor = [UIColor blackColor];
    cell.nameLabel.alpha = .8;
    cell.nameLabel.textAlignment = NSTextAlignmentLeft;
    
    cell.lastActivityLabel.font = [UIFont fontWithName:@"eurofurence light" size:16];
    cell.lastActivityLabel.text = [NSString stringWithFormat:@"butt chuggin"];
    cell.lastActivityLabel.textColor = [UIColor blackColor];
    cell.lastActivityLabel.textAlignment = NSTextAlignmentLeft;
    
    [cell.thumbnailImage setImage:[UIImage imageNamed:@"Woopame.jpg"]];
    cell.thumbnailImage.layer.cornerRadius = 3;
    cell.thumbnailImage.layer.masksToBounds = YES;
    cell.thumbnailImage.layer.borderColor = ([[UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1] CGColor]);
    cell.thumbnailImage.layer.borderWidth = 2;
    
    //cell.mostRecentPost.backgroundColor = [UIColor colorWithRed:.97 green:.85 blue:.7 alpha:.1];
    cell.mostRecentPostTextView.backgroundColor = [UIColor colorWithRed:.97 green:.85 blue:.7 alpha:.4];
    cell.mostRecentPostTextView.font = [UIFont fontWithName:@"eurofurence" size:14];
    cell.mostRecentPostTextView.text = @"This is placeholder text for a most recent activity pee poop";
    //cell.mostRecentPost.editable = NO;
    
    cell.showProfileButton.backgroundColor =  [UIColor colorWithRed:.98 green:.87 blue:.81 alpha:1];
    [cell.showProfileButton setTitleColor:[UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1] forState:UIControlStateNormal];
    [cell.showProfileButton setTitleColor:[UIColor colorWithRed:.7 green:.25 blue:.27 alpha:.4] forState:UIControlStateHighlighted];

    [cell.showProfileButton setTitle:@"full profile  > " forState:UIControlStateNormal];
    [cell.showProfileButton.titleLabel setFont:[UIFont fontWithName:@"eurofurence" size:20]];

    [cell.showProfileButton addTarget:self action:@selector(showProfile) forControlEvents:UIControlEventTouchUpInside];
    cell.showProfileButton.alpha = 0;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    myView.backgroundColor = [UIColor colorWithRed:.98 green:.87 blue:.81 alpha:1];
    cell.backgroundView = myView;
    cell.nameLabel.backgroundColor = myView.backgroundColor;
    cell.lastActivityLabel.backgroundColor = myView.backgroundColor;

    if([[cell.contentView subviews] containsObject:cell.lastActivityLabel]){
        [cell.lastActivityLabel removeFromSuperview];
        [cell.nameLabel removeFromSuperview];
        [cell.thumbnailImage removeFromSuperview];
        [cell.mostRecentPostTextView removeFromSuperview];
        [cell.mostRecentPost removeFromSuperview];
        [cell.showProfileButton removeFromSuperview];
    }
    
    [cell.contentView addSubview:cell.lastActivityLabel];
    [cell.contentView addSubview:cell.nameLabel];
    [cell.contentView addSubview:cell.thumbnailImage];
    [cell.contentView addSubview:cell.mostRecentPostTextView];
    [cell.contentView addSubview:cell.mostRecentPost];
    [cell.contentView addSubview:cell.showProfileButton];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.theCell = cell;
    return self.theCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == self.currentCellHeight) {
        return  tableView.frame.size.height;
    }
    else return 260;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = [indexPath row];
    if(self.isSelected && self.currentCellHeight == row){
        self.isSelected = NO;
        row = -1;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        tableView.scrollEnabled = YES;
        NSArray *placeHolderArray = self.tableView.visibleCells;
        for (HomeTableViewCell *obj in placeHolderArray) {
            [obj animateWhenDeselected:self.tableView];
        }
       // [self.showProfileButton removeFromSuperview];
    }
    else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        self.isSelected = YES;

        NSArray *placeHolderArray = self.tableView.visibleCells;
        for (HomeTableViewCell *obj in placeHolderArray) {
            [obj animateWhenSelected:self.tableView];
        }
        tableView.scrollEnabled = NO;
    }
    
    self.currentCellHeight = row;
    [tableView beginUpdates];
    [tableView endUpdates];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, tableView.frame.size.width - 30, 25)];
    headerView.backgroundColor = [UIColor colorWithRed:.85 green:.35 blue:.37 alpha:1];
    headerLabel.text = [NSString stringWithFormat:@"most recent activity"];
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
    for (HomeTableViewCell *obj in placeHolderArray) {
        [obj animateImageView:self.tableView];
    }
}

- (void)showProfile{
    [self.theCell.showProfileButton setTitleColor:[UIColor colorWithRed:.7 green:.25 blue:.27 alpha:.4] forState:UIControlStateNormal];
    KnearuProfileViewController *profileController = [[KnearuProfileViewController alloc] init];
    [self.navigationController pushViewController:profileController animated:YES];
}

@end
