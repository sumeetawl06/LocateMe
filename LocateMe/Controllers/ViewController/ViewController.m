//
//  ViewController.m
//  LocateMe
//
//  Created by Sumeet Agrawal on 12/17/17.
//  Copyright © 2017 Personal. All rights reserved.
//

#import "ViewController.h"
#import <PureLayout/PureLayout.h>
#import "ToDoViewController.h"
#import "LocateMeViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>

@interface ViewController () <GMSAutocompleteViewControllerDelegate>

@property (nonatomic, strong) UIButton *thingsToDoInLondon;
@property (nonatomic, strong) UIButton *locateMeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:68/255 green:114/255 blue:156/255 alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addLocateMeButton];
    [self addThingsToDoInLondon];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UI creation

- (void)addLocateMeButton {
    
    _locateMeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locateMeButton setTitle:@"Locate Me" forState:UIControlStateNormal];
    [_locateMeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_locateMeButton setBackgroundColor:[UIColor colorWithRed:246/255 green:246/255 blue:246/255 alpha:0]];
    [_locateMeButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    _locateMeButton.layer.borderColor = [UIColor grayColor].CGColor;
    _locateMeButton.layer.borderWidth = 1.0;
    _locateMeButton.layer.cornerRadius = 2.0;
    
    [_locateMeButton addTarget:self action:@selector(locateMeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_locateMeButton];

    [_locateMeButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:(self.view.frame.size.height)/2-50];
    [_locateMeButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [_locateMeButton autoSetDimensionsToSize:CGSizeMake(150, 40)];
}

- (void)addThingsToDoInLondon {
    
    _thingsToDoInLondon = [UIButton buttonWithType:UIButtonTypeCustom];
    [_thingsToDoInLondon setTitle:@"Things to do in london" forState:UIControlStateNormal];
    [_thingsToDoInLondon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_thingsToDoInLondon.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_thingsToDoInLondon setBackgroundColor:[UIColor colorWithRed:246/255 green:246/255 blue:246/255 alpha:0]];
    
    _thingsToDoInLondon.layer.borderColor = [UIColor grayColor].CGColor;
    _thingsToDoInLondon.layer.borderWidth = 1.0;
    _thingsToDoInLondon.layer.cornerRadius = 2.0;
    
    [_thingsToDoInLondon addTarget:self action:@selector(thingsToDoInLondonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_thingsToDoInLondon];
    [_thingsToDoInLondon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:(self.view.frame.size.height)/2+50];    [_thingsToDoInLondon autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [_thingsToDoInLondon autoSetDimensionsToSize:CGSizeMake(150, 40)];
}

- (void)locateMeButtonTapped {
    
    LocateMeViewController *locateMeViewController = [[LocateMeViewController alloc]init];
    [self.navigationController pushViewController:locateMeViewController animated:YES];
    [self setTitle:@"Locate Me"];

}

- (void)thingsToDoInLondonTapped {
    
    ToDoViewController *toDoViewController = [[ToDoViewController alloc]init];
    [self.navigationController pushViewController:toDoViewController animated:YES];
    [self setTitle:@"To Do"];
}
@end
