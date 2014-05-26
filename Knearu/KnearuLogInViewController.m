//
//  KnearuLogInViewController.m
//  Knearu
//
//  Created by Matt Kostelecky on 7/3/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KnearuLogInViewController.h"

@interface KnearuLogInViewController ()

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) UITextField *userField;
@property (strong, nonatomic) UITextField *passwordField;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *logoLabel;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UIButton *logInButton;
@property (strong, nonatomic) UIButton *createAccountButton;


- (void)doAnimations;

@end

@implementation KnearuLogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _userID = [[NSString alloc] init];
        _password = [[NSString alloc] init];
        _userField = [[UITextField alloc] initWithFrame:CGRectMake(90, 145, 225, 40)];
        _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(90, 195, 225, 40)];
        _logoLabel = [[UILabel alloc]initWithFrame:CGRectMake(1, 106, 320, 80)];
        _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 145, 85, 40)];
        _passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 195, 85, 40)];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        _logInButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 280, 82, 40)];
        _createAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 280, 225, 40)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.logoLabel setBackgroundColor:[UIColor clearColor]];
    [self.logoLabel setTextColor:[UIColor whiteColor]];
    [self.logoLabel setFont:[UIFont fontWithName:@"Eurofurence" size:60]];
    [self.logoLabel setText:@"knearu"];
    self.logoLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.imageView setImage:[UIImage imageNamed:@"NearuLaunchImageClear.png"]];
    
    [self.userNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.userNameLabel setTextColor:[UIColor whiteColor]];
    [self.userNameLabel setFont:[UIFont fontWithName:@"Eurofurence" size:20]];
    [self.userNameLabel setText:@"username"];
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.passwordLabel setBackgroundColor:[UIColor clearColor]];
    [self.passwordLabel setTextColor:[UIColor whiteColor]];
    [self.passwordLabel setFont:[UIFont fontWithName:@"Eurofurence" size:20]];
    [self.passwordLabel setText:@"password"];
    self.passwordLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.userField setBackgroundColor:[UIColor colorWithRed:.85 green:.35 blue:.37 alpha:.7]];
    [self.userField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.userField setFont:[UIFont fontWithName:@"Eurofurence" size:20]];
    [self.userField setTextColor:[UIColor whiteColor]];
    [self.userField setDelegate:self];
    
    [self.passwordField setBackgroundColor:[UIColor colorWithRed:.85 green:.35 blue:.37 alpha:.7]];
    [self.passwordField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.passwordField setFont:[UIFont fontWithName:@"Eurofurence" size:20]];
    [self.passwordField setTextColor:[UIColor whiteColor]];
    [self.passwordField setSecureTextEntry:YES];
    [self.passwordField setDelegate:self];

    [self.logInButton setBackgroundColor:[UIColor colorWithRed:.85 green:.35 blue:.37 alpha:.7]];
    [self.logInButton setTitle:@"log in" forState:UIControlStateNormal];
    [self.logInButton.titleLabel setFont:[UIFont fontWithName:@"Eurofurence" size:20]];
    [self.logInButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchDown];
    [self.logInButton addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    self.logInButton.layer.cornerRadius = 4;
    
    [self.createAccountButton setBackgroundColor:[UIColor colorWithRed:.85 green:.35 blue:.37 alpha:.7]];
    [self.createAccountButton setTitle:@"create an account" forState:UIControlStateNormal];
    [self.createAccountButton.titleLabel setFont:[UIFont fontWithName:@"Eurofurence" size:20]];
    [self.createAccountButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchDown];
    [self.createAccountButton addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    self.createAccountButton.layer.cornerRadius = 4;
    
    self.userNameLabel.alpha = 0;
    self.userField.alpha = 0;
    self.passwordLabel.alpha = 0;
    self.passwordField.alpha = 0;
    self.logInButton.alpha = 0;
    self.createAccountButton.alpha = 0;
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.logoLabel];
    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.userField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.logInButton];
    [self.view addSubview:self.createAccountButton];
    
    [self doAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doAnimations{
    [UIView animateWithDuration:0.4
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.logoLabel.frame = CGRectMake(1, 40, 320, 80);
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             [UIView animateWithDuration:0.4
                                                   delay:0.1
                                                 options:UIViewAnimationOptionCurveEaseInOut
                                              animations:^ {
                                                  self.userNameLabel.alpha = 1;
                                                  self.userField.alpha = 1;
                                                  self.passwordLabel.alpha = 1;
                                                  self.passwordField.alpha = 1;
                                                  self.logInButton.alpha = 1;
                                                  self.createAccountButton.alpha = 1;
                                              }
                                              completion:nil];
                         }
                     }];

}

- (void)buttonSelected:(UIButton *)sender{
    [sender setBackgroundColor:[UIColor colorWithRed:.65 green:.15 blue:.17 alpha:.7]];
}

- (void)goHome{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.userField isFirstResponder]) {
        [self textFieldShouldReturn:self.userField];
    }
    else if ([self.passwordField isFirstResponder]) {
        [self textFieldShouldReturn:self.passwordField];
    }
}
@end
