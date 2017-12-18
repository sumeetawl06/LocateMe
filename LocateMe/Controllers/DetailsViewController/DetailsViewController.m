//
//  DetailsViewController.m
//  LocateMe
//
//  Created by Sumeet Agrawal on 12/17/17.
//  Copyright © 2017 Personal. All rights reserved.
//

#import "DetailsViewController.h"
#import <PureLayout/PureLayout.h>

@interface DetailsViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *streetAddress;
@property (nonatomic, strong) UITextView *details;
@property (nonatomic, strong) UIImageView *mapImageView;
@property (nonatomic, strong) UIButton *directionButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.title = @"Ben Den";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self addImageView];
    [self addTitleLabel];
    [self addStreetAddress];
    [self addDirectionButton];
    [self addMapImageView];
    [self addDetails];
}

- (void)addImageView {
    
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"image%lu",(unsigned long)_imageNumber]]];
    [self.view addSubview:_imageView];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_imageView autoSetDimension:ALDimensionHeight toSize:180];
    
}

- (void)addTitleLabel {
    
    _titleLabel = [[UILabel alloc]init];
    [_titleLabel setFont:[UIFont systemFontOfSize:19]];
    [_titleLabel setTextColor:[UIColor colorWithRed:68/255 green:114/255 blue:156/255 alpha:1]];
    [_titleLabel setText:@"Ben Den"];
    [self.view addSubview:_titleLabel];
    [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imageView withOffset:10];
    [_titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
}

- (void)addStreetAddress {
    
    _streetAddress = [[UILabel alloc]init];
    [_streetAddress setFont:[UIFont systemFontOfSize:19]];
    [_streetAddress setTextColor:[UIColor colorWithRed:103/255 green:103/255 blue:103/255 alpha:1]];
    [_streetAddress setText:@"London SW1 1OAA"];
    [self.view addSubview:_streetAddress];
    [_streetAddress autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel withOffset:10];
    [_streetAddress autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
}

- (void)addDetails {
    
    _details = [[UITextView alloc]init];
    [_details setFont:[UIFont systemFontOfSize:13]];
    [_details setText:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."];
    [self.view addSubview:_details];
    [_details autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_streetAddress withOffset:10];
    [_details autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_details autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_details autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_mapImageView withOffset:-10];
}

- (void)addMapImageView {
    
    _mapImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mapview"]];
    [self.view addSubview:_mapImageView];
    [_mapImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_directionButton withOffset:-10];
    [_mapImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_mapImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_mapImageView autoSetDimension:ALDimensionHeight toSize:100];
}

- (void)addDirectionButton {
    
    _directionButton = [[UIButton alloc]init];
    [_directionButton setBackgroundColor:[UIColor colorWithRed:68/255 green:114/255 blue:156/255 alpha:1]];
    [_directionButton setTitle:@"Direction" forState:UIControlStateNormal];
    _directionButton.layer.cornerRadius = 3.0;
    [self.view addSubview:_directionButton];
    [_directionButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_directionButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_directionButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_directionButton autoSetDimension:ALDimensionHeight toSize:28];
    
}

@end
