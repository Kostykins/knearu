//
//  HomeScrollView.m
//  Knearu
//
//  Created by Matt Kostelecky on 5/23/14.
//  Copyright (c) 2014 Matt Kostelecky. All rights reserved.
//

#import "HomeScrollView.h"
#import "PostView.h"
@interface HomeScrollView ()

@property (strong, nonatomic) UIView *notificationsView;
@property (strong, nonatomic) UIImageView *pictureView;
@property (weak, nonatomic) UIView *postView;


- (void)initializePosts:(NSString *)user;

@end
@implementation HomeScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _notificationsView = [[UIView alloc] initWithFrame:CGRectMake(0, 00, [[UIScreen mainScreen] bounds].size.width, 600)];
        _pictureView = [[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2.35, 20, 48, 48)];
        self.pictureView.backgroundColor = [UIColor lightGrayColor];
        self.notificationsView.backgroundColor = [UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1];
        self.pictureView.layer.cornerRadius = self.pictureView.bounds.size.width/2;
        [self addSubview:self.notificationsView];
        [self.notificationsView addSubview:self.pictureView];
        self.contentSize = self.notificationsView.frame.size;
        [self initializePosts:@"user"];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initializePosts:(NSString *)user{
    for(int i = 0; i < 6; i++){
        PostView *postView = [[PostView alloc] initWithFrame:CGRectMake(0, (90*(i+1)), [[UIScreen mainScreen] bounds].size.width, 80)];
        postView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        postView.layer.shadowOpacity = .2;
        postView.layer.shadowOffset = CGSizeMake(0,1);
        postView.userName.text = @"Fart McBitch";
        postView.locationText.text =  @"at: wendys";
        postView.descriptionText.text = @"wolfin down some nuggets!!! lawl";
        [self addSubview:postView];
    }
}

@end
