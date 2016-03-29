//
//  OrbitDataXMLParserDelegate.h
//  iss_tracker_27_copy_(2)
//
//  Created by User on 3/21/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Lesson27ViewController.h"
#import "ViewController.h"
#import "OrbitData.h"
//#import "ContactData.h"

//@interface OrbitDataXMLParserDelegate : NSObject
@interface OrbitDataXMLParserDelegate : NSObject <NSXMLParserDelegate>

@property (nonatomic, weak) ViewController* viewController;
@property (nonatomic, strong) OrbitData* tmpOrbitInfo;
@property (nonatomic, strong) NSMutableString* currentElementValue;



@end
