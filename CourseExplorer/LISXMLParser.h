//
//  LISXMLParser.h
//
//  Created by Desktop on 27/04/2012.
//  Copyright (c) 2012 UCLan All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LISRootViewController.h"
 
@interface LISXMLParser : NSObject <NSXMLParserDelegate> {

    LISRootViewController *appDelegate;
    
    NSXMLParser *addressParser;
    
    NSMutableArray *catalog;
    NSMutableArray *presentations;
    NSMutableArray *credits;
    
    NSMutableDictionary *course;
    NSMutableDictionary *map;
    
    NSMutableString *items;
    NSString *title;

    NSString *docsDirectory;
    
    BOOL switchBool;
    BOOL isString;
    BOOL maps;
    BOOL pres;
    BOOL cred;
}
-(id)initWithDelegate:(LISRootViewController*)appDel;

@property (nonatomic, retain) LISRootViewController *appDelegate;
@property (nonatomic, retain) NSXMLParser *addressParser;
@property (nonatomic, retain) NSMutableArray *catalog;
@property (nonatomic, retain) NSMutableArray *presentations;
@property (nonatomic, retain) NSMutableArray *credits;
@property (nonatomic, retain) NSMutableDictionary *course;
@property (nonatomic, retain) NSMutableDictionary *map;
@property (nonatomic, retain) NSMutableString *items;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *docsDirectory;

-(void)parseXMLURL:(NSString *)URL;

@end
