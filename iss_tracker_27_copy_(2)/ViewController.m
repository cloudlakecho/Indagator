//
//  ViewController.m
//  iss_tracker_27_copy_(2)
//
//  Created by User on 3/21/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "ViewController.h"
//#import "Lesson27ViewController.h"
#import "OrbitDataXMLParserDelegate.h"

//@interface ViewController ()
@implementation ViewController
//@end

@synthesize tableOfOrbits;
@synthesize listOfOrbits;
@synthesize xmlParser;
@synthesize xmlData;

//@end
//@implementation ViewController

// --------------------------------------------------------------------------------------------
@synthesize latValue;
@synthesize lonValue;
@synthesize toggleButton;


@synthesize hasInitialized;
@synthesize hasStarted;
@synthesize locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.listOfOrbits = [[NSMutableArray alloc] initWithCapacity:10];
    tableOfOrbits.delegate = self;
    tableOfOrbits.dataSource = self;
    
    
    [super viewDidLoad];
    
    /*
    // setup Core Location
    hasInitialized = YES;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //locationManager.purpose = @"This application will display your current location and the distance travelled since the last reading.";
    */
    
    /*
    // setup button
    hasStarted = NO;
    [toggleButton setTitle:@"Start Location Updates"
                  forState:UIControlStateNormal];
    */
    
    if(![CLLocationManager locationServicesEnabled])
    {
        UIAlertView *noLocationServicesAlert = [[UIAlertView alloc] initWithTitle:@"The Find Local Record Stores feature is not available" message:@"Location Services are not enabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noLocationServicesAlert show];
    }
    else if ([CLLocationManager locationServicesEnabled])
    {
        //UIAlertView *locationServicesAlert = [[UIAlertView alloc] initWithTitle:@"The Find Local Record Stores feature is available" message:@"Location Services are enabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //[locationServicesAlert show];
        NSLog(@"location services are enabled.");
        hasInitialized = YES;
        //locationManager = [[CLLocationManager alloc] init];
        //locationManager.delegate = self;
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // ** Don't forget to add NSLocationWhenInUseUsageDescription in MyApp-Info.plist and give it a string
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        //if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        //{
          //  [locationManager requestAlwaysAuthorization];
        //}
        /*
         if you call requestWhenInUseAuthorization or requestAlwaysAuthorization without the corresponding key, the prompt simply won’t be shown to the user.
         */
        //[locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization]; // The Simulator needs this
        //[locationManager startUpdatingLocation];
        //NSArray<CLLocation *> *locations;
        //NSLog( @"%@", [locations lastObject] );
        


        
        //self.mapView.showsUserLocation = YES;
        //self.searchResultMapItems = [NSMutableArray array];
        hasStarted = NO;
        [toggleButton setTitle:@"Start Location Updates"
                      forState:UIControlStateNormal];
    }
    
    
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if( authStatus == kCLAuthorizationStatusAuthorized )
    {
        UIAlertView *locationServicesAuth = [[UIAlertView alloc] initWithTitle:@"Authorization" message:@"The app is authorized to use location services." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [locationServicesAuth show];
    }
    else if ( authStatus != kCLAuthorizationStatusAuthorized )
    {
        UIAlertView *locationServicesAuth = [[UIAlertView alloc] initWithTitle:@"Authorization" message:@"The app isn't authorized to use location services." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [locationServicesAuth show];
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    
}

- (void)viewDidUnload
{
    [self setLatValue:nil];
    [self setLonValue:nil];
    //[self setDistValue:nil];
    [self setToggleButton:nil];
    [super viewDidUnload];
    
    if (hasInitialized == YES)
        [locationManager stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (IBAction)onLoadOrbits:(UIButton *)sender
//{
//}
- (IBAction)onLoadOrbits:(id)sender
{
    // load contacts.xml into NSData instance
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* filePath = [bundle pathForResource:@"orbits" ofType:@"xml"];
    self.xmlData = [NSData dataWithContentsOfFile:filePath];
    
    // instantiate NSXMLParser
    self.xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    
    // set up parser delegate
    //ContactDataXMLParserDelegate *parserDelegate = [[ContactDataXMLParserDelegate alloc] init];
    OrbitDataXMLParserDelegate *parserDelegate = [[OrbitDataXMLParserDelegate alloc] init];

    parserDelegate.viewController = self;
    [xmlParser setDelegate:parserDelegate];
    
    // parse the file.
    [xmlParser parse];
    self.xmlParser = nil;
    self.xmlData = nil;
    
    // reload table view
    // it needs to clean and reload
    
    //[tableOfContacts reloadData];
    [tableOfOrbits reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView
 numberOfRowsInSection:(NSInteger)section
{
    return [listOfOrbits count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"Cell"];
    }
    
    OrbitData* data = (OrbitData*)[listOfOrbits objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@ %@ %@",
                               data.name, data.longitude, data.latitude, data.altitude]];
    
    return  cell;
}

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
              withRowAnimation:(UITableViewRowAnimation)animation
{
    
}

// --------------------------------------------------------------------------------------------

- (IBAction)onButtonPressed:(id)sender
{
    // do not do anything if location manager is not setup
    if (hasInitialized == NO)
        return;
    
    // start
    if (hasStarted == NO)
    {
        [toggleButton setTitle:@"Stop Location Updates"
                      forState:UIControlStateNormal];
        [locationManager startUpdatingLocation];
        hasStarted = YES;
        NSLog(@"The location service started.");
        //NSArray<CLLocation *> *locations;
        //NSLog( @"%@", [locations lastObject] );

        return;
    }
    
    // stop
    else if (hasStarted == YES)
    {
        [toggleButton setTitle:@"Start Location Updates"
                      forState:UIControlStateNormal];
        [locationManager stopUpdatingLocation];
        NSLog(@"The location service stopped.");
        hasStarted = NO;
        return;
    }

}


- (IBAction)graphicalview:(UIButton *)sender
{
    
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied)
    {
        hasInitialized = NO;
        [locationManager stopUpdatingLocation];
        NSLog(@"The location service stopped. There is an error.");
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorAlert show];
        NSLog(@"Error: %@",error.description);
    }
}

/*
 - (void)locationManager:(CLLocationManager *)manager
 didUpdateToLocation:(CLLocation *)newLocation
 fromLocation:(CLLocation *)oldLocation
 {
 // lat/lon values should only be considered if
 // horizontalAccuracy is not negative.
 // may be this condition is an issue
 if (newLocation.horizontalAccuracy >= 0)
 {
 CLLocationDegrees currentLatitude = newLocation.coordinate.latitude;
 CLLocationDegrees currentLongitude =
 newLocation.coordinate.longitude;
 CLLocationDistance distanceTravelled =
 [oldLocation distanceFromLocation:newLocation];
 
 latValue.text = [NSString stringWithFormat:@"%2.3f",
 currentLatitude];
 lonValue.text = [NSString stringWithFormat:@"%2.3f",
 currentLongitude];
 distValue.text = [NSString stringWithFormat:@"%2.3f",
 distanceTravelled];
 
 NSLog(@"%@", latValue.text);
 
 UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"Location data available" message:latValue.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [locationAlert show];
 
 }
 else
 {
 UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"horixontalAccury is negative" message:latValue.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [locationAlert show];
 }
 }
 */

// after iOS 6.0
/*
 - (void)locationManager:(CLLocationManager *)manager
 didUpdateLocations:(NSArray<CLLocation *> *)locations
 
 Initializes a newly allocated array by placing in it the objects contained in a given array.
 Declaration
 OBJECTIVE-C
 - (instancetype)initWithArray:(NSArray<ObjectType> *)anArray
 
 */

//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(NSArray<CLLocation *> *)locations
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation*> *)locations
{
    
    
    // lat/lon values should only be considered if
    // horizontalAccuracy is not negative.
    // may be this condition is an issue
    
    //@property(nonatomic, readonly) ObjectType lastObject
    if (locations.lastObject.horizontalAccuracy >= 0)
    {
        CLLocationDegrees currentLatitude = locations.lastObject.coordinate.latitude;
        CLLocationDegrees currentLongitude =
        locations.lastObject.coordinate.longitude;
        
        //CLLocationDistance distanceTravelled = [locations distanceFromLocation:locations.lastObject];
        
        latValue.text = [NSString stringWithFormat:@"%2.3f",
                         currentLatitude];
        lonValue.text = [NSString stringWithFormat:@"%2.3f",
                         currentLongitude];
        //distValue.text = [NSString stringWithFormat:@"%2.3f", distanceTravelled];
        
        NSLog(@"%@", latValue.text);
        
        //UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"Location data available" message:latValue.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //[locationAlert show];
        
    }
    else
    {
        UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"horixontalAccury is negative" message:latValue.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [locationAlert show];
    }
    
    NSLog( @"%@", [locations lastObject] );
    
}


@end
