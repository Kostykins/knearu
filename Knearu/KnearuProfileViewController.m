//
//  KnearuProfileViewController.m
//  Knearu
//
//  Created by Matt Kostelecky on 7/7/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import "KnearuProfileViewController.h"
#import "RecentActivityTableViewController.h"
#import "RecentPostViewController.h"
#import "HomeTableViewController.h"

@interface KnearuProfileViewController ()

@property (strong, nonatomic) UIImageView *profilePic;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UITableView *tableView;
@property HomeTableViewController *recentActivityTableController;

@end

@implementation KnearuProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 200, 30)];
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 30, 195, 30)];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, 320, [[UIScreen mainScreen] bounds].size.height - 150)];
        _recentActivityTableController = [[HomeTableViewController alloc] initWithStyle:UITableViewStylePlain];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self getNavBarImage];
    [self makeViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNavBarImage {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,40)];
    
    UIFont *titleFont = [UIFont fontWithName:@"Eurofurence" size:36];
    
    NSString *title = [NSString stringWithFormat:@"knearu"];
    
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(160,3, 300, 34)];
    
    UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 11, 34, 34)];
    
    homeButton.backgroundColor = [UIColor clearColor];
    [homeButton setBackgroundImage:[UIImage imageNamed:@"homeIcon.png"] forState:UIControlStateNormal];
    [homeButton addTarget:self.navigationController action:@selector(popToRootViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backHome = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.leftBarButtonItem = backHome;
    //Set the navigation bar label
    titleLabel.text = navigationItem.title;
    [navLabel setFont:titleFont];
    [navLabel setText:title];
    [navLabel setTextColor:[UIColor whiteColor]];
    [navLabel setBackgroundColor:[UIColor clearColor]];
    [navLabel setTextAlignment:NSTextAlignmentLeft];
    navLabel.adjustsFontSizeToFitWidth=YES;
    
    
    //Set ToolBar Color
    UIImage *toolBarImage = [UIImage imageNamed:@"NavBar2.png"];
    
    [[self.navigationController navigationBar] setBackgroundImage:toolBarImage forBarMetrics:UIBarMetricsDefault];
    
    [titleLabel addSubview:navLabel];
    //[titleLabel addSubview:homeButton];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentRight];
    titleLabel.adjustsFontSizeToFitWidth=YES;
    navigationItem.titleView = titleLabel;
}

- (void)makeViews{
    self.profilePic.frame = CGRectMake(10, 10, 50, 50);
    self.nameLabel.frame = CGRectMake(70, 4, 200, 30);
    self.descriptionLabel.frame = CGRectMake(75, 30, 195, 30);
    self.tableView.frame = CGRectMake(0, 70, 320, [[UIScreen mainScreen] bounds].size.height - 150);
    
    
    self.nameLabel.font = [UIFont fontWithName:@"eurofurence" size:20];
    self.nameLabel.text = [NSString stringWithFormat:@"person hopalicious"];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.alpha = .8;
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.descriptionLabel.font = [UIFont fontWithName:@"eurofurence light" size:16];
    self.descriptionLabel.text = [NSString stringWithFormat:@"butt chuggin"];
    self.descriptionLabel.textColor = [UIColor blackColor];
    self.descriptionLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.profilePic setImage:[UIImage imageNamed:@"Woopame.jpg"]];
    self.profilePic.layer.cornerRadius = 3;
    self.profilePic.layer.masksToBounds = YES;
    self.profilePic.layer.borderColor = ([[UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1] CGColor]);
    self.profilePic.layer.borderWidth = 2;

    [self.view setBackgroundColor:[UIColor colorWithRed:.98 green:.87 blue:.81 alpha:1]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:.98 green:.87 blue:.81 alpha:1]];
    [self.tableView setDelegate:self.recentActivityTableController];
    [self.tableView setDataSource:self.recentActivityTableController];
  //  [self.viewForTable addSubview:self.recentActivityTableController.view];
    [self addChildViewController:self.recentActivityTableController];

    
    [self.recentActivityTableController setTableView:self.tableView];
    
    [self.view addSubview:self.profilePic];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.tableView];
}

@end
