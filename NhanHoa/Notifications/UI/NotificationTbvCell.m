//
//  NotificationTbvCell.m
//  NhanHoa
//
//  Created by Khai Leo on 10/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NotificationTbvCell.h"

@implementation NotificationTbvCell
@synthesize viewWrap, imgNotif, lbTitle, lbContent, imgNotifUnread;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = UIColor.clearColor;
    
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
    }
    
    float padding = 15.0;
    
    [imgNotifUnread mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.height.mas_equalTo(18.0);
    }];
    
    [AppUtils addBoxShadowForView:imgNotifUnread color:GRAY_150 opacity:0.8 offsetX:1.5 offsetY:1.5];
    
    viewWrap.backgroundColor = UIColor.whiteColor;
    viewWrap.clipsToBounds = TRUE;
    viewWrap.layer.cornerRadius = 8.0;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(padding/2);
        make.right.equalTo(self).offset(-padding/2);
        make.bottom.equalTo(self).offset(-5.0);
    }];
    
    [imgNotif mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(viewWrap).offset(padding);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbTitle.textColor = GRAY_100;
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgNotif).offset(-2.0);
        make.left.equalTo(imgNotif.mas_right).offset(5.0);
        make.right.equalTo(viewWrap).offset(-5.0);
        //  make.bottom.equalTo(viewWrap.mas_centerY);
    }];
    
    lbContent.textColor = GRAY_150;
    lbContent.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-3];
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbTitle);
        make.top.equalTo(lbTitle.mas_bottom).offset(2.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayContentForCellWithInfo: (NSDictionary *)info {
    NSString *title = [info objectForKey:@"content"];
    lbTitle.text = (![AppUtils isNullOrEmpty: title])? title : @"";
    
    NSString *amount = [info objectForKey:@"amount"];
    NSString *timeValue = [info objectForKey:@"time"];
    NSString *date = [AppUtils getDateStringFromTimerInterval:[timeValue longLongValue]];
    NSString *time = [AppUtils getTimeStringFromTimerInterval:[timeValue longLongValue]];
    
    if (![AppUtils isNullOrEmpty: amount]) {
        NSString *strAmount = [AppUtils convertStringToCurrencyFormat: amount];
        
        NSString *type = [info objectForKey:@"type"];
        if ([type intValue] == 0) {
            strAmount = SFM(@"+%@vnđ", strAmount);
            NSString *content = SFM(@"%@\nNgày %@ lúc %@", strAmount, date, time);
            
            NSRange range = [content rangeOfString: strAmount];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
            [attr addAttribute:NSForegroundColorAttributeName value:GREEN_COLOR range:range];
            
            lbContent.attributedText = attr;
        }else {
            strAmount = SFM(@"-%@vnđ", strAmount);
            
            NSString *content = SFM(@"%@.\nNgày %@ lúc %@", strAmount, date, time);
            
            NSRange range = [content rangeOfString: strAmount];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
            [attr addAttribute:NSForegroundColorAttributeName value:NEW_PRICE_COLOR range:range];
            
            lbContent.attributedText = attr;
        }
    }else{
        lbContent.text = @"";
    }
}

@end
