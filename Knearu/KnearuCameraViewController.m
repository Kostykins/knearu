//
//  KnearuCameraViewController.m
//  Knearu
//
//  Created by Matt Kostelecky on 7/4/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import "KnearuCameraViewController.h"
#import "MapViewController.h"

@interface KnearuCameraViewController ()

@property (nonatomic, strong) UIView *imagePreview;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *takePicture;
@property (nonatomic, strong) UIButton *acceptButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property MapViewController *mapController;

@end

@implementation KnearuCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _imagePreview = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - 53)];
        _takePicture = [[UIButton alloc] initWithFrame:CGRectMake(130, [[UIScreen mainScreen]bounds].size.height - 170, 60, 60)];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height- 48)];
        _acceptButton = [[UIButton alloc] initWithFrame:CGRectMake(255, [[UIScreen mainScreen]bounds].size.height-170, 60, 60)];
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 0, 60, 60)];
        self.imagePreview.backgroundColor = [UIColor clearColor];
        [self.takePicture setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
        [self.takePicture setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.takePicture addTarget:self action:@selector(capturePic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.imagePreview];
    [self.view addSubview:self.takePicture];
    self.navigationController.tabBarController.hidesBottomBarWhenPushed = YES;
    [self getNavBarImage];
}

- (void)viewDidAppear:(BOOL)animated{
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
	session.sessionPreset = AVCaptureSessionPresetMedium;
	
	CALayer *viewLayer = self.imagePreview.layer;
	NSLog(@"viewLayer = %@", viewLayer);
	
	AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
	
	captureVideoPreviewLayer.frame = self.imagePreview.bounds;
	[self.imagePreview.layer addSublayer:captureVideoPreviewLayer];
	
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	
	NSError *error = nil;
	AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
	if (!input) {
		// Handle the error appropriately.
		NSLog(@"ERROR: trying to open camera: %@", error);
	}
	[session addInput:input];
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:self.stillImageOutput];
	[session startRunning];
    
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
- (void)capturePic{
    AVCaptureConnection *videoConnection = nil;
	for (AVCaptureConnection *connection in self.stillImageOutput.connections)
	{
		for (AVCaptureInputPort *port in [connection inputPorts])
		{
			if ([[port mediaType] isEqual:AVMediaTypeVideo] )
			{
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) { break; }
	}
	
	NSLog(@"about to request a capture from: %@", self.stillImageOutput);
	[self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
		 CFDictionaryRef exifAttachments = CMGetAttachment( imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
		 if (exifAttachments)
		 {
             // Do something with the attachments.
             NSLog(@"attachements: %@", exifAttachments);
		 }
         else{
             NSLog(@"no attachments");
         }
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
         
         self.imageView.image = image;
         
         [self acceptOrDeclineImage];
	 }];
}

- (void)acceptOrDeclineImage{
    UIFont *font = [UIFont fontWithName:@"Eurofurencebold" size:48];
    
    self.acceptButton.backgroundColor = [UIColor clearColor];
    self.cancelButton.backgroundColor = [UIColor clearColor];
    
    [self.acceptButton setTitle:@"+" forState:UIControlStateNormal];
    [self.acceptButton.titleLabel setFont:font];
    [self.acceptButton.titleLabel setTextColor:[UIColor whiteColor]];
    [self.acceptButton addTarget:self action:@selector(getPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setTitle:@"x" forState:UIControlStateNormal];
    [self.cancelButton.titleLabel setFont:font];
    [self.cancelButton.titleLabel setTextColor:[UIColor whiteColor]];
    [self.cancelButton addTarget:self action:@selector(cancelPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.acceptButton];
    [self.view addSubview:self.cancelButton];
}

- (void)cancelPhoto{
    [self.acceptButton removeFromSuperview];
    [self.cancelButton removeFromSuperview];
    [self.imageView removeFromSuperview];
}

- (void)getPhoto{
    NSLog(@"%@", self.imageView.image);
   // self.mapController.thumbnailPic.image = self.imageView.image;
    if([self.cameraDelegate respondsToSelector:@selector(cameraViewControllerDismissed:)])
    {
        [self.cameraDelegate cameraViewControllerDismissed:self.imageView.image];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
@end
