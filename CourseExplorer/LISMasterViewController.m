//
//  LISMasterViewController.m
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

#import "LISMasterViewController.h"

@implementation LISMasterViewController

@synthesize resultsTable, optionsTable;
@synthesize totalHits;
@synthesize resultsArray;
@synthesize selectedCourse;
@synthesize optionTitle;
@synthesize optionText;
@synthesize courseText;
@synthesize delegate;
@synthesize searchURL;

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
    
    //set table to transparent
    resultsTable.backgroundColor = [UIColor clearColor];
    resultsTable.backgroundView = nil;
    resultsTable.separatorColor = [UIColor blackColor];
    
    optionsTable.backgroundColor = [UIColor clearColor];
    optionsTable.separatorColor = [UIColor blackColor];
    optionsTable.backgroundView = nil;
    
    //load the data set
	NSString *docsDirectory = NSTemporaryDirectory();
    resultsArray = [[NSArray alloc] initWithContentsOfFile:[docsDirectory stringByAppendingPathComponent:@"catalog.plist"]];
    
    offset = 0;
    results = [totalHits intValue];
    
    loadingMore = FALSE;
}

- (void)viewDidUnload
{
    [self setOptionTitle:nil];
    [self setOptionText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)reloadContent {
    
    if (offset == 0) {
        loadingMore = FALSE;
    }
    
    NSString *docsDirectory = NSTemporaryDirectory();
    resultsArray = [[NSArray alloc] initWithContentsOfFile:[docsDirectory stringByAppendingPathComponent:@"catalog.plist"]];
    [resultsTable reloadData];
    [resultsTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
}

-(void)reloadFailed {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to contact the server, please close and reopen the App or try again later as this may be a network issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == resultsTable) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == resultsTable) {

    if (indexPath.section == 0 || indexPath.section == 2) {
        return 50;
        }
    else {
        return 100;
        }
    }
    
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == resultsTable) {
	
    if (section == 0 || section == 2) {
        return 1;
        }
    
    if (section == 1) {
        
        return [resultsArray count];
        }
    }
    
    return 16;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == resultsTable) {

    if (section == 1) {
        
        NSString *displayResults = [NSString stringWithFormat:@"%@ Search Results , %i - %i", totalHits, offset, offset+100];
        
        return displayResults;
        }
    }
    
    return NULL;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    return NULL;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (indexPath.section == 0) {
        
        static NSString *CellTableIndentifier2 = @"CellTableIdentifier2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier2];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier2];
        }
        
        if (tableView == resultsTable) {
        
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
        
        else {
            
            if (indexPath.row == 3) {
                cell.textLabel.text = @"Course Subjects";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }
            
            if (indexPath.row == 5) {
                
                cell.textLabel.text = @"Course Qualifications";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
                
            }
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"Course Description";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
                
            }
            if (indexPath.row == 6) {
                
                cell.textLabel.text = @"Course Prerequisites";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
                
            }
            if (indexPath.row == 1) {
                cell.textLabel.text = @"Course Abstract";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }
            if (indexPath.row == 7) {
                cell.textLabel.text = @"Course Career Outcome";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }
            if (indexPath.row == 4) {
                cell.textLabel.text = @"Course URL";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }
            if (indexPath.row == 2) {
                cell.textLabel.text = @"Course Provider";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }
            if (indexPath.row == 8) {
                cell.textLabel.text = @"Course Aim";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }
            if (indexPath.row == 9) {
                cell.textLabel.text = @"Course Credits";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }   
            if (indexPath.row == 10) {
                cell.textLabel.text = @"Course Presentations";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }    
            if (indexPath.row == 11) {
                cell.textLabel.text = @"Course Assesment Strategy";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }    
            if (indexPath.row == 12) {
                cell.textLabel.text = @"Course Learning Outcome";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];                
                return cell;
            }    
            if (indexPath.row == 13) {
                cell.textLabel.text = @"Course Indicative Resources";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }
            if (indexPath.row == 14) {
                cell.textLabel.text = @"Course Syllabus";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }
            if (indexPath.row == 15) {
                cell.textLabel.text = @"Course Leads To";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
                
                return cell;
            }
        }
        
    }
    
    if (indexPath.section == 1) {
        
        static NSString *CellTableIndentifier = @"CellTableIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier];
            
            //course title
            CGRect courseTitleRect = CGRectMake(0, 0, 375, 70);
            UITextView *courseTitleLabel = [[UITextView alloc] initWithFrame:courseTitleRect];
            courseTitleLabel.textAlignment = UITextAlignmentCenter;
            courseTitleLabel.font = [UIFont boldSystemFontOfSize:15];
            courseTitleLabel.tag = ccoursetitle;
            courseTitleLabel.backgroundColor = [UIColor clearColor];
            courseTitleLabel.editable = NO;
            courseTitleLabel.scrollEnabled = NO;
            courseTitleLabel.UserInteractionEnabled = NO;
            [cell.contentView addSubview:courseTitleLabel];
            
            //institution x ,y ,w, h (left, down)
            CGRect providerTitleRect = CGRectMake(10, 70, 320, 30);
            UITextView *providerTitleLabel = [[UITextView alloc] initWithFrame:providerTitleRect];
            providerTitleLabel.textAlignment = UITextAlignmentLeft;
            providerTitleLabel.font = [UIFont systemFontOfSize:14];
            providerTitleLabel.tag = cprovider;
            providerTitleLabel.backgroundColor = [UIColor clearColor];
            providerTitleLabel.editable = NO;
            providerTitleLabel.scrollEnabled = NO;
            providerTitleLabel.UserInteractionEnabled = NO;
            [cell.contentView addSubview:providerTitleLabel];
            
            //unused
            //study mode
            CGRect studymodeTitleRect = CGRectMake(10, 60, 160, 30);
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
            CGRect subjectTitleRect = CGRectMake(160, 60, 210, 40);
            UITextView *subjectTitleLabel = [[UITextView alloc] initWithFrame:subjectTitleRect];
            subjectTitleLabel.textAlignment = UITextAlignmentLeft;
            subjectTitleLabel.font = [UIFont systemFontOfSize:12];
            subjectTitleLabel.tag = csubject;
            subjectTitleLabel.backgroundColor = [UIColor clearColor];
            subjectTitleLabel.editable = NO;
            subjectTitleLabel.scrollEnabled = NO;
            subjectTitleLabel.UserInteractionEnabled = NO;
            [cell.contentView addSubview:subjectTitleLabel];
            
        }
        
        NSUInteger row = [indexPath row];
        NSDictionary *rowData = [resultsArray objectAtIndex:row];
        
        UITextView *courseTitleLabel = (UITextView *)[cell.contentView viewWithTag:ccoursetitle];
        NSString *displayText = [NSString stringWithFormat:@"%@", [rowData objectForKey:@"qualtitle"]];
        courseTitleLabel.text = displayText;
        
        UITextView *providerTitleLabel = (UITextView *)[cell.contentView viewWithTag:cprovider];
        providerTitleLabel.text = [rowData objectForKey:@"provtitle"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor colorWithRed:0.820 green:0.707 blue:0.832 alpha:1];
        
        return cell;
    }
    
    if (indexPath.section == 2) {
        
        static NSString *CellTableIndentifier1 = @"CellTableIdentifier1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier1];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier1];
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
            cell.textLabel.text = @"Load More Results";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.selectionStyle = UITableViewCellSelectionStyleGray; 
            cell.backgroundColor = [UIColor blackColor];
            cell.textLabel.textColor = [UIColor whiteColor];
        }
        
        return cell;
        
    }
    
    return NULL;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int row = [indexPath indexAtPosition:[indexPath length] -1];

    if (indexPath.section == 0) {
        if (tableView == resultsTable) {
 
            if (loadingMore == FALSE) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                offset = offset-100;
                
                NSString *urlPath = [NSString stringWithFormat:@"%@&offset=%i", searchURL, offset];
                
                UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"Loading Previous Courses, please wait");
                
                [[self delegate] loadMoreResultsiPad:urlPath];
            }
            
        }
        
        else {
            
            if (indexPath.row == 3) {
                
                NSString *tempString = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"subject"]];
 
                courseText = tempString;
                
                optionText.text = courseText;
                optionTitle.text = @"Course Subjects";
            }
            
            if (indexPath.row == 5) {
                
                NSString *qualTitle = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"qualtitle"]];
                NSString *awardedBy = [NSString stringWithFormat:@"Awarded By: %@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"awardedBy"]];
                NSString *level = [NSString stringWithFormat:@"Level: %@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"level"]];
                NSString *qualDescription = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"qualdescription"]];
                NSString *type = [NSString stringWithFormat:@"Type: %@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"type"]];
                NSString *accreditedBy = [NSString stringWithFormat:@"Accredited By: %@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"accreditedBy"]];
                NSString *levelControlledTerm = [NSString stringWithFormat:@"Level Controlled Term: %@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"levelControlledTerm"]];
                
               // if (![qualTitle isEqualToString:@"(null)"]) {
                    
                    courseText = [NSString stringWithFormat:@"%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ ", qualTitle, qualDescription, level, type, awardedBy, accreditedBy, levelControlledTerm]; 
               // }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Qualifications";            }
            
            if (indexPath.row == 0) {
                
                NSString *tempString = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"description"]];
                
                NSString *tempString2 = [tempString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                
               // if (![tempString isEqualToString:@"(null)"]) {
                    courseText = tempString2;
               // }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Description";
            }
            
            if (indexPath.row == 6) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"prerequisites"]];
                // NSLog(@"%@", detailsValue);
                
               // if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
               // }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Prerequisites";
            }
            
            if (indexPath.row == 1) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"abstract"]];
                
               // if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
               // }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Abstract";
            }
            
            if (indexPath.row == 7) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"careerOutcome"]];
                
                //if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
               // }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Career Outcome";
            }
            
            if (indexPath.row == 4) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"url"]];
                
               // if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
               // }
                
                optionText.text = courseText;
                optionTitle.text = @"Course URL";
            }
            
            if (indexPath.row == 2) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"provtitle"]];
                
               // if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
               // }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Provider";
            }
            
            if (indexPath.row == 8) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"aim"]];
                
               // if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
               // }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Aim";
            }
            
            if (indexPath.row == 9) {
                
                NSMutableString *credit = [[NSMutableString alloc] init];
                
                //credits
                NSArray *creditsArray = [[NSArray alloc] initWithArray:[[resultsArray objectAtIndex:selectedCourse] objectForKey:@"credits"]];
                
                //NSLog(@"credits = %i", creditsArray.count);
                
                for (int x = 0; x < creditsArray.count; x++) {
                    NSString *level = [NSString stringWithFormat:@"Level = %@", [[creditsArray objectAtIndex:x] objectForKey:@"level"]];
                    NSString *scheme = [NSString stringWithFormat:@"Scheme = %@", [[creditsArray objectAtIndex:x] objectForKey:@"scheme"]];
                    NSString *val = [NSString stringWithFormat:@"Value = %@", [[creditsArray objectAtIndex:x] objectForKey:@"val"]];
                    
                    NSString *credits = [NSString stringWithFormat:@"Credit %i \n \n%@ \n%@ \n%@ \n\n", x+1, level, scheme, val];
                    
                    [credit appendString:credits];
                }
                
                courseText = credit;
                
                optionText.text = courseText;
                optionTitle.text = @"Course Credits";
            }
            
            if (indexPath.row == 10) {
                
                NSMutableString *presentations = [[NSMutableString alloc] init];
                
                //presentations
                NSArray *presentationsArray = [[NSArray alloc] initWithArray:[[resultsArray objectAtIndex:selectedCourse] objectForKey:@"presentations"]];
                
                for (int x = 0; x < presentationsArray.count; x++) {
                    
                    NSString *description = [NSString stringWithFormat:@"%@", [[presentationsArray objectAtIndex:x] objectForKey:@"description"]];
                    NSString *studyMode = [NSString stringWithFormat:@"Study Mode: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"studyMode"]];
                    NSString *attendancePattern = [NSString stringWithFormat:@"Attendance Pattern: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"attendancePattern"]];
                    NSString *entryRequirements = [NSString stringWithFormat:@"Entry Requirements: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"entryRequirements"]];
                    NSString *attendanceMode = [NSString stringWithFormat:@"Attendance Mode: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"attendanceMode"]];
                    NSString *languageOfInstruction = [NSString stringWithFormat:@"Language of Instruction: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"languageOfInstruction"]];
                    NSString *languageOfAssessment = [NSString stringWithFormat:@"Language of Assessment: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"languageOfAssessment"]];
                    NSString *start = [NSString stringWithFormat:@"Start: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"start"]];
                    NSString *end = [NSString stringWithFormat:@"End: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"end"]];
                    NSString *duration = [NSString stringWithFormat:@"Duration: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"duration"]];            
                    NSString *cost = [NSString stringWithFormat:@"Cost: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"cost"]];
                    NSString *applicationsOpen = [NSString stringWithFormat:@"Applications Open: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"applicationsOpen"]];
                    NSString *applicationsClose = [NSString stringWithFormat:@"Applications Close: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"applicationsClose"]];
                    NSString *applyTo = [NSString stringWithFormat:@"Apply To: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"applyTo"]];
                    NSString *enquireTo = [NSString stringWithFormat:@"Enquire To: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"enquireTo"]];
                    NSString *name = [NSString stringWithFormat:@"%@", [[presentationsArray objectAtIndex:x] objectForKey:@"name"]];
                    NSString *street = [NSString stringWithFormat:@"%@", [[presentationsArray objectAtIndex:x] objectForKey:@"street"]];
                    NSString *town = [NSString stringWithFormat:@"%@", [[presentationsArray objectAtIndex:x] objectForKey:@"town"]];
                    NSString *postcode = [NSString stringWithFormat:@"%@", [[presentationsArray objectAtIndex:x] objectForKey:@"postcode"]];
                    
                    NSString *presentation = [NSString stringWithFormat:@"Presentation \n \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n Venue \n%@ \n%@ \n%@ \n%@ \n\n", description, studyMode, attendancePattern, entryRequirements, attendanceMode, languageOfInstruction, languageOfAssessment, start, end, duration, cost, applicationsOpen, applicationsClose, applyTo, enquireTo, name, street, town, postcode];
                    
                    [presentations appendString:presentation];
                }
                
                courseText = presentations;
                
                optionText.text = courseText;
                optionTitle.text = @"Course Presentations";
            }
            
            if (indexPath.row == 11) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"assessmentStrategy"]];
                
              //  if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
              //  }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Assessment Strategy";
            }
            
            if (indexPath.row == 12) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"learningOutcome"]];
                
              //  if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
              //  }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Learning Outcome";
            }
            
            if (indexPath.row == 13) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"indicativeResource"]];
                
               // if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
               // }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Indicative Resourse";
            }
            
            if (indexPath.row == 14) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"syllabus"]];
                
               // if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
               // }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Syllabus";
            }
            
            if (indexPath.row == 15) {
                
                NSString *detailsValue = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:selectedCourse] objectForKey:@"leadsTo"]];
                
             //   if (![detailsValue isEqualToString:@"(null)"]) {
                    courseText = detailsValue;
             //   }
                
                optionText.text = courseText;
                optionTitle.text = @"Course Leads To";
            }
 
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
            
            [[self delegate] loadMoreResultsiPad:urlPath];
        }
    }
    
    else {
        optionsTable.hidden = NO;
        selectedCourse = row;
        optionTitle.text = @"";
        optionText.text = @"";
        [optionsTable reloadData];
    }
}

@end