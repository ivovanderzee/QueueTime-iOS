//
//  CallViewController.h
//  QueueTime
//
//  Created by Ivo van der Zee on 03/12/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//


//All the libraries that are used in this viewcontroller
#import <UIKit/UIKit.h>
#import <Sinch/Sinch.h>
#import <AVFoundation/AVFoundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface CallViewController : UIViewController <SINCallClientDelegate, SINCallDelegate>


//The outlet for the textfield is created
@property (weak, nonatomic) IBOutlet UITextField *textField;


//The action for the calluserbutton is created
- (IBAction)callUser:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *callButton;


@end

NS_ASSUME_NONNULL_END
