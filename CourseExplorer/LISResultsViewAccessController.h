//
//  LISResultsViewAccessController.h
//  UKCourses
//
//  Created by Criss Myers on 02/07/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LISResultsViewAccessController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *detailsText;
@property (strong, nonatomic) NSString *detailsString;

- (IBAction)close:(id)sender;

@end
