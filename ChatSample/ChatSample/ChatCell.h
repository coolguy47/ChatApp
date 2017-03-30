//
//  ChatCell.h
//  ChatSample
//
//  Created by Jeremiah on 24/03/17.
//  Copyright © 2017 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageBot;
@property (weak, nonatomic) IBOutlet UIImageView *imageSender;
@property (weak, nonatomic) IBOutlet UILabel *chatBot;
@property (weak, nonatomic) IBOutlet UILabel *chatSender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintChatBotHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintChatSenderHeight;
@property (weak, nonatomic) IBOutlet UILabel *labelBotTime;
@property (weak, nonatomic) IBOutlet UIView *viewBotChat;
@property (weak, nonatomic) IBOutlet UILabel *labelSenderTime;
@property (weak, nonatomic) IBOutlet UIView *viewSenderChat;

@end
