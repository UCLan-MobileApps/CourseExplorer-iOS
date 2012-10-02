//
//  LISCourseViewController.h
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
