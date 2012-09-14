//
//  LISResultsViewController.h
//  UKCourses
//
//  Created by Criss Myers on 23/05/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableDelegate <NSObject>
@required
-(void)loadMoreResults:(NSString *)path;
@end

@class LISCourseViewController;

//result items
#define ccoursetitle 1
#define cprovider 2
#define csubject 4
#define cstudymode 3

@interface LISResultsViewController : UIViewController {
    
    int offset;
    int results;
    
    id <TableDelegate> delegate;
    
    BOOL loadingMore;

}

@property (retain) id delegate;

@property LISCourseViewController *courseView;

@property (strong, nonatomic) IBOutlet UITableView *resultsTable;

@property (strong, nonatomic) NSString *totalHits;

@property (strong, nonatomic) NSString *searchURL;

@property (strong, nonatomic) NSArray *resultsArray;

-(void)reloadContent;
-(void)reloadFailed;

@end
