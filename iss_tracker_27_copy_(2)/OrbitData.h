//
//  OrbitData.h
//  iss_tracker_27_copy_(2)
//
//  Created by User on 3/21/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrbitData : NSObject

/*
 @property int contactId;
@property (nonatomic, strong) NSMutableString* firstName;
@property (nonatomic, strong) NSMutableString* lastName;
@property (nonatomic, strong) NSMutableString* address;
@property (nonatomic, strong) NSMutableString* phone;
*/

@property int satelliteId;
@property (nonatomic, strong) NSMutableString* name;
@property (nonatomic, strong) NSMutableString* latitude;
@property (nonatomic, strong) NSMutableString* longitude;
@property (nonatomic, strong) NSMutableString* altitude;

@end
