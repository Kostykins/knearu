//
//  RecentPostViewController.m
//  Nearu
//
//  Created by Matt Kostelecky on 5/15/13.
//  Copyright (c) 2013 Matt Kostelecky. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RecentPostViewController.h"
#import "PostCommentTableViewController.h"

@interface RecentPostViewController ()

@property (strong, nonatomic) UIButton *postCommentButton;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *donePostingButton;
@property (strong, nonatomic) UIView *commentView;
@property (strong, nonatomic) UITextView *commentTextView;
@property (strong, nonatomic) UIImageView *thumbnailPic;
@property (strong, nonatomic) UILabel *textWarningLabel;
@property NSUInteger lineCount;
@property NSUInteger previousTextLength;

- (void)getNavBarImage;

- (void)getHomeView;

@end

@implementation RecentPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _lineCount = 0;
        _previousTextLength = 0;
        [self.navigationItem setHidesBackButton:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getNavBarImage];
    [self getHomeView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if(self.postCommentButton.frame.origin.y != 92 && self.commentView.frame.size.height == 0){
      self.postCommentButton.frame = CGRectMake(170, 92, 100, 30);
      self.postCommentButton.enabled = YES;
    }
    [self.view addSubview:self.commentView];
    [self.view addSubview:self.commentTextView];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.donePostingButton];
    [self.view addSubview:self.thumbnailPic];
    [self.view addSubview:self.textWarningLabel];
    [self.view addSubview:self.postCommentButton];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
   /* [self.commentView removeFromSuperview];
    [self.commentTextView removeFromSuperview];
    [self.backButton removeFromSuperview];
    [self.donePostingButton removeFromSuperview];
    [self.thumbnailPic removeFromSuperview];
    [self.textWarningLabel removeFromSuperview];
    [self.postCommentButton removeFromSuperview];
    */
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
    [homeButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
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


- (void)getHomeView{
    self.postCommentButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 92, 100, 30)];
    self.commentView = [[UIView alloc] initWithFrame:CGRectMake(0,122,320, 0)];
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 162, 80, 40)];
    self.donePostingButton = [[UIButton alloc] initWithFrame:CGRectMake(240, [[UIScreen mainScreen] bounds].size.height - 162, 80, 40)];
    self.commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(80, 136, 240, 70)];
    self.thumbnailPic = [[UIImageView alloc] initWithFrame:CGRectMake(5, 136, 70, 70)];
    self.textWarningLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 206, 300, 15)];
    UIImageView *pictureFrame = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 82)];
    UIView *recentActivityTopLine = [[UIView alloc] initWithFrame:CGRectMake(0, 92, 320, 3)];
    UIView *seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 119, 320, 3)];
    UIView *descriptionBox = [[UIView alloc] initWithFrame:CGRectMake(120, 0, 240, 95)];
    UILabel *recentPostsBar = [[UILabel alloc] initWithFrame:CGRectMake(0, 92, 320, 30)];
    UILabel *activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 210, 30)];
    UITextView *activityDescription = [[UITextView alloc] initWithFrame:CGRectMake(120, 23, 200, 65)];
    UIView *viewForTable = [[UIView alloc] initWithFrame:CGRectMake(-20,122,340, [[UIScreen mainScreen] bounds].size.height - 172)];
    UITableView *postCommentTableView = [[UITableView alloc] initWithFrame:CGRectMake(-20,122,340, [[UIScreen mainScreen] bounds].size.height - 222) style:UITableViewStylePlain];
    PostCommentTableViewController *tableController = [[PostCommentTableViewController alloc] initWithStyle:UITableViewStylePlain];

    
    
    [self.view setBackgroundColor: [UIColor colorWithRed:.98 green:.87 blue:.81 alpha:1]];
    descriptionBox.backgroundColor = [UIColor clearColor];
    [pictureFrame setImage:[UIImage imageNamed:@"Woopame.jpg"]];
    pictureFrame.layer.borderColor = ([[UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1] CGColor]);
    pictureFrame.layer.masksToBounds = YES;
    pictureFrame.layer.cornerRadius = 3;
    pictureFrame.layer.borderWidth = 3;
    
    recentActivityTopLine.backgroundColor = [UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1];
    
    seperatorLine.backgroundColor = [UIColor colorWithRed:.7 green:.25 blue:.27 alpha:.8];
    seperatorLine.layer.shadowColor = [[UIColor blackColor] CGColor];
    seperatorLine.layer.shadowOffset = CGSizeMake(0, 3);
    seperatorLine.layer.shadowOpacity = 0.5;
    
    activityLabel.font = [UIFont fontWithName:@"Eurofurence" size:20];
    
    activityLabel.text = [NSString stringWithFormat:@"   found twenty dollas"];
    activityLabel.textColor = [UIColor whiteColor];
    activityLabel.textAlignment = NSTextAlignmentLeft;
    activityLabel.backgroundColor = [UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1];

    activityDescription.font = [UIFont fontWithName:@"Eurofurence Light" size:17];
    activityDescription.text = [NSString stringWithFormat:@"i found twenty dollas in my pocket but it is not awesome and my legs hurt."];
    activityDescription.textColor = [UIColor blackColor];
    activityDescription.backgroundColor = [UIColor clearColor];
    activityDescription.editable = NO;
    activityDescription.scrollEnabled = NO;

    
    recentPostsBar.textColor = [UIColor whiteColor];
    recentPostsBar.font = [UIFont fontWithName:@"eurofurence" size:22];
    recentPostsBar.text = [NSString stringWithFormat:@"  comments  "];
    recentPostsBar.backgroundColor = [UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1];
    recentPostsBar.textAlignment = NSTextAlignmentLeft;
    recentPostsBar.layer.masksToBounds = YES;
    
    self.postCommentButton.backgroundColor = [UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1];
    self.postCommentButton.titleLabel.font = [UIFont fontWithName:@"eurofurence" size:22];
    [self.postCommentButton setTitle:[NSString stringWithFormat:@" + "] forState:UIControlStateNormal];
    self.postCommentButton.titleLabel.textColor = [UIColor whiteColor];
    [self.postCommentButton addTarget:self action:@selector(postNewComment:) forControlEvents:UIControlEventTouchUpInside];
    self.postCommentButton.tag = 1;
    
    self.donePostingButton.backgroundColor = [UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1];
    self.donePostingButton.titleLabel.font = [UIFont fontWithName:@"eurofurence" size:22];
    [self.donePostingButton setTitle:[NSString stringWithFormat:@"  post  "] forState:UIControlStateNormal];
    self.donePostingButton.titleLabel.textColor = [UIColor whiteColor];
    self.donePostingButton.tag = 3;
    [self.donePostingButton addTarget:self action:@selector(postNewComment:) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentTextView.font = [UIFont fontWithName:@"Eurofurence" size:16];
    self.commentTextView.clipsToBounds = YES;
    self.commentTextView.backgroundColor =  [UIColor colorWithRed:.96 green:.82 blue:.79 alpha:1];
    
    
    [self.thumbnailPic setImage:[UIImage imageNamed:@"Woopame.jpg"]];
    self.thumbnailPic.layer.borderColor = ([[UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1] CGColor]);
    self.thumbnailPic.layer.masksToBounds = YES;
    self.thumbnailPic.layer.cornerRadius = 3;
    self.thumbnailPic.layer.borderWidth = 3;
    
    self.textWarningLabel.backgroundColor = [UIColor clearColor];
    self.textWarningLabel.textColor = [UIColor redColor];
    self.textWarningLabel.font = [UIFont fontWithName:@"eurofurence" size:14];

    postCommentTableView.backgroundColor = [UIColor colorWithRed:.98 green:.87 blue:.81 alpha:1];
    self.postCommentButton.alpha = 0;
    self.backButton.alpha = 0;
    self.donePostingButton.alpha = 0;
    postCommentTableView.alpha = 0;
    self.commentTextView.alpha = 0;
    self.thumbnailPic.alpha = 0;
    self.textWarningLabel.alpha = 0;
    
    [tableController setTableView:postCommentTableView];
    [postCommentTableView setDelegate:tableController];
    [postCommentTableView setDataSource:tableController];
    [viewForTable addSubview:tableController.view];
    
    [self addChildViewController:tableController];
    [self.commentTextView setDelegate:self];
    
    [self.view addSubview:pictureFrame];
    [self.view addSubview:descriptionBox];
    [self.view addSubview:postCommentTableView];
    [self.view addSubview:activityLabel];
    [self.view addSubview:activityDescription];
    [self.view addSubview:recentPostsBar];
    [UIView animateWithDuration:0.6
                          delay:0.4  
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.postCommentButton.alpha = .7;
                         postCommentTableView.alpha = 1;
                     }
                     completion:nil];

}

/* postNewComment: animates the "post a comment" button and gets the view ready to enable the user to post a comment 
  for a recent activity (any post that is not a comment). */
-(IBAction)postNewComment:(UIButton *)sender {
    sender.alpha = 1;
    self.commentView.backgroundColor = [UIColor colorWithRed:.98 green:.87 blue:.81 alpha:1];
    self.backButton.backgroundColor = [UIColor colorWithRed:.7 green:.25 blue:.27 alpha:1];
    self.backButton.titleLabel.font = [UIFont fontWithName:@"eurofurence" size:22];
    [self.backButton setTitle:[NSString stringWithFormat:@"  cancel  "] forState:UIControlStateNormal];
    self.backButton.titleLabel.textColor = [UIColor whiteColor];
    self.backButton.tag = 2;
    [self.backButton addTarget:self action:@selector(postNewComment:) forControlEvents:UIControlEventTouchUpInside];
    
    /*Hehhaheuhauheuahueheauh Welcome to the animation zone.
     
     if the tag is 1 that means the post comment button was pressed, if the button tag is 2 that cancel button was pressed. This decided which animation will occur. */
    if(sender.tag == 1){

        [UIView animateWithDuration:0.35
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^ {
                             self.postCommentButton.frame = CGRectMake(0, 92, 320, 30);
                         }
                         completion:^(BOOL finished){
                             if(finished){
                                 [UIView animateWithDuration:0.35
                                                       delay:0
                                                     options:UIViewAnimationOptionCurveEaseInOut
                                                  animations:^ {
                                                      self.commentView.frame =  CGRectMake(0,122,320, [[UIScreen mainScreen] bounds].size.height - 172);
                                                      self.backButton.alpha = 1;
                                                      self.commentTextView.alpha = 1;
                                                      self.thumbnailPic.alpha = 1;
                                                      self.donePostingButton.alpha = 1;
                                                  }
                                                  completion:nil];
                                                  
                             }
                         }];
        self.postCommentButton.enabled = NO;
        self.backButton.enabled = YES;
        self.donePostingButton.enabled = YES;
    }
    else if(sender.tag == 2){
        [UIView animateWithDuration:0.35
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^ {
                             self.commentView.frame = CGRectMake(0,122,320,0);
                             self.backButton.alpha = 0;
                             self.commentTextView.alpha = 0;
                             self.thumbnailPic.alpha = 0;
                             self.donePostingButton.alpha = 0;
                             self.textWarningLabel.alpha = 0;
                             
                         }
                         completion:^(BOOL finished){
                             if(finished){
                                 [UIView animateWithDuration:0.35
                                                       delay:0
                                                     options:UIViewAnimationOptionCurveEaseInOut
                                                  animations:^ {
                                                      self.postCommentButton.frame = CGRectMake(220, 92, 100, 30);
                                                  }
                                                  completion:nil];
                                                      }
            
        }];
        
        self.postCommentButton.enabled = YES;
        self.backButton.enabled = NO;
        self.donePostingButton.enabled = NO;
    }
    else if(sender.tag == 3){
        //check to see if post has content (something other than whitespace)
        NSString *rawString = [self.commentTextView text];
        NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
        if ([trimmed length] == 0) {
            self.textWarningLabel.alpha = 1;
            self.textWarningLabel.text = [NSString stringWithFormat:@"warning: posts must have content."];
            return;
        }
        
        [UIView animateWithDuration:0.35
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^ {
                             self.commentView.frame = CGRectMake(0,122,320,0);
                             self.backButton.alpha = 0;
                             self.commentTextView.alpha = 0;
                             self.thumbnailPic.alpha = 0;
                             self.donePostingButton.alpha = 0;
                             self.textWarningLabel.alpha = 0;
                             
                         }
                         completion:^(BOOL finished){
                             if(finished){
                                 [UIView animateWithDuration:0.35
                                                       delay:0
                                                     options:UIViewAnimationOptionCurveEaseInOut
                                                  animations:^ {
                                                      self.postCommentButton.frame = CGRectMake(220, 92, 100, 30);
                                                  }
                                                  completion:nil];
                             }
                             
                         }];        self.postCommentButton.enabled = YES;
        self.commentTextView.text = nil;
    }

    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    return YES;
    
}

/* checks to see if the view has been tapped. If a comment is being typed and the background is tapped, resign the keyboard and check to see how many lines have been typed. Like the shouldChangeTextInRange method below, touchesBegan will make sure the comment is at most 3 lines to ensure all text can be seen. */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.commentTextView resignFirstResponder];
}

/*Helps make sure comments stay at a max of 3 lines. May Change this to just add scrolling cause why not?
    I'lll Tell ya why not have you heard of tweeter? Bet you have only 140 chars gotta write fast to the point.
 
 Also it should help vs ad spammin */
- (BOOL)textView:(UITextView *)aTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.textWarningLabel.text = [NSString stringWithFormat:@""];
    NSUInteger textLength = (aTextView.text.length - range.length) + text.length;
    NSLog(@"%d", textLength);
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

@end
