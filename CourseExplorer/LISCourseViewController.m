//
//  LISCourseViewController.m
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
#import "LISCourseViewController.h"
#import "LISResultsViewAccessController.h"

@interface LISCourseViewController ()

@end

@implementation LISCourseViewController

@synthesize courseTable;
@synthesize courseTitle;
@synthesize detailsView;
@synthesize detailsText;
@synthesize topic;
@synthesize courseArray;
@synthesize row;
@synthesize detail;
@synthesize courseText;

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
    self.title = courseTitle;
    
    BOOL UIAccessibilityIsVoiceOverRunning();
    
    courseTable.backgroundColor = [UIColor clearColor];
    courseTable.separatorColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
}

- (void)viewDidUnload
{
    [self setCourseTable:nil];
    [self setDetailsView:nil];
    [self setDetailsText:nil];
    [self setTopic:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 17;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
  //  if (section == 0) {
        
       // NSString *displayResults = [NSString stringWithFormat:@"Select an option below to view the details for this course."];
        
       // return displayResults;
 //   }
    
    return NULL;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    return NULL;	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
  
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
        
    if (cell == nil) {
            
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier];
    }
    
    if (indexPath.section == 4) {
        
        cell.textLabel.text = @"Course Subjects";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
        
    }
    if (indexPath.section == 6) {
        
        cell.textLabel.text = @"Course Qualifications";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
        
    }
    if (indexPath.section == 1) {
        
        cell.textLabel.text = @"Course Description";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
        
    }
    if (indexPath.section == 7) {
        
        cell.textLabel.text = @"Course Prerequisites";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
        
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = @"Course Abstract";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }
    if (indexPath.section == 8) {
        cell.textLabel.text = @"Course Career Outcome";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }
    if (indexPath.section == 5) {
        cell.textLabel.text = @"Course URL";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }
    if (indexPath.section == 3) {
        cell.textLabel.text = @"Course Provider";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }
    if (indexPath.section == 9) {
        cell.textLabel.text = @"Course Aim";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }
    if (indexPath.section == 10) {
        cell.textLabel.text = @"Course Credits";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }   
    if (indexPath.section == 11) {
        cell.textLabel.text = @"Course Presentations";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }    
    if (indexPath.section == 12) {
        cell.textLabel.text = @"Course Assessment Strategy";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }    
    if (indexPath.section == 13) {
        cell.textLabel.text = @"Course Learning Outcome";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }    
    if (indexPath.section == 14) {
        cell.textLabel.text = @"Course Indicative Resources";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }
    if (indexPath.section == 15) {
        cell.textLabel.text = @"Course Syllabus";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }
    
    if (indexPath.section == 16) {
        cell.textLabel.text = @"Course Leads To";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.758 green:0.137 blue:0.395 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"Return to Results";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
       // courseTable.separatorColor = [UIColor blackColor];
        
        return cell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int selected = indexPath.section;
    
    //display data
    if (selected == 4) {
        
        NSString *tempString = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"subject"]];
            
        courseText = tempString;
        
        topic.text = @"Course Subjects";
    }
    
    if (selected == 6) {

        NSString *qualTitle = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"qualtitle"]];
        NSString *awardedBy = [NSString stringWithFormat:@"Awarded By: %@", [[courseArray objectAtIndex:row] objectForKey:@"awardedBy"]];
        NSString *level = [NSString stringWithFormat:@"Level: %@", [[courseArray objectAtIndex:row] objectForKey:@"level"]];
        NSString *qualDescription = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"qualdescription"]];
        NSString *type = [NSString stringWithFormat:@"Type: %@", [[courseArray objectAtIndex:row] objectForKey:@"type"]];
        NSString *accreditedBy = [NSString stringWithFormat:@"Accredited By: %@", [[courseArray objectAtIndex:row] objectForKey:@"accreditedBy"]];
        NSString *levelControlledTerm = [NSString stringWithFormat:@"Level Controlled Term: %@", [[courseArray objectAtIndex:row] objectForKey:@"levelControlledTerm"]];
    
        courseText = [NSString stringWithFormat:@"%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ ", qualTitle, qualDescription, level, type, awardedBy, accreditedBy, levelControlledTerm]; 
        
        topic.text = @"Course Qualifications";
    }
    
    if (selected == 1) {
        
        NSString *tempString = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"description"]];
        
        NSString *tempString2 = [tempString stringByReplacingOccurrencesOfString:@"\t" withString:@""];

        courseText = tempString2;
        
        topic.text = @"Course Description";
    }
    
    if (selected == 7) {

        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"prerequisites"]];
        
        if (![detailsValue isEqualToString:@"(null)"]) {
            courseText = detailsValue;
        }
        
        topic.text = @"Course Prerequisities";
    }
    
    if (selected == 2) {
        
        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"abstract"]];

        courseText = detailsValue;
        
        topic.text = @"Course Abstract";
    }
    
    if (selected == 8) {
        
        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"careerOutcome"]];

        courseText = detailsValue;

        topic.text = @"Course Career Outcome";
    }
    
    if (selected == 5) {
        
        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"url"]];

        courseText = detailsValue;
        
        topic.text = @"Course URL";
    }
    
    if (selected == 3) {
        
        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"provtitle"]];
        
        courseText = detailsValue;

        topic.text = @"Course Provider";
    }
    
    if (selected == 9) {
        
        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"aim"]];
        
        courseText = detailsValue;
        
        topic.text = @"Course Aim";
    }
    
    if (selected == 10) {
        
        NSMutableString *credit = [[NSMutableString alloc] init];
        
        //credits
        NSArray *creditsArray = [[NSArray alloc] initWithArray:[[courseArray objectAtIndex:row] objectForKey:@"credits"]];
        
        for (int x = 0; x < creditsArray.count; x++) {
            NSString *level = [NSString stringWithFormat:@"Level = %@", [[creditsArray objectAtIndex:x] objectForKey:@"level"]];
            NSString *scheme = [NSString stringWithFormat:@"Scheme = %@", [[creditsArray objectAtIndex:x] objectForKey:@"scheme"]];
            NSString *val = [NSString stringWithFormat:@"Value = %@", [[creditsArray objectAtIndex:x] objectForKey:@"val"]];
            
            NSString *credits = [NSString stringWithFormat:@"Credit %i \n \n%@ \n%@ \n%@ \n\n", x+1, level, scheme, val];
            
            [credit appendString:credits];
        }
        
        courseText = credit;
        
        topic.text = @"Course Credits";
    }
    
    if (selected == 11) {
        
        NSMutableString *presentations = [[NSMutableString alloc] init];
        
        //credits
        NSArray *presentationsArray = [[NSArray alloc] initWithArray:[[courseArray objectAtIndex:row] objectForKey:@"presentations"]];
        
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
            
            NSString *presentation = [NSString stringWithFormat:@"Presentation \n \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n Venue \n \n%@ \n%@ \n%@ \n%@ \n\n", description, studyMode, attendancePattern, entryRequirements, attendanceMode, languageOfInstruction, languageOfAssessment, start, end, duration, cost, applicationsOpen, applicationsClose, applyTo, enquireTo, name, street, town, postcode];
            
            [presentations appendString:presentation];
        }
        
        courseText = presentations;
        
        topic.text = @"Course Presentations";
    }
    
    if (selected == 12) {
        
        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"assessmentStrategy"]];

        courseText = detailsValue;
        
        topic.text = @"Course Assessment Strategy";
    }
    
    if (selected == 13) {
        
        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"learningOutcome"]];

        courseText = detailsValue;
        
        topic.text = @"Course Learning Outcome";
    }
    
    if (selected == 14) {
        
        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"indicativeResource"]];

        courseText = detailsValue;
        
        topic.text = @"Course Indicative Resourse";
    }
    
    if (selected == 15) {
        
        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"syllabus"]];

        courseText = detailsValue;
        
        topic.text = @"Course Syllabus";
    }
    
    if (selected == 16) {
        
        NSString *detailsValue = [NSString stringWithFormat:@"%@", [[courseArray objectAtIndex:row] objectForKey:@"leadsTo"]];

        courseText = detailsValue;
        
        topic.text = @"Course Leads To";
    }
    
    if (selected == 0) {

        [self.navigationController popViewControllerAnimated:NO];
    }
    
    //check for accessibility
    if (UIAccessibilityIsVoiceOverRunning(TRUE)) {
        
        detailsView = [[LISResultsViewAccessController alloc] initWithNibName:@"LISResultViewControllerAccess" bundle:[NSBundle mainBundle]];
        detailsView.detailsString = courseText;
        [self.navigationController pushViewController:detailsView animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    }
    else {
        
    detailsText.text = courseText;
    
    [self.view insertSubview:detail atIndex:10];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)closeDetails:(id)sender {
    
    [detail removeFromSuperview];
}

@end
