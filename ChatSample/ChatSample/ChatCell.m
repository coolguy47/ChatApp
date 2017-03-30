//
//  ChatCell.m
//  ChatSample
//
//  Created by Jeremiah on 24/03/17.
//  Copyright © 2017 Jeremiah. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _viewBotChat.layer.cornerRadius =10;
    _viewBotChat.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _viewBotChat.layer.borderWidth = 0.2;
    _viewBotChat.clipsToBounds=YES;
    _viewSenderChat.layer.cornerRadius=10;
    _viewSenderChat.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _viewSenderChat.layer.borderWidth = 0.2;
    _viewSenderChat.clipsToBounds=YES;
    _imageBot.layer.cornerRadius =25;
    _imageBot.clipsToBounds=YES;
    _imageSender.layer.cornerRadius=25;
    _imageSender.clipsToBounds=YES;
    _chatBot.numberOfLines=0;
    [_chatBot sizeToFit];
    _chatSender.numberOfLines=0;
    [_chatSender sizeToFit];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
