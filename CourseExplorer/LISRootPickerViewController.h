//
//  LISRootPickerViewController.h
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
