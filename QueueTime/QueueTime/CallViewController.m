//
//  CallViewController.m
//  QueueTime
//
//  Created by Ivo van der Zee on 03/12/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//


//The Viewcontroller CallViewController is imported in this viewcontroller
#import "CallViewController.h"

//The library for audio is imported in this viewcontroller
#import <AVFoundation/AVFoundation.h>


//SINClient and SINCall are created to use in this viewcontroller. With this id's a connection can be created
@interface CallViewController ()
{
    id<SINClient> _client;
    id<SINCall> _call;
}

@end

//The CallViewController is implemented
@implementation CallViewController

//The outlet from the CallViewController.h is synthesized
@synthesize textField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



//Code that runs when the view did load
- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    [self initSinchClient];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//The VoIP server is initialized. Here you can see the Sinch user information that I used to set up the connection with the server
- (void)initSinchClient {
    _client = [Sinch clientWithApplicationKey:@"131d2725-c1c6-4289-bbde-a4a1f26b09d7"
                            applicationSecret:@"P05tTASK3kq1IFFJ/p4BTA=="
                              environmentHost:@"sandbox.sinch.com"
               
               //I make the userId static to "B"
                                       userId:@"B"];
    _client.callClient.delegate = self;
    [_client setSupportCalling:YES];
    [_client start];
    [_client startListeningOnActiveConnection];
}

//Code that runs when the user clicks the button to call a user
- (IBAction)callUser:(id)sender {
    
    if (_call == nil)
        
    {
        //The app calls the user that is typed in the textfield
        _call = [_client.callClient callUserWithId:self.textField.text];
        _call.delegate = self;
    }
    else
    {
        [_call hangup];
        _call = nil;
    }
}


  //When a user gets called. This code serves that a user can answer the call
-(void)client:(id<SINCallClient>)client didReceiveIncomingCall:(id<SINCall>)call {

    

    call.delegate = self;
    [call answer];
    _call = call;
}

#pragma mark - SINCallDelegate

- (void)callDidProgress:(id<SINCall>)call {
    
}
  //called when call established
- (void)callDidEstablish:(id<SINCall>)call {
    
    [self.callButton setTitle:@"Hang up" forState:UIControlStateNormal];
}


  //called when call finnished.
- (void)callDidEnd:(id<SINCall>)call {
  
    [self.callButton setTitle:@"Call" forState:UIControlStateNormal];
    _call = nil;
    
}




@end
