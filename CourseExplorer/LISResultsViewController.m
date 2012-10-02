//
//  LISResultsViewController.m
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

#import "LISResultsViewController.h"
#import "LISCourseViewController.h"

@implementation LISResultsViewController

@synthesize resultsTable;
@synthesize totalHits;
@synthesize resultsArray;
@synthesize courseView;
@synthesize searchURL;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BOOL UIAccessibilityIsVoiceOverRunning();

    //set table to transparent
    resultsTable.backgroundColor = [UIColor clearColor];
    resultsTable.separatorColor = [UIColor blackColor];
    
    //load the data set
	NSString *docsDirectory = NSTemporaryDirectory();
    resultsArray = [[NSArray alloc] initWithContentsOfFile:[docsDirectory stringByAppendingPathComponent:@"catalog.plist"]];
    
    offset = 0;
    results = [totalHits intValue];
    
    loadingMore = FALSE;
    
   // NSLog(@"results = %@", resultsArray);
}

-(void)reloadContent {
    
    if (offset == 0) {
        loadingMore = FALSE;
    }
    
    NSString *docsDirectory = NSTemporaryDirectory();
    resultsArray = [[NSArray alloc] initWithContentsOfFile:[docsDirectory stringByAppendingPathComponent:@"catalog.plist"]];
    [resultsTable reloadData];
    [resultsTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"More Courses Loaded retrun to the top");    
}

-(void)reloadFailed {
    
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"The inital setup failed, please close the app to reload or try again later");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to contact the server, please close and reopen the App or try again later as this may be a network issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)viewDidUnload
{
    [self setResultsTable:nil];
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated{
        self.navigationController.navigationBarHidden = TRUE;
}

-(void)viewDidDisappear:(BOOL)animated {
}

#pragma table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section == 2) {
        return 50;
    }
    else {
        if (UIAccessibilityIsVoiceOverRunning(TRUE)) {
            return 50;
        }
        else {
        return 110;
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    if (section == 0 || section == 2) {
        return 1;
    }
    
    if (section == 1) {

	return [resultsArray count];
	}
    
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {

    NSString *displayResults = [NSString stringWithFormat:@"%@ Search Results, %i - %i", totalHits, offset, offset+100];
    
	return displayResults;
    }
    
    return NULL;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    return NULL;	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (indexPath.section == 0) {
        
        static NSString *CellTableIndentifier1 = @"CellTableIdentifier1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier1];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier1];
        }
        
        if (loadingMore == FALSE) {
        
        cell.textLabel.text = @"Return to Search";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        return cell;
            
        } 
        
        else {
            cell.textLabel.text = @"Previous Results";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.backgroundColor = [UIColor blackColor];
            cell.textLabel.textColor = [UIColor whiteColor];
            
            return cell;
        }

    }
    
    if (indexPath.section == 2) {
        
        static NSString *CellTableIndentifier2 = @"CellTableIdentifier2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier2];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier2];
        }
        
        if (results < offset+100) {
            cell.textLabel.text = @"End of Results";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.selectionStyle = UITableViewCellSelectionStyleNone; 
            cell.backgroundColor = [UIColor blackColor];
            cell.textLabel.textColor = [UIColor whiteColor];

        }
        else {
            cell.textLabel.text = @"Load More";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.selectionStyle = UITableViewCellSelectionStyleGray; 
            cell.backgroundColor = [UIColor blackColor];
            cell.textLabel.textColor = [UIColor whiteColor];
        }
        
        return cell;
        
    }
    
    if (indexPath.section == 1) {

    static NSString *CellTableIndentifier3 = @"CellTableIdentifier3";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier3];
        
    if (UIAccessibilityIsVoiceOverRunning(TRUE)) {
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier3];
            //display text
            NSString *displayText = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:indexPath.row] objectForKey:@"qualtitle"]];
            cell.textLabel.text = displayText;
            cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
        }
    }
    
    if (cell == nil) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier3];
      
        //cell layout
        //course title
        CGRect courseTitleRect = CGRectMake(0, 0, 300, 74);
        UITextView *courseTitleLabel = [[UITextView alloc] initWithFrame:courseTitleRect];
        courseTitleLabel.textAlignment = UITextAlignmentCenter;
        courseTitleLabel.font = [UIFont boldSystemFontOfSize:15];
        courseTitleLabel.tag = ccoursetitle;
        courseTitleLabel.backgroundColor = [UIColor clearColor];
        courseTitleLabel.editable = NO;
        courseTitleLabel.scrollEnabled = NO;
        courseTitleLabel.UserInteractionEnabled = NO;
        [cell.contentView addSubview:courseTitleLabel];
        
        //institution
        CGRect providerTitleRect = CGRectMake(10, 75, 300, 25);
        UITextView *providerTitleLabel = [[UITextView alloc] initWithFrame:providerTitleRect];
        providerTitleLabel.textAlignment = UITextAlignmentLeft;
        providerTitleLabel.font = [UIFont systemFontOfSize:12];
        providerTitleLabel.tag = cprovider;
        providerTitleLabel.backgroundColor = [UIColor clearColor];
        providerTitleLabel.editable = NO;
        providerTitleLabel.scrollEnabled = NO;
        providerTitleLabel.UserInteractionEnabled = NO;
        [cell.contentView addSubview:providerTitleLabel];
        
        //unused
        //study mode
        CGRect studymodeTitleRect = CGRectMake(10, 52, 150, 25);
        UITextView *studymodeTitleLabel = [[UITextView alloc] initWithFrame:studymodeTitleRect];
        studymodeTitleLabel.textAlignment = UITextAlignmentLeft;
        studymodeTitleLabel.font = [UIFont systemFontOfSize:12];
        studymodeTitleLabel.tag = cstudymode;
        studymodeTitleLabel.backgroundColor = [UIColor clearColor];
        studymodeTitleLabel.editable = NO;
        studymodeTitleLabel.scrollEnabled = NO;
        studymodeTitleLabel.UserInteractionEnabled = NO;
        [cell.contentView addSubview:studymodeTitleLabel];
        
        //unused
        //subject
        CGRect subjectTitleRect = CGRectMake(150, 52, 150, 25);
        UITextView *subjectTitleLabel = [[UITextView alloc] initWithFrame:subjectTitleRect];
        subjectTitleLabel.textAlignment = UITextAlignmentLeft;
        subjectTitleLabel.font = [UIFont systemFontOfSize:12];
        subjectTitleLabel.tag = csubject;
        subjectTitleLabel.backgroundColor = [UIColor clearColor];
        subjectTitleLabel.editable = NO;
        subjectTitleLabel.scrollEnabled = NO;
        subjectTitleLabel.UserInteractionEnabled = NO;
        [cell.contentView addSubview:subjectTitleLabel];
        
        //black line space
        CGRect lineViewRect = CGRectMake(10, 75, 280, 1);
        UIView *lineView = [[UIView alloc] initWithFrame:lineViewRect];
        lineView.backgroundColor = [UIColor blackColor];
        [cell.contentView addSubview:lineView];

    }

    //cell text
	NSUInteger row = [indexPath row];
	NSDictionary *rowData = [resultsArray objectAtIndex:row];
    
    UITextView *courseTitleLabel = (UITextView *)[cell.contentView viewWithTag:ccoursetitle];
    NSString *displayText = [NSString stringWithFormat:@"%@", [rowData objectForKey:@"qualtitle"]];
    courseTitleLabel.text = displayText;
	
    UITextView *providerTitleLabel = (UITextView *)[cell.contentView viewWithTag:cprovider];
    providerTitleLabel.text = [rowData objectForKey:@"provtitle"];
       
    //set the cell colour
    cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray; 
    
    return cell;
    }
    
    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   int row = [indexPath indexAtPosition:[indexPath length] -1];
    
    if (indexPath.section == 0) {
        if (loadingMore == FALSE) {
        [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            offset = offset-100;
            
            NSString *urlPath = [NSString stringWithFormat:@"%@&offset=%i", searchURL, offset];
            
            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"Loading Previous Courses, please wait");
            
            [[self delegate] loadMoreResults:urlPath];
        }
    }
    
    else if (indexPath.section == 2) {
        if (results < offset+100) {
            
        }
        else {
            //load more
            offset = offset+100;
            
            loadingMore = TRUE;
            
            NSString *urlPath = [NSString stringWithFormat:@"%@&offset=%i", searchURL, offset];
            
            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"Loading More Courses, please wait");
            
            [[self delegate] loadMoreResults:urlPath];
        }
    }
    
    else {
        courseView = [[LISCourseViewController alloc] initWithNibName:@"LISCourseViewController" bundle:[NSBundle mainBundle]];
        
        courseView.courseTitle = [NSString stringWithFormat:@"%@",[[resultsArray objectAtIndex:row] objectForKey:@"title"]];
        
        courseView.courseArray = resultsArray;
        courseView.row = row;
     
        [self.navigationController  pushViewController:courseView animated:YES];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
