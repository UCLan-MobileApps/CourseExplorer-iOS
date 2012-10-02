//
//  LISMasterViewController.h
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
