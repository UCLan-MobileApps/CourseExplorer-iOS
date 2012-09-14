//
//  LISRootPickerViewController.h
//  UKCourses
//
//  Created by Criss Myers on 02/07/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerDelegate <NSObject>
@required
-(void)pickerReply:(NSInteger)pickNumber:(NSString *)pickerString:(NSString *)pickerName;
@end

@interface LISRootPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    
    id <PickerDelegate> delegate;
}

@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (retain) id delegate;

@property NSInteger pickerNumber;
@property (strong,nonatomic) NSMutableArray *providerArray;
@property (strong,nonatomic) NSMutableArray *qualificationsArray;
@property (strong,nonatomic) NSMutableArray *studymodesArray;
@property (strong,nonatomic) NSMutableArray *searchdistanceArray;
@property (strong,nonatomic) NSMutableArray *displayorderArray;
@property (strong,nonatomic) NSMutableArray *unitsArray;

@property (strong, nonatomic) NSString *pickerString;
@property (strong, nonatomic) NSString *pickerName;

- (IBAction)close:(id)sender;

@end
