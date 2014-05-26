//
//  MapViewController.m
//  Knearu
//
//  Created by Matt Kostelecky on 5/10/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MapViewController.h"
#import "HomeViewController.h"
#import "KnearuMapAnnotation.h"
#import "PostAnnotationView.h"

@interface MapViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLRegion *currentRegion;
@property (strong, nonatomic) MKMapView *map;
@property (strong, nonatomic) CLLocation *mostRecentLocation;

@property (strong, nonatomic) UIView *postView;
@property (strong, nonatomic) UIView *postLookup;
@property (strong, nonatomic) UITextView *commentTextView;
@property (strong, nonatomic) UILabel *textWarningLabel;
@property (strong, nonatomic) UILabel *postLookupLabel;

@property BOOL tappedPost;
@property KnearuMapAnnotation *pin;
@property PostAnnotationView *annotationView;

@property (strong, nonatomic) UIButton *postButton;
@property (strong, nonatomic) UIButton *cancelPostButton;
@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *takePhoto;

@property (strong, nonatomic) UIView *postColorView;
@property (strong, nonatomic) UILabel *postColorLabel;
@property (strong, nonatomic) NSArray *colorArray;
@property (strong, nonatomic) UIButton *redPost;
@property (strong, nonatomic) UIButton *purplePost;
@property (strong, nonatomic) UIButton *orangePost;
@property (strong, nonatomic) UIButton *bluePost;
@property (strong, nonatomic) UIButton *blackPost;

@property (strong, nonatomic) UIImageView *makePostIcon;
@property (strong, nonatomic) UIImageView *instructionIcon;
@property (strong, nonatomic) UILabel *instructionLabel;

@property BOOL cameraWasUsed;

- (void)getNavBarImage;
- (void)getButtons;
- (void)choosePostColor:(UIButton *)sender;

@end

@implementation MapViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _postButton = [[UIButton alloc] initWithFrame:CGRectMake(85, 20, 320, 30)];
        _makePostIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 16, 16)];
        _cancelPostButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 30, 106, 30)];
        _submitButton = [[UIButton alloc] initWithFrame:CGRectMake(236, 30, 106, 30)];
        _takePhoto = [[UIButton alloc] initWithFrame:CGRectMake(428, 30, 106, 30)];
        _postView = [[UIView alloc] initWithFrame:CGRectMake(0,20,320, 0)];
        _commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(80, 60, 240, 70)];
        _thumbnailPic = [[UIImageView alloc] initWithFrame:CGRectMake(5, 60, 70, 70)];
        _textWarningLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 130, 300, 15)];
        _postLookup = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 0, 0)];
        _instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 0,20)];
        _instructionIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 16, 16)];
        
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 235, 80, 35)];
        
        _postLookupLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 0, 30)];
        _postColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 320, 35)];
        _postColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 140, 25)];
        _redPost = [[UIButton alloc] initWithFrame:CGRectMake(130, 5, 25, 25)];
        _purplePost = [[UIButton alloc] initWithFrame:CGRectMake(165, 5, 25, 25)];
        _orangePost = [[UIButton alloc] initWithFrame:CGRectMake(200, 5, 25, 25)];
        _bluePost = [[UIButton alloc] initWithFrame:CGRectMake(235, 5, 25, 25)];
        _blackPost = [[UIButton alloc] initWithFrame:CGRectMake(270, 5, 25, 25)];
        
        _map = [[MKMapView alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
        _locationManager = [[CLLocationManager alloc] init];
        
        _cameraWasUsed = NO;
        //_imagePicker = [[UIImagePickerController alloc] init];
        //self.imagePicker.delegate = self;
        //self.imagePicker.allowsEditing = YES;
        
        [self.navigationController setDelegate:self];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        
        [self.map setDelegate:self];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
    self.hidesBottomBarWhenPushed = NO;
   
    self.postLookup.layer.shadowOpacity = .5;
    [self.view addSubview:self.map];
    self.map.showsUserLocation = YES;



    self.pin.latitude = [NSNumber numberWithDouble:self.locationManager.location.coordinate.latitude];
    self.pin.longitude = [NSNumber numberWithDouble:self.locationManager.location.coordinate.longitude];
    
    self.commentTextView.scrollEnabled = NO;

    self.currentPostColor = self.redPost.backgroundColor;
    
    [self.instructionLabel addSubview:self.instructionIcon];
    [self.map addSubview:self.instructionLabel];
    


    // 2: Determine if a camera is present and set the source type
    

    [self getNavBarImage];
    [self getButtons];
    
   // self.imagePicker.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.locationManager startUpdatingLocation];
    [self.postView addSubview:self.cancelPostButton];
    [self.map addSubview:self.postButton];
    [self.postView addSubview:self.submitButton];
    [self.map addSubview:self.backButton];
    [self.postView addSubview:self.commentTextView];
    [self.postView addSubview:self.thumbnailPic];
    [self.postView addSubview:self.textWarningLabel];
    [self.postView addSubview:self.postColorView];
    [self.map addSubview:self.postLookupLabel];
    [self.postView addSubview:self.takePhoto];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.locationManager stopUpdatingLocation];
    if(!self.cameraWasUsed){
        [self.commentTextView removeFromSuperview];
        [self.backButton removeFromSuperview];
        [self.thumbnailPic removeFromSuperview];
        [self.textWarningLabel removeFromSuperview];
        [self.postView removeFromSuperview];
        [self.cancelPostButton removeFromSuperview];
        [self.postButton removeFromSuperview];
        [self.postLookup removeFromSuperview];
        [self.postLookupLabel removeFromSuperview];
        [self.submitButton removeFromSuperview];
    }
    
    
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *recentLocation = [locations lastObject];
    // How many seconds ago was this new location created?
    NSTimeInterval time = [recentLocation.timestamp timeIntervalSinceNow];
    NSLog(@"%f, %f ", recentLocation.coordinate.latitude, recentLocation.coordinate.longitude);
    self.mostRecentLocation = recentLocation;
    [self foundLocation:recentLocation];
    // CLLocationManagers will return the last found location of the
    // device first, you don't want that data in this case.
    // If this location was made more than 3 minutes ago, ignore it.
    if (time < -180) {
        // This is cached data, you don't want it, keep looking
        return;
    }
    [self.locationManager stopUpdatingLocation];
}

- (void)findLocation
{
    self.map.showsUserLocation = YES;
    //[self.activityIndicator startAnimating];
}

- (void)foundLocation:(CLLocation *)location
{
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    // Zoom the region to this location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 2050, 2050);
    [self.map setRegion:region animated:NO];
    self.mostRecentLocation = location;
    //[self.activityIndicator stopAnimating];
    //[self.locationManager stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

- (void)dealloc{
    //tell the location manager to stop sending messages.
    [self.locationManager setDelegate:nil];
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

- (void)getButtons{
    
}

- (IBAction)newPost:(UIButton *)sender{
    self.textWarningLabel.text = nil;
    
    /*if(sender.tag == 1){
        self.cancelPostButton.alpha = 1;
        self.submitButton.alpha = 1;
        self.takePhoto.alpha = 1;
        sender.tag = 2;
        [UIView animateWithDuration:0.4
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^ {
     
                             self.cancelPostButton.frame = CGRectMake(0, 30, 106, 30);
                             self.submitButton.frame = CGRectMake(216, 30, 106, 30);
                             self.takePhoto.frame = CGRectMake(108, 30, 106, 30);
                         }
                         completion:^(BOOL finished){
                             if(finished){
                                 self.postButton.titleLabel.font = [UIFont fontWithName:@"Eurofurence" size:22];
                                 [self.postButton setTitle:[NSString stringWithFormat:@"  make a post"] forState:UIControlStateNormal];
                                 [UIView animateWithDuration:0.35
                                                       delay:0.1
                                                     options:UIViewAnimationOptionCurveEaseInOut
                                                  animations:^ {
     
                                                      self.cancelPostButton.frame = CGRectMake(0, 230, 106, 30);
                                                      self.submitButton.frame = CGRectMake(216, 230, 106, 30);
                                                      self.takePhoto.frame = CGRectMake(108, 230, 106, 30);
     
                                                      
                                                  }
                                                  completion:nil];
                             }
                         
                         }];
    }*/
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    
    // in case it's the user location, we already have an annotation, so just return nil
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    if ([annotation isKindOfClass:[KnearuMapAnnotation class]])  // post
    {
        static NSString *postIdentifier = @"post";
    
        self.annotationView =
        (PostAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:postIdentifier];
        if (self.annotationView == nil)
        {
            self.annotationView.postColor = self.currentPostColor;
            self.annotationView = [[PostAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:postIdentifier];
        }
        self.annotationView.mapController = self;
        
        return self.annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView
didAddAnnotationViews:(NSArray *)annotationViews
{
    for (MKAnnotationView *annView in annotationViews)
    {
        CGRect endFrame = annView.frame;
        annView.frame = CGRectOffset(endFrame, 0, -100);
        [UIView animateWithDuration:0.5
                         animations:^{ annView.frame = endFrame; }];
    }
}

- (void)getDatView{

   
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.instructionLabel.frame = CGRectMake(0, 0, 320, 20);
                     }
                     completion:nil];

    self.postButton.enabled = NO;
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.instructionLabel.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             self.instructionLabel.frame = CGRectMake(0, 0, 0, 20);
                             self.instructionLabel.alpha = 1;
                         }
                     }];
    [self.commentTextView resignFirstResponder];

}

/*Helps make sure comments stay at a max of 3 lines. May Change this to just add scrolling cause why not?
 I'lll Tell ya why not have you heard of tweeter? Bet you have only 140 chars gotta write fast to the point.
 
 Also it should help vs ad spammin */
- (BOOL)textView:(UITextView *)aTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.textWarningLabel.text = [NSString stringWithFormat:@""];
    NSUInteger textLength = (aTextView.text.length - range.length) + text.length;
    //Check to see if we got some text in the comment box
    if(textLength > 0){
        //check for newlines, those fuckers count
        //warns that you have went over 3 lines in the comment box and deletes chars until 3 lines are acheived.
        if(textLength > 150){
            self.textWarningLabel.alpha = 1;
            self.textWarningLabel.text = [NSString stringWithFormat:@"warning: comments may have a maximum of 150 chars"];
            [aTextView resignFirstResponder];
            return NO;
        }
    }
    return YES;
}


- (void)choosePostColor:(UIButton *)sender{
    for (UIButton *current in self.colorArray) {
        self.redPost.layer.borderColor = [[UIColor clearColor] CGColor];
        current.layer.borderWidth = 0;
    }
    if(sender.tag == 1){
        self.redPost.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.redPost.layer.borderWidth = 3;
        self.currentPostColor = self.redPost.backgroundColor;
    }
    else if(sender.tag == 2){
        self.purplePost.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.purplePost.layer.borderWidth = 3;
        self.currentPostColor = self.purplePost.backgroundColor;
    }
    else if(sender.tag == 3){
        self.orangePost.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.orangePost.layer.borderWidth = 3;
        self.currentPostColor = self.orangePost.backgroundColor;
    }
    else if(sender.tag == 4){
        self.bluePost.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.bluePost.layer.borderWidth = 3;
        self.currentPostColor = self.bluePost.backgroundColor;
    }
    else if(sender.tag == 5){
        self.blackPost.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.blackPost.layer.borderWidth = 3;
        self.currentPostColor = self.blackPost.backgroundColor;
    }
}

- (void)woop{
    [self.tabBarController setSelectedIndex:0];
}

- (void)getReadyToPicture{
    [self performSelectorInBackground:@selector(takePicture:) withObject:nil];
}

- (void)takePicture:(UIButton *)sender {
     self.cameraWasUsed = YES;
     KnearuCameraViewController *cameraController = [[KnearuCameraViewController alloc] init];
     cameraController.cameraDelegate = self;
   // [self presentViewController:cameraController animated:YES completion:nil];
     [self.navigationController pushViewController:cameraController animated:NO];
    
}

- (void)cameraViewControllerDismissed:(UIImage *)imageFromCamera
{
    NSLog(@"%@", imageFromCamera);
    [self.thumbnailPic setImage:imageFromCamera];
    
  //  self.cameraWasUsed = NO;

}

@end
