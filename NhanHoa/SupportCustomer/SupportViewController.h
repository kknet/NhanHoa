//
//  SupportViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendMessageView.h"

@interface SupportViewController : UIViewController<SendMessageViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMsg;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UIView *viewContent;

@property (nonatomic, strong) SendMessageView *sendMsgView;

- (IBAction)btnSendMsgPress:(UIButton *)sender;
- (IBAction)btnCallPress:(UIButton *)sender;

@end
