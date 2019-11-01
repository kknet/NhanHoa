//
//  DNSRecordPopupView.m
//  NhanHoa
//
//  Created by OS on 11/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DNSRecordPopupView.h"

@implementation DNSRecordPopupView

@synthesize viewTop, lbRecordName, lbRecordNameValue, lbRecordType, lbRecordTypeValue, lbRecordValue, lbRecordValueValue, lbMX, lbMXValue, lbTTL, lbTTLValue, icClose;
@synthesize viewBottom, btnEdit, btnDelete;
@synthesize delegate, recordId;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor =  UIColor.clearColor;
        float padding = 15.0;
        float hContent = 28.0;
        float hTitle = 18.0;
        float hBTN = 50.0;
        
        float hTop = 10.0 + (hTitle + hContent) + 6.0 + (hTitle + hContent) + 10.0;
        
        UIFont *textFont = [UIFont fontWithName:RobotoRegular size:22.0];
        if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
            textFont = [UIFont fontWithName:RobotoRegular size:18.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
            textFont = [UIFont fontWithName:RobotoRegular size:20.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
            textFont = [UIFont fontWithName:RobotoRegular size:22.0];
        }
        
        viewTop = [[UIView alloc] init];
        viewTop.layer.cornerRadius = 15.0;
        viewTop.clipsToBounds = TRUE;
        viewTop.backgroundColor = UIColor.whiteColor;
        [self addSubview: viewTop];
        [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(padding);
            make.right.equalTo(self).offset(-padding);
            make.height.mas_equalTo(hTop);
        }];
        
        lbRecordNameValue = [[UILabel alloc] init];
        [viewTop addSubview: lbRecordNameValue];
        [lbRecordNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(viewTop.mas_centerY).offset(-3.0);
            make.left.equalTo(viewTop).offset(padding);
            make.right.equalTo(viewTop.mas_centerX).offset(-padding/2);
            make.height.mas_equalTo(hContent);
        }];
        
        lbRecordName = [[UILabel alloc] init];
        lbRecordName.text = SFM(@"%@:", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Name"]);
        [viewTop addSubview: lbRecordName];
        [lbRecordName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lbRecordNameValue.mas_top);
            make.left.right.equalTo(lbRecordNameValue);
            make.height.mas_equalTo(hTitle);
        }];
        
        //  record value
        lbRecordValue = [[UILabel alloc] init];
        lbRecordValue.text = SFM(@"%@:", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Value"]);
        [viewTop addSubview: lbRecordValue];
        [lbRecordValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewTop.mas_centerY).offset(3.0);
            make.left.right.equalTo(lbRecordNameValue);
            make.height.mas_equalTo(hTitle);
        }];
        
        lbRecordValueValue = [[UILabel alloc] init];
        [viewTop addSubview: lbRecordValueValue];
        [lbRecordValueValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbRecordValue.mas_bottom);
            make.left.right.equalTo(lbRecordValue);
            make.height.mas_equalTo(hContent);
        }];
        
        //  record type
        lbRecordTypeValue = [[UILabel alloc] init];
        [viewTop addSubview: lbRecordTypeValue];
        [lbRecordTypeValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewTop.mas_centerX).offset(padding/2);
            make.top.bottom.equalTo(lbRecordNameValue);
            make.right.equalTo(viewTop).offset(-padding);
        }];
        
        lbRecordType = [[UILabel alloc] init];
        lbRecordType.text = SFM(@"%@:", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Type"]);
        [viewTop addSubview: lbRecordType];
        [lbRecordType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lbRecordName);
            make.left.right.equalTo(lbRecordTypeValue);
        }];
        
        //  close popup
        icClose = [[UIButton alloc] init];
        icClose.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        [icClose setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
        [icClose addTarget:self
                    action:@selector(fadeOut)
          forControlEvents:UIControlEventTouchUpInside];
        [viewTop addSubview: icClose];
        [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(viewTop);
            make.width.height.mas_equalTo(40.0);
        }];
        
        //  MX
        lbMX = [[UILabel alloc] init];
        lbMX.text = @"MX";
        [viewTop addSubview: lbMX];
        [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbRecordTypeValue);
            make.top.bottom.equalTo(lbRecordValue);
            make.width.mas_equalTo(SCREEN_WIDTH/4);
        }];
        
        lbMXValue = [[UILabel alloc] init];
        [viewTop addSubview: lbMXValue];
        [lbMXValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lbRecordValueValue);
            make.left.right.equalTo(lbMX);
        }];
        
        //  TTL
        lbTTL = [[UILabel alloc] init];
        lbTTL.text = @"TTL";
        [viewTop addSubview: lbTTL];
        [lbTTL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbMX.mas_right);
            make.top.bottom.equalTo(lbMX);
            make.right.equalTo(lbRecordTypeValue);
        }];
        
        lbTTLValue = [[UILabel alloc] init];
        [viewTop addSubview: lbTTLValue];
        [lbTTLValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lbMXValue);
            make.left.right.equalTo(lbTTL);
        }];
        
        //  bottom view
        viewBottom = [[UIView alloc] init];
        viewBottom.layer.cornerRadius = 15.0;
        viewBottom.clipsToBounds = TRUE;
        viewBottom.backgroundColor = UIColor.whiteColor;
        [self addSubview: viewBottom];
        [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewTop.mas_bottom).offset(padding);
            make.left.right.equalTo(viewTop);
            make.height.mas_equalTo(2*hBTN + 1.0);
        }];
        
        btnEdit = [[UIButton alloc] init];
        [btnEdit addTarget:self
                    action:@selector(onEditDNSButtonPress)
          forControlEvents:UIControlEventTouchUpInside];
        [btnEdit setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Edit Record"] forState:UIControlStateNormal];
        [viewBottom addSubview: btnEdit];
        [btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(viewBottom);
            make.height.mas_equalTo(hBTN);
        }];
        
        
        btnDelete = [[UIButton alloc] init];
        [btnDelete addTarget:self
                    action:@selector(onDeleteDNSButtonPress)
          forControlEvents:UIControlEventTouchUpInside];
        [btnDelete setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Delete Record"] forState:UIControlStateNormal];
        [viewBottom addSubview: btnDelete];
        [btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(viewBottom);
            make.height.mas_equalTo(hBTN);
        }];
        
        UILabel *lbSepa = [[UILabel alloc] init];
        lbSepa.backgroundColor = GRAY_235;
        [viewBottom addSubview: lbSepa];
        [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewBottom);
            make.centerY.equalTo(viewBottom.mas_centerY);
            make.height.mas_equalTo(1.0);
        }];
        
        lbRecordName.textColor = lbRecordType.textColor = lbRecordValue.textColor = lbMX.textColor = lbTTL.textColor = GRAY_150;
        lbRecordNameValue.textColor = lbRecordTypeValue.textColor = lbRecordValueValue.textColor = lbMXValue.textColor = lbTTLValue.textColor = GRAY_80;
        
        lbRecordName.font = lbRecordType.font = lbRecordValue.font = lbMX.font = lbTTL.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize-4];
        lbRecordNameValue.font = lbRecordTypeValue.font = lbRecordValueValue.font = lbMXValue.font = lbTTLValue.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
        
        [btnEdit setTitleColor:GRAY_80 forState:UIControlStateNormal];
        [btnDelete setTitleColor:GRAY_80 forState:UIControlStateNormal];
        btnEdit.titleLabel.font = btnDelete.titleLabel.font = textFont;
    }
    return self;
}

- (void)onEditDNSButtonPress {
    [self fadeOut];
    
    if ([delegate respondsToSelector:@selector(onButtonEditDNSRecordPressWithRecordId:)]) {
        [delegate onButtonEditDNSRecordPressWithRecordId: recordId];
    }
}

- (void)onDeleteDNSButtonPress {
    [self fadeOut];
    
    if ([delegate respondsToSelector:@selector(onButtonDeleteDNSRecordPressWithRecordId:)]) {
        [delegate onButtonDeleteDNSRecordPressWithRecordId: recordId];
    }
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated {
    //Add transparent
    UIView *viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewBackground.backgroundColor = UIColor.blackColor;
    viewBackground.alpha = 0.5;
    viewBackground.tag = 20;
    [aView addSubview:viewBackground];
    
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut {
    for (UIView *subView in self.superview.subviews){
        if (subView.tag == 20){
            [subView removeFromSuperview];
        }
    }
    
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self removeFromSuperview];
        }
    }];
}

- (void)displayRecordContentWithInfo: (NSDictionary *)info {
    if (info != nil && [info isKindOfClass:[NSDictionary class]]) {
        recordId = [info objectForKey:@"record_id"];
        
        NSString *record_name = [info objectForKey:@"record_name"];
        lbRecordNameValue.text = (![AppUtils isNullOrEmpty: record_name]) ? record_name : @"";
        
        NSString *record_type = [info objectForKey:@"record_type"];
        lbRecordTypeValue.text = (![AppUtils isNullOrEmpty: record_type]) ? record_type : @"";
        
        NSString *record_value = [info objectForKey:@"record_value"];
        lbRecordValueValue.text = (![AppUtils isNullOrEmpty: record_value]) ? record_value : @"";
        
        NSString *record_mx = [info objectForKey:@"record_mx"];
        lbMXValue.text = (![AppUtils isNullOrEmpty: record_mx]) ? record_mx : @"";
        
        NSString *record_ttl = [info objectForKey:@"record_ttl"];
        lbTTLValue.text = (![AppUtils isNullOrEmpty: record_ttl]) ? record_ttl : @"";
        
    }else{
        lbRecordNameValue.text = lbRecordTypeValue.text = lbRecordValueValue.text = lbMXValue.text = lbTTLValue.text = @"";
    }
}

@end
