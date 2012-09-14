//
//  LISResultsViewAccessController.m
//  UKCourses
//
//  Created by Criss Myers on 02/07/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import "LISResultsViewAccessController.h"

@interface LISResultsViewAccessController ()

@end

@implementation LISResultsViewAccessController
@synthesize detailsText, detailsString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    detailsText.text = detailsString;
    self.title = @"Course Details";
}

- (void)viewDidUnload
{
    [self setDetailsText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
