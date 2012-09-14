//
//  LISMasterViewController.h
//  UKCourses
//
//  Created by Criss Myers on 21/05/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableiPadDelegate <NSObject>
@required
-(void)loadMoreResultsiPad:(NSString *)path;
@end

//result items
#define ccoursetitle 1
#define cprovider 2
#define csubject 4
#define cstudymode 3

@interface LISMasterViewController : UIViewController {
    
    int offset;
    int results;
    
    BOOL loadingMore;
    
    id <TableiPadDelegate> delegate;
}
@property (retain) id delegate;
@property (strong, nonatomic) IBOutlet UITableView *resultsTable;
@property (strong, nonatomic) IBOutlet UITableView *optionsTable;

@property (strong, nonatomic) NSString *totalHits;

@property (strong, nonatomic) NSArray *resultsArray;

@property (strong, nonatomic) NSString *courseText;

@property int selectedCourse;

@property (strong, nonatomic) NSString *searchURL;

@property (strong, nonatomic) IBOutlet UILabel *optionTitle;

@property (strong, nonatomic) IBOutlet UITextView *optionText;

-(void)reloadContent;
-(void)reloadFailed;

@end
