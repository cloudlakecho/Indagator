//
//  OrbitDataXMLParserDelegate.m
//  iss_tracker_27_copy_(2)
//
//  Created by User on 3/21/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "OrbitDataXMLParserDelegate.h"

@implementation OrbitDataXMLParserDelegate

@synthesize viewController;
@synthesize tmpOrbitInfo;
@synthesize currentElementValue;

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    // clear the contents of current_element_value
    if (self.currentElementValue == nil)
        self.currentElementValue = [[NSMutableString alloc] initWithString:@""];
    else
        [currentElementValue setString:@""];
    
    // set 'tmpContactInfo' to a new ContactInfo object each time
    // the start of a 'contact' element is been encountered
    /*
     if([elementName isEqualToString:@"contact"])
    {
        self.tmpContactInfo = [[ContactData alloc] init];
        
        // read the attributes of the node here.
        NSString* szID = [attributeDict objectForKey:@"id"];
        if (szID != nil)
            self.tmpContactInfo.contactId = [szID intValue];
    }
     */
    if([elementName isEqualToString:@"orbit"])
    {
        self.tmpOrbitInfo = [[OrbitData alloc] init];
        
        // read the attributes of the node here.
        NSString* szID = [attributeDict objectForKey:@"id"];
        if (szID != nil)
            self.tmpOrbitInfo.satelliteId = [szID intValue];
    }
}


- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    [currentElementValue appendString:string];
}


- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"name"])
    {
        if (tmpOrbitInfo.name == nil)
            tmpOrbitInfo.name = [[NSMutableString alloc] initWithCapacity:25];
        [tmpOrbitInfo.name setString:currentElementValue];
    }
    
    if([elementName isEqualToString:@"latitude"])
    {
        if (tmpOrbitInfo.latitude == nil)
            tmpOrbitInfo.latitude = [[NSMutableString alloc] initWithCapacity:25];
        [tmpOrbitInfo.latitude setString:currentElementValue];
    }
    
    if([elementName isEqualToString:@"longitude"])
    {
        if (tmpOrbitInfo.longitude == nil)
            tmpOrbitInfo.longitude = [[NSMutableString alloc] initWithCapacity:25];
        [tmpOrbitInfo.longitude setString:currentElementValue];
    }
    
    if([elementName isEqualToString:@"altitude"])
    {
        if (tmpOrbitInfo.altitude == nil)
            tmpOrbitInfo.altitude = [[NSMutableString alloc] initWithCapacity:25];
        [tmpOrbitInfo.altitude setString:currentElementValue];
    }
    
    if([elementName isEqualToString:@"orbit"])
    {
        [viewController.listOfOrbits addObject:tmpOrbitInfo];
        tmpOrbitInfo = nil;
    }
}



@end

