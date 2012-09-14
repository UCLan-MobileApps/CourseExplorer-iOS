//
//  LISRootPickerViewController.m
//  UKCourses
//
//  Created by Criss Myers on 02/07/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import "LISRootPickerViewController.h"

@implementation LISRootPickerViewController

@synthesize picker;
@synthesize pickerNumber;
@synthesize delegate;
@synthesize providerArray, qualificationsArray, studymodesArray, searchdistanceArray, displayorderArray, unitsArray;
@synthesize pickerString, pickerName;

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
    
    if (pickerNumber == 1) {
        pickerName = @"Qualifications";
        pickerString = @"*";

    }
    
    if (pickerNumber == 2) {
        pickerName = @"Sudy Modes";
        pickerString = @"*";

    }
}

- (void)viewDidUnload
{
    [self setPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma picker
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component  {
    
    if (pickerNumber == 0) {
        return 1;
    }
    if (pickerNumber == 2) {
        return [qualificationsArray count];
    }
    if (pickerNumber == 3) {
        return [studymodesArray count];
    }
    
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerNumber == 2) {
        return [qualificationsArray objectAtIndex:row];
        
    }
    if (pickerNumber == 3) {
        return [studymodesArray objectAtIndex:row];
    }
    
    return @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    if (pickerNumber == 2) {
        pickerName = [NSString stringWithFormat:@"%@",[qualificationsArray objectAtIndex:row]];
        if (row == 0 || row == 1) {
            pickerString = @"*";
        }
        else {
            NSString *preString = [NSString stringWithFormat:@"%@", [qualificationsArray objectAtIndex:row]];
           pickerString = [preString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        }
    }
    
    if (pickerNumber == 3) {
        pickerName = [NSString stringWithFormat:@"%@",[studymodesArray objectAtIndex:row]];
        if (row == 0 ||row == 1) {
            pickerString = @"*";
        }
        else {
            NSString *preString = [NSString stringWithFormat:@"%@", [studymodesArray objectAtIndex:row]];
            pickerString = [preString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        }
    }
}

-(void)close {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)close:(id)sender {
    
    [[self delegate] pickerReply:pickerNumber:pickerString:pickerName];

    [self close];
}

@end
