//
//  KnearuAppDelegate.m
//  Knearu
//
//  Created by Matt Kostelecky on 6/17/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import "KnearuAppDelegate.h"
#import "HomeViewController.h"
#import "MapViewController.h"

@implementation KnearuAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIButton *mapButton = [[UIButton alloc] initWithFrame:CGRectMake(320-74, 30, 64, 64)];
    [mapButton setImage:[UIImage imageNamed:@"mapButton.png"] forState:UIControlStateNormal];
    UIButton *profileButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 64, 64)];
    mapButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    mapButton.layer.shadowRadius = 2;
    mapButton.layer.shadowOpacity = .5;
    mapButton.layer.shadowOffset = CGSizeMake(0, 1);
    profileButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    profileButton.layer.shadowRadius = 3;
    profileButton.layer.shadowOpacity = .5;
    profileButton.layer.shadowOffset = CGSizeMake(0, 1);

    [profileButton setImage:[UIImage imageNamed:@"profileButton.png"] forState:UIControlStateNormal];
    [self.window addSubview:mapButton];
    [self.window addSubview:profileButton];
    HomeViewController *homeController = [[HomeViewController alloc] init];
    MapViewController *mapController = [[MapViewController alloc] init];
    NSMutableArray *navControllers = [[NSMutableArray alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeController];
    [navControllers addObject:navigationController];
    UINavigationController *mapNavController = [[UINavigationController alloc] initWithRootViewController:mapController];
    [navControllers addObject:mapNavController];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = navControllers;
    
    [mapController viewDidLoad];
    //[homeController view];
    //[mapController view];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    [self.window bringSubviewToFront:mapButton];
    [self.window bringSubviewToFront:profileButton];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
