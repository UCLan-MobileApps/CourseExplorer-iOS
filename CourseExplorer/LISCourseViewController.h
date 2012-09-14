//
//  LISCourseViewController.h
//  UKCourses
//
//  Created by Criss Myers on 20/06/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LISResultsViewAccessController;

@interface LISCourseViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *courseTable;

@property LISResultsViewAccessController *detailsView;

@property (nonatomic, retain) NSString *courseTitle;

@property (nonatomic, retain) NSArray *courseArray;

@property (nonatomic, retain) NSString *courseText;

@property NSInteger row;

@property (strong, nonatomic) IBOutlet UIView *detail;

@property (strong, nonatomic) IBOutlet UITextView *detailsText;

@property (strong, nonatomic) IBOutlet UILabel *topic;

- (IBAction)closeDetails:(id)sender;

@end
