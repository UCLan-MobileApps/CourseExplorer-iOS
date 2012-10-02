//
//  NSObject+LISAppSetup.m
//
/*
Copyright 2012 UCLan (University of Central Lancashire)

Licenced under the BSD 2-Clause Licence.
You may not use this file except in compliance with the License.
You may obtain a copy of the License at:

       http://opensource.org/licenses/bsd-license.php

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

#import "LISAppSetup.h"
#import "LISRootViewController.h"

@implementation LISAppSetup

@synthesize addressParser;
@synthesize appDelegate;
@synthesize currentArray;
@synthesize studymode, qualification, order, dunit, distance, provider;
@synthesize text, providerName;
@synthesize docsDirectory;

-(id)initWithDelegate:(LISRootViewController*)appDel {
	if(self = [super init]){
        appDelegate = appDel;
    }
	return self;
}

-(void)parseXMLURL:(NSString *)URL {
    
    docsDirectory = NSTemporaryDirectory();
    
    BOOL success;
    
    NSURL *xmlURL = [NSURL URLWithString:URL];
    
    NSString *xmlFeedStr = [[NSString alloc] initWithContentsOfURL:xmlURL];
    
    NSData *data =[xmlFeedStr dataUsingEncoding:NSUTF8StringEncoding];
    
    addressParser = [[NSXMLParser alloc] initWithData:data];
    [addressParser setDelegate:self];
    [addressParser setShouldResolveExternalEntities:YES];
    
    success = [addressParser parse];
    
    if (success == YES) {
      //  NSLog(@"A success");
        //report success
        [appDelegate performSelectorOnMainThread:@selector(setupArrays) withObject:nil waitUntilDone:YES];
    }
    else {
       // NSLog(@"A fail");
        //report failure
        [appDelegate performSelectorOnMainThread:@selector(failSetup) withObject:nil waitUntilDone:YES];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
	NSString * errorString = [NSString stringWithFormat:@"Unable to download data (Error code %i )",[parseError code]];
    NSLog(@"%@", errorString);
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    // NSLog(@"startDoc");
    
    //initalise the current array
    currentArray = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSError *anError;
    
    //remove all old files
    NSString *savePath = [docsDirectory stringByAppendingPathComponent:@"dunits.plist"];
    [fileManager removeItemAtPath:savePath error:&anError];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict  {
    // NSLog(@"startElement %@", elementName);
    
    //create an object to check for
    id obj;
    
    //create the lists
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"studyMode"]) {
        studymode = [[NSMutableArray alloc] init];
        currentArray = studymode;
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"qualification"]) {
        NSString *savePath = [docsDirectory stringByAppendingPathComponent:@"studymodes.plist"];
        [currentArray writeToFile:savePath atomically:YES];
       // NSLog(@"1 written file");
        qualification = [[NSMutableArray alloc] init];
        currentArray = qualification;
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"order"]) {
        NSString *savePath = [docsDirectory stringByAppendingPathComponent:@"qualifications.plist"];
        [currentArray writeToFile:savePath atomically:YES];
       //  NSLog(@"2 written file");
        order = [[NSMutableArray alloc] init];
        currentArray = order;
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"distance"]) {
        NSString *savePath = [docsDirectory stringByAppendingPathComponent:@"orders.plist"];
        [currentArray writeToFile:savePath atomically:YES];
       //  NSLog(@"3 written file");
        distance = [[NSMutableArray alloc] init];
        currentArray = distance;
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"dunit"]) {
        NSString *savePath = [docsDirectory stringByAppendingPathComponent:@"distances.plist"];
        [currentArray writeToFile:savePath atomically:YES];
        // NSLog(@"4 written file");
        dunit = [[NSMutableArray alloc] init];
        currentArray = dunit;
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"provider"]) {
        
        NSFileManager *fileManger = [[NSFileManager alloc] init];
        NSString *path = [docsDirectory stringByAppendingPathComponent:@"dunits.plist"];
        
        if ([fileManger fileExistsAtPath:path]) {
          //  NSLog(@"dont write");
        }
             else {
        NSString *savePath = [docsDirectory stringByAppendingPathComponent:@"dunits.plist"];
        [currentArray writeToFile:savePath atomically:YES];
        // NSLog(@"5 written file");
        provider = [[NSMutableArray alloc] init];
        currentArray = provider;
             }
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"hits"]) {
        NSString *savePath = [docsDirectory stringByAppendingPathComponent:@"providers.plist"];
        [currentArray writeToFile:savePath atomically:YES];
        // NSLog(@"6 written file");
    }
    
    //write the objects
    if ((obj=[attributeDict objectForKey:@"key"])) {
        if (!(currentArray == provider)) {
            [currentArray addObject:[attributeDict objectForKey:@"key"]];
        }
        if (!([attributeDict objectForKey:@"key"] == NULL)) {
            
        providerName = [attributeDict objectForKey:@"key"];
       // NSLog(@"%@",providerName);
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // NSLog(@"foundCharacters = %@", string);
    
    //add string for providers only
    if (currentArray == provider) {
      //  NSLog(@"string = %@", string);
        text = [[NSMutableString alloc] init];
        [text appendString:string];
      //  NSLog(@"text = %@", text);
        
        NSDictionary *tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:text, @"Code", providerName, @"Name", nil];
        [currentArray addObject:tempDict];
      //  NSLog(@"array = %@",currentArray);
    }

}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // NSLog(@"endElement %@", elementName);

}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    // NSLog(@"endDoc"); 
}

@end
