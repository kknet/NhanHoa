//
//  SendMessageView.h
//  NhanHoa
//
//  Created by Khai Leo on 6/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SendMessageViewDelegate <NSObject>
- (void)closeSendMessageView;
- (void)startToSendMessageWithEmail: (NSString *)email content: (NSString *)content;
@end

@interface SendMessageView : UIView

@property (nonatomic, strong) id<SendMessageViewDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icClose;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UITextView *tvContent;
@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;

- (IBAction)btnResetPress:(UIButton *)sender;
- (IBAction)btnSendPress:(UIButton *)sender;
- (IBAction)icCloseClick:(UIButton *)sender;

- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
