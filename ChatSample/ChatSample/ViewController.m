//
//  ViewController.m
//  ChatSample
//
//  Created by Jeremiah on 24/03/17.
//  Copyright © 2017 Jeremiah. All rights reserved.
//

#import "ViewController.h"
#import "ChatCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSMutableArray *arrayChats;
    NSTimer *timer;
    CGRect *frameLabel;


}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _textview.layer.borderWidth = 0.5;
    _textview.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _textview.layer.cornerRadius =5;
    _textview.clipsToBounds=YES;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardOffScreen:) name:UIKeyboardWillHideNotification object:nil];
    [self.view bringSubviewToFront:_viewSendMessage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap)];
    [_tableviewChat addGestureRecognizer:tap];
    _buttonSend.layer.cornerRadius=25;
    _buttonSend.clipsToBounds=YES;
    arrayChats =[[NSMutableArray alloc]init];
    NSArray *arrayBot = @[@{@"Bot":@"Hi!Welcome to Jabord "}];
    [arrayChats addObjectsFromArray:arrayBot];
   
    _tableviewChat.separatorStyle= UITableViewCellSeparatorStyleNone;
}
-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
    
    [UIView animateWithDuration:0.5 animations:^{
        _constaintBottomSpaceView.constant=keyboardFrame.size.height+3;
        [self.view layoutIfNeeded];
    }];
   
}
-(void)keyboardOffScreen:(NSNotification *)notification{
    [UIView animateWithDuration:0.5 animations:^{
        _constaintBottomSpaceView.constant=1;
        [self.view layoutIfNeeded];
    }];
}
-(void)didTap
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5 animations:^{
        _constaintBottomSpaceView.constant=1;
        [self.view layoutIfNeeded];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return arrayChats.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ChatCell *cell = (ChatCell*)[tableView dequeueReusableCellWithIdentifier:@"chatcell" forIndexPath:indexPath];
  
  
   
    if ([arrayChats[indexPath.row] valueForKey:@"Bot"]!=nil) {
        NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = NSTextAlignmentJustified;
        style.firstLineHeadIndent = 10.0f;
        style.headIndent = 10.0f;
        style.tailIndent = -10.0f;
        cell.viewBotChat.hidden =NO;
        cell.imageBot.hidden =NO;
         cell.viewSenderChat.hidden=YES;
       cell.imageSender.hidden=YES;
        cell.chatBot.text =[arrayChats[indexPath.row] valueForKey:@"Bot"];
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:cell.chatBot.text attributes:@{ NSParagraphStyleAttributeName : style}];

        cell.chatBot.attributedText = attrText;
        if (frameLabel !=nil) {
             cell.viewBotChat.frame =*(frameLabel);
        }
       
//        NSLog(@"HEIGHT LABEL ---%f",cell.chatBot.frame.size.height);
        return cell;
    }
    else
    {
        NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = NSTextAlignmentRight;
        style.firstLineHeadIndent = 10.0f;
        style.headIndent = 10.0f;
        style.tailIndent = -10.0f;
        cell.viewBotChat.hidden =YES;
        cell.imageBot.hidden =YES;
        cell.viewSenderChat.hidden=NO;
        cell.imageSender.hidden=NO;
        cell.chatSender.text =[arrayChats[indexPath.row] valueForKey:@"Sender"];
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:cell.chatSender.text attributes:@{ NSParagraphStyleAttributeName : style}];
        cell.chatSender.backgroundColor =[UIColor clearColor];
        cell.chatSender.attributedText = attrText;
//         NSLog(@"HEIGHT SENDER ---%f",cell.chatSender.frame.size.height);
//        UIFont *cellFont =   cell.chatSender.font;
//        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
//        CGSize labelSize = [  cell.chatSender.text sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
//          cell.chatSender.frame.size = labelSize;
//        cell.text = cellText;
        if (frameLabel !=nil) {
            cell.viewSenderChat.frame =*(frameLabel);
        }

        
       timer= [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(chatWithBot)
                                       userInfo:nil
                                        repeats:NO];
        return cell;
    }
    
}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
//    return UITableViewAutomaticDimension;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ NSString *str;
      if ([arrayChats[indexPath.row] valueForKey:@"Bot"]!=nil)
      { str = [arrayChats[indexPath.row] valueForKey:@"Bot"];
          
      }
    else
    {
         str = [arrayChats[indexPath.row] valueForKey:@"Sender"];
    }
  
//    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(280,CGFLOAT_MAX) 
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:17]}
                                         context:nil];
    CGRect framelabel= textRect;
    
    CGSize size = textRect.size;
//    NSLog(@"HEIGHT_____%f",size.height);
    if (size.height>20) {
        frameLabel = &framelabel;
        return size.height +50;
    }

    return 64;
}


-(void)chatWithBot
{
    NSLog(@"I am here");
    [timer invalidate];
    switch (arrayChats.count) {
        case 2:
        {  if (self.tableviewChat.contentSize.height>self.tableviewChat.bounds.size.height) {
            [self.tableviewChat setContentOffset:(CGPoint){0, self.tableviewChat.contentSize.height - self.tableviewChat.bounds.size.height} animated:YES];
        }
            NSArray *arrayBot = @[@{@"Bot":@"Are you atleast age 18? "}];
            [arrayChats addObjectsFromArray:arrayBot];
            [_tableviewChat reloadData];
               break;
 
        }
            case 4:
        {
            if (self.tableviewChat.contentSize.height>self.tableviewChat.bounds.size.height) {
                [self.tableviewChat setContentOffset:(CGPoint){0, self.tableviewChat.contentSize.height - self.tableviewChat.bounds.size.height} animated:YES];
            }
            NSArray *arrayBot = @[@{@"Bot":@"Great! Are you legally authorized to work in U.S. "}];
            [arrayChats addObjectsFromArray:arrayBot];
             [_tableviewChat reloadData];
            break;
            
        }
         
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonActionSend:(id)sender {
    if (_textview.text.length!=0) {
        NSArray *arraySender = @[@{@"Sender":_textview.text}];
        [arrayChats addObjectsFromArray:arraySender];
        
        _textview.text=@"";
        [_tableviewChat reloadData];
            if (self.tableviewChat.contentSize.height>self.tableviewChat.bounds.size.height) {
             [self.tableviewChat setContentOffset:(CGPoint){0, self.tableviewChat.contentSize.height - self.tableviewChat.bounds.size.height} animated:YES];
        }
       
//        @try {
//             [_tableviewChat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:arrayChats.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//             }
//             @catch ( NSException *e )
//            {
//                NSLog(@"bummer: %@",e);
//            }
        
        
    }
}
@end
