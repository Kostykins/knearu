//
//  PostCommentTableViewController.m
//  Nearu
//
//  Created by Matt Kostelecky on 5/15/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PostCommentTableViewController.h"
#import "RecentPostViewController.h"

@interface PostCommentTableViewController ()

@end

@implementation PostCommentTableViewController

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
    self.tableView.separatorColor = [UIColor colorWithRed:.98 green:.87 blue:.81 alpha:1];
    //self.tableView.scrollEnabled = NO;
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *myView = [[UIView alloc] init];
    UIImageView *pictureFrame = [[UIImageView alloc] initWithFrame:CGRectMake(25, 23, 70, 70)];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, -4, 320, 30)];
    UITextView *commentView = [[UITextView alloc] initWithFrame:CGRectMake(100, 23, 240, 70)];
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    nameLabel.font = [UIFont fontWithName:@"eurofurence" size:20];
    nameLabel.text = [NSString stringWithFormat:@"  Jimmy the Timster heyhe"];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    commentView.font = [UIFont fontWithName:@"eurofurence" size:16];
    commentView.text = [NSString stringWithFormat:@"haha ur cool"];
    commentView.textColor = [UIColor blackColor];
    commentView.textAlignment = NSTextAlignmentLeft;
    commentView.editable = NO;
    commentView.backgroundColor = [UIColor colorWithRed:.97 green:.85 blue:.7 alpha:1];
   // commentView.layer.cornerRadius = 5;
    commentView.clipsToBounds = YES;
    
    [pictureFrame setImage:[UIImage imageNamed:@"woopThumb.png"]];
    pictureFrame.layer.masksToBounds = YES;
    pictureFrame.layer.cornerRadius = 3;
    pictureFrame.layer.borderColor = ([[UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1] CGColor]);
    pictureFrame.layer.borderWidth = 3;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    myView.backgroundColor = [UIColor colorWithRed:.98 green:.87 blue:.81 alpha:1];
    cell.backgroundView = myView;
    [cell.contentView addSubview:pictureFrame];
    [cell.contentView addSubview:commentView];
    [cell.contentView addSubview:nameLabel];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
