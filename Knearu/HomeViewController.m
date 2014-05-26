//
//  HomeViewController.m
//  Nearu
//
//  Created by Matt Kostelecky on 5/10/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "HomeViewController.h"
#import "HomeTableViewController.h"
#import "MapViewController.h"
#import "KnearuLogInViewController.h"
#import "HomeScrollView.h"


@interface HomeViewController ()

@property (weak, nonatomic) UIButton *mapButton;
@property (weak, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UIView *viewForTable;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIButton *showProfileButton;

@property BOOL loggedIn;

@property HomeTableViewController *tableController;

- (void)getNavBarImage;

- (void)getHomeView;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem setHidesBackButton:YES];
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if(!self.loggedIn){
        KnearuLogInViewController *logInController = [[KnearuLogInViewController alloc] init];
        [self presentViewController:logInController animated:NO completion:nil];
    }
    self.tableController = [[HomeTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self getHomeView];
    [self getNavBarImage];
    
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.locationManager startUpdatingLocation];
   // NSLog(@"%@", [UIFont fontNamesForFamilyName:@"Eurofurence"]);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.showProfileButton.layer.shadowOpacity = 0.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *mostRecentLocation = [locations lastObject];
    // How many seconds ago was this new location created?
    NSTimeInterval time = [mostRecentLocation.timestamp timeIntervalSinceNow];
    
    // CLLocationManagers will return the last found location of the
    // device first, you don't want that data in this case.
    // If this location was made more than 3 minutes ago, ignore it.
    if (time < -180) {
        // This is cached data, you don't want it, keep looking
        return;
    }
    NSLog(@"%f, %f heh", mostRecentLocation.coordinate.latitude, mostRecentLocation.coordinate.longitude);
    [self.locationManager stopUpdatingLocation];
}

- (void)getNavBarImage {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,40)];
    
    UIFont *titleFont = [UIFont fontWithName:@"eurofurence light" size:36];
    
    NSString *title = [NSString stringWithFormat:@"knearu"];
    
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,3, 300, 34)];
    
    UINavigationItem *navigationItem = self.navigationItem;
  

    //Set the navigation bar label
    titleLabel.text = navigationItem.title;
    [navLabel setFont:titleFont];
    [navLabel setText:title];
    [navLabel setTextColor:[UIColor blackColor]];
    [navLabel setBackgroundColor:[UIColor clearColor]];
    [navLabel setTextAlignment:NSTextAlignmentCenter];
    navLabel.adjustsFontSizeToFitWidth=YES;
    
    
    //Set ToolBar Color
    [titleLabel addSubview:navLabel];
    //[titleLabel addSubview:homeButton];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.adjustsFontSizeToFitWidth=YES;
    navigationItem.titleView = titleLabel;
    
}

- (void)getHomeView{
    HomeScrollView *scrollView = [[HomeScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    self.view.backgroundColor = [UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1];
    
}

- (void)goHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
