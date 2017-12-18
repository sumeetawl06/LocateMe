//
//  LocateMeViewController.m
//  LocateMe
//
//  Created by Sumeet Agrawal on 12/17/17.
//  Copyright © 2017 Personal. All rights reserved.
//

#import "LocateMeViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <PureLayout/PureLayout.h>

#define CURRENT_CITY @"CURRENT"
#define DESTINATION_CITY @"DESTINATION"

@interface LocateMeViewController ()<CLLocationManagerDelegate, GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UILabel *startLabel;
@property (nonatomic, strong) UILabel *destinationLabel;
@property (nonatomic, strong) UITextField *currnetLocationText;
@property (nonatomic, strong) UITextField *destincationCityTextField;

@property (nonatomic, strong) CLLocationManager *locationManager;
//@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) GMSMapView *mapView;
//@property (nonatomic, strong) GMSPlacesClient *placesClient;
//@property (nonatomic, assign) CGFloat zoomLevel;
//@property (nonatomic, strong) NSMutableArray *likelyPlaces;
//@property (nonatomic, strong) GMSPlace *selectedPlace;
//
//@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *textfieldType;
@property (nonatomic, strong) GMSPlace *currentCityObject;
@property (nonatomic, strong) GMSPlace *destinationCityObject;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) GMSMarker *currentMarker;


@property (nonatomic, strong) NSMutableArray *routesArray;
@property (nonatomic, strong) GMSPolyline *polyline;


@end

@implementation LocateMeViewController

- (void)launchAutoComplete {
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self addStartLabel];
    [self addCurrnetLocationText];
    [self addDestinationLabel];
    [self addDestincationCityTextField];
    [self initiliateLocationManager];
//    _zoomLevel = 15.0;
//    [self initiliateLocationManager];
//    [self loadView];
}

#pragma mark - UI Creation

- (void)addStartLabel {
    
    _startLabel = [[UILabel alloc]init];
    [_startLabel setText:@"From"];
    [_startLabel setFont:[UIFont systemFontOfSize:15]];
    [_startLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:_startLabel];
    
    [_startLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:70];
    [_startLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_startLabel autoSetDimensionsToSize:CGSizeMake(50, 40)];
    
}

- (void)addCurrnetLocationText {
    
    _currnetLocationText = [[UITextField alloc]init];
    _currnetLocationText.layer.borderColor = [UIColor grayColor].CGColor;
    _currnetLocationText.layer.borderWidth = 1.0;
    _currnetLocationText.delegate = self;
    _currnetLocationText.layer.cornerRadius = 3.0;
    
    [self.view addSubview:_currnetLocationText];

    [_currnetLocationText autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_startLabel];
    [_currnetLocationText autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_startLabel withOffset:20];
    [_currnetLocationText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_currnetLocationText autoSetDimension:ALDimensionHeight toSize:40];
}

- (void)addDestinationLabel {
    
    _destinationLabel = [[UILabel alloc]init];
    [_destinationLabel setText:@"To"];
    [_destinationLabel setTextColor:[UIColor blackColor]];
    [_destinationLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:_destinationLabel];
    [_destinationLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_currnetLocationText withOffset:20];
    [_destinationLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_destinationLabel autoSetDimensionsToSize:CGSizeMake(50, 40)];

}

- (void)addDestincationCityTextField {
    
    _destincationCityTextField = [[UITextField alloc]init];
    _destincationCityTextField.layer.borderColor = [UIColor grayColor].CGColor;
    _destincationCityTextField.layer.borderWidth = 1.0;
    _destincationCityTextField.delegate = self;
    _destincationCityTextField.layer.cornerRadius = 3.0;
    
    [self.view addSubview:_destincationCityTextField];
    [_destincationCityTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_destinationLabel];
    [_destincationCityTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_destinationLabel withOffset:20];
    [_destincationCityTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [_destincationCityTextField autoSetDimension:ALDimensionHeight toSize:40];
}

- (void)addMapViewWithLocation:(CLLocation *)location {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                            longitude:location.coordinate.longitude
                                                                 zoom:15];

    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    _mapView.settings.myLocationButton = true;
    _mapView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.map = _mapView;

    
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [_mapView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_destincationCityTextField withOffset:30];
    [_mapView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_mapView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_mapView autoPinEdgeToSuperviewEdge:ALEdgeRight];

}

#pragma mark - Private Methods

- (void)addGMSMarker:(GMSPlace *)place {
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = place.name;
    marker.map = _mapView;
}

- (void)drawPath {
    
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:CLLocationCoordinate2DMake(self.currentCityObject.coordinate.latitude, self.currentCityObject.coordinate.longitude)];
    [path addCoordinate:CLLocationCoordinate2DMake(self.destinationCityObject.coordinate.latitude, self.destinationCityObject.coordinate.longitude)];
    
    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
    rectangle.map = _mapView;
    
}

- (void)initiliateLocationManager {
    
    _locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.distanceFilter = 50;
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Location Manager Delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations lastObject];
    NSLog(@"Location %@", location);
    [self addMapViewWithLocation:location];
    self.currentLocation = location;
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    _currentMarker = [GMSMarker markerWithPosition:position];
    _currentMarker.map = _mapView;

}

#pragma mark - TextField Delegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == self.currnetLocationText) {
        
        self.textfieldType = CURRENT_CITY;
    }else if (textField == self.destincationCityTextField) {
        
        self.textfieldType = DESTINATION_CITY;
    }
    [self launchAutoComplete];
}

#pragma mark - AutoComplete Delegate

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([CURRENT_CITY isEqualToString:self.textfieldType]) {
        
        self.currnetLocationText.text = [NSString stringWithFormat:@"%@", place.formattedAddress];
        _currentCityObject = place;
        
        [_mapView clear];
        
        self.currentMarker.position = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude);
        self.currentMarker.map = _mapView;
        [_mapView animateToLocation:self.currentMarker.position];

    }else if ([DESTINATION_CITY isEqualToString:self.textfieldType]) {
        
        self.destincationCityTextField.text = [NSString stringWithFormat:@"%@", place.formattedAddress];
        _destinationCityObject = place;
        [self addGMSMarker:place];
        [self drawPath];
        [self fetchPolylineWithOrigin:[[CLLocation alloc]initWithLatitude:self.currentCityObject.coordinate.latitude longitude:self.currentCityObject.coordinate.longitude] destination:[[CLLocation alloc]initWithLatitude:self.destinationCityObject.coordinate.latitude longitude:self.destinationCityObject.coordinate.longitude] completionHandler:nil];
    }
    
    [self.view endEditing:YES];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    // TODO: handle the error.
    NSLog(@"error: %ld", [error code]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    NSLog(@"Autocomplete was cancelled.");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)fetchPolylineWithOrigin:(CLLocation *)origin destination:(CLLocation *)destination completionHandler:(void (^)(GMSPolyline *))completionHandler
{
    NSString *originString = [NSString stringWithFormat:@"%f,%f", origin.coordinate.latitude, origin.coordinate.longitude];
    NSString *destinationString = [NSString stringWithFormat:@"%f,%f", destination.coordinate.latitude, destination.coordinate.longitude];
    NSString *directionsAPI = @"https://maps.googleapis.com/maps/api/directions/json?";
    NSString *directionsUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&mode=driving", directionsAPI, originString, destinationString];
    NSURL *directionsUrl = [NSURL URLWithString:directionsUrlString];
    
    NSURLSessionDataTask *fetchDirectionsTask = [[NSURLSession sharedSession] dataTaskWithURL:directionsUrl completionHandler:
                                                 ^(NSData* data, NSURLResponse* response, NSError *error)
                                                 {
                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                     if(error)
                                                     {
                                                         if(completionHandler)
                                                             completionHandler(nil);
                                                         return;
                                                     }
                                                     _routesArray = [json objectForKey:@"routes"];
                                                     dispatch_sync(dispatch_get_main_queue(), ^{
//                                                         currentPoly.map = nil;
                                                         NSString *points;
                                                         if ([_routesArray count] > 0)
                                                         {
                                                             NSDictionary *routeDict = [_routesArray objectAtIndex:0];
                                                             NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
                                                             points = [routeOverviewPolyline objectForKey:@"points"];
                                                         }
                                                         GMSPath *path = [GMSPath pathFromEncodedPath:points];
                                                         _polyline = [GMSPolyline polylineWithPath:path];
                                                         _polyline.strokeWidth = 4.f;
                                                         _polyline.strokeColor = [UIColor colorWithRed:0.2043 green:0.6188 blue:0.9986 alpha:1.0000];
                                                         _polyline.geodesic = YES;
                                                         _polyline.map = _mapView;
//                                                         currentPoly = _polyline;
//                                                         [self distance:place_Id];
                                                         if(completionHandler)
                                                             completionHandler(_polyline);
                                                     });
                                                 }];
    [fetchDirectionsTask resume];
}

@end
