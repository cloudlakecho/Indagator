//
//  ViewController.h
//  iss_tracker_27_copy_(2)
//
//  Created by User on 3/21/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

//@interface ViewController : UIViewController
@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableOfOrbits;
@property (strong, nonatomic) NSMutableArray* listOfOrbits;
@property (strong, nonatomic) NSXMLParser* xmlParser;
@property (strong, nonatomic) NSData* xmlData;

- (IBAction)onLoadOrbits:(id)sender;

//@end

// --------------------------------------------------------------------------------------------

//@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *latValue;
@property (weak, nonatomic) IBOutlet UILabel *lonValue;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;

@property BOOL hasInitialized;
@property BOOL hasStarted;

@property (strong, nonatomic) CLLocationManager* locationManager;

- (IBAction)onButtonPressed:(id)sender;

@end

