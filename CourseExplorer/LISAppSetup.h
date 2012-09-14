//
//  LISAppSetup.h
//
//  Created by Desktop on 15/05/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LISRootViewController;

@interface LISAppSetup : NSObject <NSXMLParserDelegate> {
    
    NSXMLParser *addressParser;
    
    LISRootViewController *appDelegate;
    
    NSMutableArray *currentArray;
    
    NSMutableArray *studymode;
    NSMutableArray *qualification;
    NSMutableArray *order;
    NSMutableArray *distance;
    NSMutableArray *dunit;
    NSMutableArray *provider;
    
    NSMutableString *text;
    NSString *providerName;

    NSString *docsDirectory;

}
-(id)initWithDelegate:(LISRootViewController*)appDel;

@property (nonatomic, retain) NSXMLParser *addressParser;
@property (nonatomic, retain) LISRootViewController *appDelegate;
@property (nonatomic, retain) NSMutableArray *currentArray;
@property (nonatomic, retain) NSMutableArray *studymode;
@property (nonatomic, retain) NSMutableArray *qualification;
@property (nonatomic, retain) NSMutableArray *order;
@property (nonatomic, retain) NSMutableArray *distance;
@property (nonatomic, retain) NSMutableArray *dunit;
@property (nonatomic, retain) NSMutableArray *provider;
@property (nonatomic, retain) NSMutableString *text;
@property (nonatomic, retain) NSString *providerName;
@property (nonatomic, retain) NSString *docsDirectory;

-(void)parseXMLURL:(NSString *)URL;

@end
