//
//  LISResultsViewController.h
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
