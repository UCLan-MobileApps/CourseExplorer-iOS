//
//  LISRootViewController.m
//  UKCourses
//
//  Created by Criss Myers on 21/05/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import "LISRootViewController.h"

#import "LISAppSetup.h"
#import "LISXMLParser.h"
#import "LISRootPickerViewController.h"
#import "LISResultsViewController.h"
#import "LISMasterViewController.h"

@implementation LISRootViewController

@synthesize initalSetup;
@synthesize keywords;
@synthesize postcode;
@synthesize picker;
@synthesize pickerControllerView;
@synthesize topView;
@synthesize bottomView;
@synthesize grewView;
@synthesize qualifications;
@synthesize studymodes;
@synthesize searchdistance;
@synthesize displayorder;
@synthesize units;
@synthesize advanced;
@synthesize aboutView;
@synthesize accessabilityView;
@synthesize tapRecognizer;
@synthesize pickerNumber;
@synthesize hidePicker;
@synthesize docsDirectory;
@synthesize providerArray, courseString, qualString, studyString, distString, unitString, orderString, locationString;
@synthesize providerString;
@synthesize xmlParser;
@synthesize qualificationsArray, studymodesArray, searchdistanceArray, displayorderArray, unitsArray;
@synthesize resultsView;
@synthesize alertView;
@synthesize totalHits;
@synthesize loadingMsg;
@synthesize accessPicker;
@synthesize urlPath;
@synthesize ipadResults;
 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //setup the delegates to respond
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        initalSetup = [[LISAppSetup alloc] initWithDelegate:self];
        xmlParser = [[LISXMLParser alloc] initWithDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BOOL UIAccessibilityIsVoiceOverRunning();
    
    //hide the nav bar
    self.navigationController.navigationBarHidden = TRUE;
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    //setup the gester responders for the keyboard and the picker
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    hidePicker = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerViewer:)];
    
    //set the inital picker to 0
    pickerNumber = 0;
    
    //set the respond to loading more results for iphone and ipad as false
    secondary = FALSE;
    secondaryiPad = FALSE;
    
    //set the docs directory to save the temp data
    docsDirectory = NSTemporaryDirectory();
    
    //do the initial load on a separate thread
    [NSThread detachNewThreadSelector:@selector(initalLoad) toTarget:self withObject:nil];
    
    //display loaidng message
    loadingMsg.text = @"Loading Menus....";
    
    //load the views to greyout an disable the interface till the menu loads
    [self.view insertSubview:alertView atIndex:20];
    [self.view insertSubview:grewView belowSubview:alertView];
    
    //setup the options strings with intial options
    providerString = @"7e1643a5-457e-4b5a-8fa8-e7c755a03031";//enter provider code here (Open University)
    qualString = @"*";
    studyString = @"*";
    distString = @"25";
    unitString = @"miles";
    orderString = @"distance";
}

- (void)viewDidUnload
{
    //unload everything
    [self setKeywords:nil];
    [self setPicker:nil];
    [self setPostcode:nil];
    [self setPickerControllerView:nil];
    [self setTopView:nil];
    [self setBottomView:nil];
    [self setGrewView:nil];
    [self setAdvanced:nil];
    [self setQualifications:nil];
    [self setStudymodes:nil];
    [self setSearchdistance:nil];
    [self setDisplayorder:nil];
    [self setUnits:nil];
    [self setAboutView:nil];
    [self setAccessabilityView:nil];
    [self setAlertView:nil];
    [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated {
    
    //set the respond to loading more results for iphone and ipad as false
    secondary = FALSE;
    secondaryiPad = FALSE;
}

//delegate respones for accessibility
-(void)pickerReply:(NSInteger)pickNumber:(NSString *)pickerString:(NSString *)pickerName {
    
    //display the picker based on the option choosen
    if (pickNumber == 2) {
        [qualifications setTitle:pickerName forState:UIControlStateNormal];
        qualString = pickerString;;
    }
    if (pickNumber == 3) {
        [studymodes setTitle:pickerName forState:UIControlStateNormal];
            studyString = pickerString;
    }
}

-(void)loadMoreResults:(NSString *)path {
    
    secondary = TRUE;
    
    [xmlParser parseXMLURL:path];
}

-(void)loadMoreResultsiPad:(NSString *)path {
    
    secondaryiPad = TRUE;
    
    [xmlParser parseXMLURL:path];
}

-(void)initalLoad {
    
    //load the inital options from the aggregator
     [initalSetup parseXMLURL:@"http://coursedata.k-int.com/discover/?adv=&q=blank&provider=&qualification=*&studymode=*&distance=25&dunit=miles&order=distance&location=&format=xml"];
}

-(void)failSetup {
    
    //report any failures
    if (secondary == TRUE) {
        [resultsView reloadFailed];
    }
    
    else if (secondaryiPad == TRUE) {
        [ipadResults reloadFailed];
    }
    
    else {
    
    [alertView removeFromSuperview];
    [grewView removeFromSuperview];
    
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"The inital setup failed, please close the app to reload or try again later");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to contact the server, please close and reopen the App or try again later as this may be a network issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    }
}

#pragma load information view
-(IBAction)loadInfo:(id)sender {
    
    //display the about info
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:([self.view superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
	
	[self.view insertSubview:aboutView atIndex:50];
	
	[UIView commitAnimations];
    
}

-(IBAction)switchBack:(id)sender {
    
    //switch back to the main menu
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:([self.view superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
	
	[aboutView removeFromSuperview];
	
	[UIView commitAnimations];
	
}


#pragma tap gester

-(void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {    
    [keywords resignFirstResponder];
    [postcode resignFirstResponder];
}

-(void)hidePickerViewer: (UITapGestureRecognizer*) recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [pickerControllerView removeFromSuperview];
        [grewView removeFromSuperview];
        [grewView removeGestureRecognizer:hidePicker];
    }
}

#pragma picker

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component  {
    
    if (pickerNumber == 0) {
        return 1;
    }
    if (pickerNumber == 1) {
        return [qualificationsArray count];
    }
    if (pickerNumber == 2) {
        return [studymodesArray count];
    }
    if (pickerNumber == 3) {
        return [searchdistanceArray count];
    }
    if (pickerNumber == 4) {
        return [displayorderArray count];
    }
    if (pickerNumber == 5) {
        return [unitsArray count];
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
 
    if (pickerNumber == 1) {
        return [qualificationsArray objectAtIndex:row];
       
    }
    if (pickerNumber == 2) {
        return [studymodesArray objectAtIndex:row];
       
    }
    if (pickerNumber == 3) {
        return [searchdistanceArray objectAtIndex:row];
       
    }
    if (pickerNumber == 4) {
        return [displayorderArray objectAtIndex:row];
        
    }
    if (pickerNumber == 5) {
        return [unitsArray objectAtIndex:row];
       
    }

    return @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerNumber == 1) {
        [qualifications setTitle:[qualificationsArray objectAtIndex:row] forState:UIControlStateNormal];
        if (row == 0 || row == 1) {
            qualString = @"*";
        }
        else {
            NSString *preString = [NSString stringWithFormat:@"%@", [qualificationsArray objectAtIndex:row]];
            qualString = [preString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        }
        NSLog(@"course = %@",qualString);
    }
    if (pickerNumber == 2) {
        [studymodes setTitle:[studymodesArray objectAtIndex:row] forState:UIControlStateNormal];
        if (row == 0 ||row == 1) {
            studyString = @"*";
        }
        else {
            NSString *preString = [NSString stringWithFormat:@"%@", [studymodesArray objectAtIndex:row]];
            studyString = [preString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        }
    }
    if (pickerNumber == 3) {
        [searchdistance setTitle:[searchdistanceArray objectAtIndex:row] forState:UIControlStateNormal];
        if (row == 0 ) {
            distString = @"25";
        }
        else {
            NSString *preString = [NSString stringWithFormat:@"%@", [searchdistanceArray objectAtIndex:row]];
            distString = [preString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        }
    }
    if (pickerNumber == 4) {
        [displayorder setTitle:[displayorderArray objectAtIndex:row] forState:UIControlStateNormal];
        if (row == 0 || row == 1) {
            orderString = @"distance";
        }
        else {
            NSString *preString = [NSString stringWithFormat:@"%@", [displayorderArray objectAtIndex:row]];
            orderString = [preString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        }
    }
    if (pickerNumber == 5) {
        [units setTitle:[unitsArray objectAtIndex:row] forState:UIControlStateNormal];
        unitString = [NSString stringWithFormat:@"%@", [unitsArray objectAtIndex:row]];
    }
    
}

#pragma retuned data
-(void)setupArrays {
    
    //setup the main options from the aggregator
    
    [alertView removeFromSuperview];
    [grewView removeFromSuperview];
    
    //create the headings
    NSString *qualsPath = [docsDirectory stringByAppendingPathComponent:@"qualifications.plist"];
    NSString *quals = [NSString stringWithFormat:@"Qualifications"];
    
    //load array
    qualificationsArray = [[NSMutableArray alloc] initWithContentsOfFile:qualsPath];
    
    //set the heading
    [qualificationsArray replaceObjectAtIndex:0 withObject:quals];
    
    //create the headings
    NSString *distPath = [docsDirectory stringByAppendingPathComponent:@"distances.plist"];
    NSString *dist = [NSString stringWithFormat:@"Distance"];
    
    //load array
    searchdistanceArray = [[NSMutableArray alloc] initWithContentsOfFile:distPath];
    
    //set the heading
    [searchdistanceArray replaceObjectAtIndex:0 withObject:dist];
    
    //load array
    NSString *dunitsPath = [docsDirectory stringByAppendingPathComponent:@"dunits.plist"];
    unitsArray = [[NSMutableArray alloc] initWithContentsOfFile:dunitsPath];
    
    //remove the heading
    [unitsArray removeObjectAtIndex:0];
    
    //create the headings
    NSString *ordersPath = [docsDirectory stringByAppendingPathComponent:@"orders.plist"];
    NSString *orders = [NSString stringWithFormat:@"Order By"];
    
    //load array
    displayorderArray = [[NSMutableArray alloc] initWithContentsOfFile:ordersPath];
    
    //set the heading
    [displayorderArray replaceObjectAtIndex:0 withObject:orders];
    
    //create the headings
    NSString *studysPath = [docsDirectory stringByAppendingPathComponent:@"studymodes.plist"];
    NSString *studys = [NSString stringWithFormat:@"Attendance"];
    
    //load array
    studymodesArray = [[NSMutableArray alloc] initWithContentsOfFile:studysPath];
    
    //set the heading
    [studymodesArray replaceObjectAtIndex:0 withObject:studys]; 
}

-(void)response {
    
    //respond to the xml and reload the results
    
    if (secondary == TRUE) {
        [resultsView reloadContent];
    }
    
    else if (secondaryiPad == TRUE) {
        [ipadResults reloadContent];
    }
    
    else {
        //check if there are any results
        if ([totalHits isEqualToString:@"0"]) {
            
            [alertView removeFromSuperview];
            [grewView removeFromSuperview];
            
            //alert no results
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"There are no results, please try a broader search or keyword" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
          
    [alertView removeFromSuperview];
    [grewView removeFromSuperview];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        resultsView = [[LISResultsViewController alloc] initWithNibName:@"LISResultsViewController" bundle:[NSBundle mainBundle]];
        
        resultsView.totalHits = totalHits;
        resultsView.searchURL = urlPath;
        [resultsView setDelegate:self];
        
        [self.navigationController pushViewController:resultsView animated:YES];
        
    } else {
        
        ipadResults = [[LISMasterViewController alloc] initWithNibName:@"LISResultsViewController_iPad" bundle:nil];
        
        ipadResults.totalHits = totalHits;
        ipadResults.searchURL = urlPath;
        [ipadResults setDelegate:self];
        
        [self.navigationController pushViewController:ipadResults animated:YES];
    }
        } 
        
    }
}

-(void)totalResults:(NSString *)hits {
    //set the number of hits

    totalHits = hits;
}

#pragma variations
- (IBAction)searchData:(id)sender {
    
    //check to see if a keyword has been entered
    if (keywords.text.length == 0) {
        //alert the user to enter a keyword
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You have not entered a keyword, you must enter a keyword first before you can search" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else {
    
    //search for data and display the searching message and grey out the screen
    loadingMsg.text = @"Searching Courses.....";
    
    [self.view insertSubview:alertView atIndex:20];
    [self.view insertSubview:grewView belowSubview:alertView];
    
    //search on a new thread
    [NSThread detachNewThreadSelector:@selector(doASearch) toTarget:self withObject:nil];
    }
}

-(void)doASearch {
    
    //search for courses from the aggregator
    
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"Searching Courses, please wait");
    
    //NSLog(@"searching");
    courseString = keywords.text;  
    //remove spaces
    NSString *newcourseString = [courseString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    locationString = postcode.text;
    //remove spaces
    NSString *newlocationString = [locationString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    int offset = 0;
    
    urlPath = [NSString stringWithFormat:@"http://coursedata.k-int.com/discover/?adv=true&q=%@&provider=%@&qualification=%@&studyMode=%@&distance=%@&dunit=%@&order=%@&location=%@&max=100&format=xml", newcourseString, providerString, qualString, studyString, distString, unitString, orderString, newlocationString];
    
    NSLog(@"url = %@", urlPath);
    
    NSString *urlPath2 = [NSString stringWithFormat:@"%@&offset=%i", urlPath, offset];
    
    [xmlParser parseXMLURL:urlPath2];
}

#pragma basic or advanced

- (IBAction)loadAdvanced:(id)sender {
    
    //load the advanced options
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
         
         //move topview
         CGRect topViewFrame = topView.frame;
         [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationDuration:.75];
    
         topViewFrame.size.width = 320;
         topViewFrame.size.height = 257;
         topViewFrame.origin.y = -90;
    
         topView.frame = topViewFrame;
         [UIView commitAnimations];
    
         //move bottomview
         CGRect bottomViewFrame = bottomView.frame;
         [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationDuration:.75];
    
         bottomViewFrame.size.width = 320;
         bottomViewFrame.size.height = 240;
         bottomViewFrame.origin.y = 345;
    
         bottomView.frame = bottomViewFrame;
         [UIView commitAnimations];
         
         //set button image to basic
         UIImage *advancedImage = [UIImage imageNamed:@"basiciPhone.png"];
         [advanced setImage:advancedImage forState:UIControlStateNormal];  
         [advanced addTarget:self action:@selector(basic:) forControlEvents:UIControlEventTouchUpInside];
     }
     else {
         //move topview
         CGRect topViewFrame = topView.frame;
         [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationDuration:.75];
         
         topViewFrame.size.width = 768;
         topViewFrame.size.height = 536;
         topViewFrame.origin.y = -225;
         
         topView.frame = topViewFrame;
         [UIView commitAnimations];
         
         //move bottomview
         CGRect bottomViewFrame = bottomView.frame;
         [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationDuration:.75];
         
         bottomViewFrame.size.width = 768;
         bottomViewFrame.size.height = 512;
         bottomViewFrame.origin.y = 562;
         
         bottomView.frame = bottomViewFrame;
         [UIView commitAnimations];
         
         //set button image to basic
         UIImage *advancedImage = [UIImage imageNamed:@"basiciPhone.png"];
         [advanced setImage:advancedImage forState:UIControlStateNormal];  
         [advanced addTarget:self action:@selector(basic:) forControlEvents:UIControlEventTouchUpInside];
     }
    
    //unhide the buttons, required to be hidden for accessibility
    [postcode setHidden:NO];
    [qualifications setHidden:NO];
    [studymodes setHidden:NO];
    [searchdistance setHidden:NO];
    [displayorder setHidden:NO];
    [units setHidden:NO];
    
    //reset buttons titles
    [qualifications setTitle:@"Qualifications" forState:UIControlStateNormal];
    [studymodes setTitle:@"Study Modes" forState:UIControlStateNormal];
    [searchdistance setTitle:@"Search Distance" forState:UIControlStateNormal];
    [displayorder setTitle:@"Display Order" forState:UIControlStateNormal];
    [units setTitle:@"Units" forState:UIControlStateNormal];
         
    
}

-(IBAction)basic:(id)sender {
    
    //load the basic search options
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    
        //move topview
        CGRect topViewFrame = topView.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.75];
    
        topViewFrame.size.width = 320;
        topViewFrame.size.height = 257;
        topViewFrame.origin.y = 0;
    
        topView.frame = topViewFrame;
        [UIView commitAnimations];
    
        //move bottomview
        CGRect bottomViewFrame = bottomView.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.75];
    
        bottomViewFrame.size.width = 320;
        bottomViewFrame.size.height = 240;
        bottomViewFrame.origin.y = 240;
    
        bottomView.frame = bottomViewFrame;
        [UIView commitAnimations];
        
        //set button image back to advanced
        UIImage *advancedImage = [UIImage imageNamed:@"advancediPhone.png"];
        [advanced setImage:advancedImage forState:UIControlStateNormal];    
        [advanced addTarget:self action:@selector(loadAdvanced:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else {
        //move topview
        CGRect topViewFrame = topView.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.75];
        
        topViewFrame.size.width = 768;
        topViewFrame.size.height = 536;
        topViewFrame.origin.y = 0;
        
        topView.frame = topViewFrame;
        [UIView commitAnimations];
        
        //move bottomview
        CGRect bottomViewFrame = bottomView.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.75];
        
        bottomViewFrame.size.width = 768;
        bottomViewFrame.size.height = 512;
        bottomViewFrame.origin.y = 512;
        
        bottomView.frame = bottomViewFrame;
        [UIView commitAnimations];  
        
        
        //set button image back to advanced
        UIImage *advancedImage = [UIImage imageNamed:@"advancediPhone.png"];
        [advanced setImage:advancedImage forState:UIControlStateNormal];    
        [advanced addTarget:self action:@selector(loadAdvanced:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //reset strings
    qualString = @"*";
    studyString = @"*";
    distString = @"25";
    unitString = @"miles";
    orderString = @"distance";
}

- (IBAction)uclanWeb:(id)sender {
}

#pragma advanced options

//set the options buttons and text based on the pikcer
- (IBAction)qualificationSet:(id)sender {
    
    if (UIAccessibilityIsVoiceOverRunning(TRUE)) {
        accessPicker = [[LISRootPickerViewController alloc] initWithNibName:@"LISRootPicker" bundle:[NSBundle mainBundle]];
        accessPicker.qualificationsArray = qualificationsArray;
        accessPicker.pickerNumber = 2;
        [accessPicker setDelegate:self];
        [self.navigationController pushViewController:accessPicker animated:YES];
    }
    
    else {
        
    pickerNumber = 1;
    
    [picker reloadAllComponents];
    
    [picker selectRow:0 inComponent:0 animated:YES];
    
    CGRect pickerFrame = pickerControllerView.frame;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        pickerFrame.origin.y = 270;
    }
    else {
        pickerFrame.origin.y = 788;
    }
    
    pickerControllerView.frame = pickerFrame;
    
    [self.view insertSubview:grewView atIndex:10];
    
    [self.view insertSubview:pickerControllerView aboveSubview:grewView];
    
    [self.grewView addGestureRecognizer:hidePicker];
    
    [pickerControllerView reloadInputViews];
    }
}

- (IBAction)studymodesSet:(id)sender {
    
    if (UIAccessibilityIsVoiceOverRunning(TRUE)) {
        accessPicker = [[LISRootPickerViewController alloc] initWithNibName:@"LISRootPicker" bundle:[NSBundle mainBundle]];
        accessPicker.studymodesArray = studymodesArray;
        accessPicker.pickerNumber = 3;
        [accessPicker setDelegate:self];
        [self.navigationController pushViewController:accessPicker animated:YES];
    }
    
    else {
    
    pickerNumber = 2;
    
    [picker reloadAllComponents];
    
    [picker selectRow:0 inComponent:0 animated:YES];
    
    CGRect pickerFrame = pickerControllerView.frame;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        pickerFrame.origin.y = 270;
    }
    else {
        pickerFrame.origin.y = 788;
    }
    
    pickerControllerView.frame = pickerFrame;
    
    [self.view insertSubview:grewView atIndex:10];
    
    [self.view insertSubview:pickerControllerView aboveSubview:grewView];

    [self.grewView addGestureRecognizer:hidePicker];
    
    [pickerControllerView reloadInputViews];
    }
}

- (IBAction)searchdistanceSet:(id)sender {
    
    if (UIAccessibilityIsVoiceOverRunning(TRUE)) {
        accessPicker = [[LISRootPickerViewController alloc] initWithNibName:@"LISRootPicker" bundle:[NSBundle mainBundle]];
        accessPicker.searchdistanceArray = searchdistanceArray;
        accessPicker.pickerNumber = 4;
        [accessPicker setDelegate:self];
        [self.navigationController pushViewController:accessPicker animated:YES];
    }
    
    else {
    
    pickerNumber = 3;
    
    [picker reloadAllComponents];
    
    [picker selectRow:0 inComponent:0 animated:YES];
    
    CGRect pickerFrame = pickerControllerView.frame;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        pickerFrame.origin.y = 270;
    }
    else {
        pickerFrame.origin.y = 788;
    }
    
    pickerControllerView.frame = pickerFrame;
    
    [self.view insertSubview:grewView atIndex:10];
    
    [self.view insertSubview:pickerControllerView aboveSubview:grewView];
    
    [self.grewView addGestureRecognizer:hidePicker];
    
    [pickerControllerView reloadInputViews];
    }
}

- (IBAction)displayorderSet:(id)sender {
    
    if (UIAccessibilityIsVoiceOverRunning(TRUE)) {
        accessPicker = [[LISRootPickerViewController alloc] initWithNibName:@"LISRootPicker" bundle:[NSBundle mainBundle]];
        accessPicker.displayorderArray = displayorderArray;
        accessPicker.pickerNumber = 5;
        [accessPicker setDelegate:self];
        [self.navigationController pushViewController:accessPicker animated:YES];
    }
    
    else {
    
    pickerNumber = 4;
    
    [picker reloadAllComponents];
    
    [picker selectRow:0 inComponent:0 animated:YES];
    
    CGRect pickerFrame = pickerControllerView.frame;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        pickerFrame.origin.y = 270;
    }
    else {
        pickerFrame.origin.y = 788;
    }
    
    pickerControllerView.frame = pickerFrame;
    
    [self.view insertSubview:grewView atIndex:10];
    
    [self.view insertSubview:pickerControllerView aboveSubview:grewView];
    
    [self.grewView addGestureRecognizer:hidePicker];
    
    [pickerControllerView reloadInputViews];
    }
}

- (IBAction)unitsSet:(id)sender {
    
    if (UIAccessibilityIsVoiceOverRunning(TRUE)) {
        accessPicker = [[LISRootPickerViewController alloc] initWithNibName:@"LISRootPicker" bundle:[NSBundle mainBundle]];
        accessPicker.unitsArray = unitsArray;
        accessPicker.pickerNumber = 6;
        [accessPicker setDelegate:self];
        [self.navigationController pushViewController:accessPicker animated:YES];
    }
    
    else {
    
    pickerNumber = 5;
    
    [picker reloadAllComponents];
    
    [picker selectRow:0 inComponent:0 animated:YES];
    
    CGRect pickerFrame = pickerControllerView.frame;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        pickerFrame.origin.y = 270;
    }
    else {
        pickerFrame.origin.y = 788;
    }
    
    pickerControllerView.frame = pickerFrame;
    
    [self.view insertSubview:grewView atIndex:10];
    
    [self.view insertSubview:pickerControllerView aboveSubview:grewView];
    
    [self.grewView addGestureRecognizer:hidePicker];
    
    [pickerControllerView reloadInputViews];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
