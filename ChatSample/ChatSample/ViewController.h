//
//  ViewController.h
//  ChatSample
//
//  Created by Jeremiah on 24/03/17.
//  Copyright © 2017 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constaintBottomSpaceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTextViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIView *viewSendMessage;
@property (weak, nonatomic) IBOutlet UITableView *tableviewChat;
- (IBAction)buttonActionSend:(id)sender;

@end

