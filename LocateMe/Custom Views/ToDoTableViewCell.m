//
//  ToDoTableViewCell.m
//  LocateMe
//
//  Created by Sumeet Agrawal on 12/17/17.
//  Copyright © 2017 Personal. All rights reserved.
//

#import "ToDoTableViewCell.h"
#import <PureLayout/PureLayout.h>

@implementation ToDoTableViewCell

@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createView];
    }
    return self;
}

- (void)createView {
    
    [self addImageView];
    [self addTitleLabel];
    [self addStreetAddressLabel];
    [self addSeparatorView];
}

- (void)addImageView {
    
    imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    [imageView autoSetDimensionsToSize:CGSizeMake(100, 64)];
    [imageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    
}

- (void)addTitleLabel {
    
    _titleLabel = [[UILabel alloc]init];
    [_titleLabel setFont:[UIFont systemFontOfSize:19]];
    [_titleLabel setTextColor:[UIColor colorWithRed:68/255 green:114/255 blue:156/255 alpha:1]];
    [self addSubview:_titleLabel];
    [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:imageView withOffset:7];
    [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imageView withOffset:10];
    
}

- (void)addStreetAddressLabel {
    
    _streetAddressLabel = [[UILabel alloc]init];
    [_streetAddressLabel setFont:[UIFont systemFontOfSize:19]];
    [_streetAddressLabel setTextColor:[UIColor colorWithRed:103/255 green:103/255 blue:103/255 alpha:1]];
    [self addSubview:_streetAddressLabel];
    [_streetAddressLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:imageView withOffset:-7];
    [_streetAddressLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imageView withOffset:10];
    
}

- (void)addSeparatorView {
    
    UIView *separator = [[UIView alloc]init];
    [separator setBackgroundColor: [UIColor colorWithDisplayP3Red:200/255 green:200/255 blue:200/255 alpha:0.4]];
    [self addSubview:separator];
    [separator autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [separator autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [separator autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [separator autoSetDimension:ALDimensionHeight toSize:1.0];
}

@end
