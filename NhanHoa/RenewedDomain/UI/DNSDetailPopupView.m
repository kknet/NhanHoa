//
//  DNSDetailPopupView.m
//  NhanHoa
//
//  Created by OS on 8/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DNSDetailPopupView.h"

@implementation DNSDetailPopupView

@synthesize viewHeader, lbHeader, icClose, lbName, tfName, lbType, tfType, lbMX, tfMX, lbValue, tfValue, lbTTL, tfTTL, btnEdit, btnDelete;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame hasMXValue: (BOOL)hasMX {
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor =  UIColor.whiteColor;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = [AppDelegate sharedInstance].radius;
        
        viewHeader = [[UIView alloc] init];
        viewHeader.backgroundColor = BLUE_COLOR;
        [self addSubview: viewHeader];
        [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo([AppDelegate sharedInstance].hNav);
        }];
        
        lbHeader = [[UILabel alloc] init];
        lbHeader.textAlignment = NSTextAlignmentCenter;
        lbHeader.text = @"Thông tin Record";
        lbHeader.font = [AppDelegate sharedInstance].fontBTN;
        lbHeader.textColor = UIColor.whiteColor;
        [viewHeader addSubview: lbHeader];
        [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(viewHeader);
            make.centerX.equalTo(viewHeader.mas_centerX);
            make.width.mas_equalTo(250.0);
        }];
        
        icClose = [[UIButton alloc] init];
        [icClose setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        icClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        [icClose addTarget:self
                    action:@selector(closePopupView)
          forControlEvents:UIControlEventTouchUpInside];
        [viewHeader addSubview: icClose];
        [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lbHeader.mas_centerY);
            make.right.equalTo(viewHeader);
            make.width.height.mas_equalTo(40.0);
        }];
        
        //  content
        float padding = 7.5;
        float margin = 15.0;
        
        float paddingSub = 15.0;
        if ([DeviceUtils isScreen320]) {
            SCREEN_WIDTH - 2*paddingSub;
        }
        
        float leftSize = [AppUtils getSizeWithText:@"Giá trị record" withFont:[AppDelegate sharedInstance].fontRegular andMaxWidth:SCREEN_WIDTH].width + 5.0;
        float wSize = SCREEN_WIDTH - 2*paddingSub;
        
        
        lbName = [[UILabel alloc] init];
        lbName.text = @"Tên record";
        [self addSubview: lbName];
        [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewHeader.mas_bottom).offset(20.0);
            make.left.equalTo(self).offset(padding);
            make.width.mas_equalTo(leftSize);
            make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
        }];
        
        
        tfName = [[UITextField alloc] init];
        tfName.borderStyle = UITextBorderStyleNone;
        [self addSubview: tfName];
        [AppUtils setBorderForTextfield:tfName borderColor:BORDER_COLOR];
        [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lbName);
            make.left.equalTo(lbName.mas_right).offset(padding);
            make.width.mas_equalTo(wSize-(3*padding + leftSize));
        }];
        
        //  type value
        lbType = [[UILabel alloc] init];
        lbType.text = @"Loại record";
        [self addSubview: lbType];
        [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbName.mas_bottom).offset(margin);
            make.left.right.equalTo(lbName);
            make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
        }];
        
        tfType = [[UITextField alloc] init];
        tfType.borderStyle = UITextBorderStyleNone;
        [self addSubview: tfType];
        [AppUtils setBorderForTextfield:tfType borderColor:BORDER_COLOR];
        [tfType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lbType);
            make.left.right.equalTo(tfName);
        }];
        
        //  mx value
        if (hasMX) {
            lbMX = [[UILabel alloc] init];
            lbMX.text = @"Giá trị MX";
            [self addSubview: lbMX];
            [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lbType.mas_bottom).offset(margin);
                make.left.right.equalTo(lbType);
                make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
            }];
            
            tfMX = [[UITextField alloc] init];
            tfMX.borderStyle = UITextBorderStyleNone;
            [self addSubview: tfMX];
            [AppUtils setBorderForTextfield:tfMX borderColor:BORDER_COLOR];
            [tfMX mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(lbMX);
                make.left.right.equalTo(tfType);
            }];
        }
        
        //  value
        lbValue = [[UILabel alloc] init];
        lbValue.text = @"Giá trị record";
        [self addSubview: lbValue];
        
        if (hasMX) {
            [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lbMX.mas_bottom).offset(margin);
                make.left.right.equalTo(lbMX);
                make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
            }];
        }else{
            [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lbType.mas_bottom).offset(margin);
                make.left.right.equalTo(lbType);
                make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
            }];
        }
        
        tfValue = [[UITextField alloc] init];
        tfValue.borderStyle = UITextBorderStyleNone;
        [self addSubview: tfValue];
        [AppUtils setBorderForTextfield:tfValue borderColor:BORDER_COLOR];
        [tfValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lbValue);
            make.left.right.equalTo(tfType);
        }];
        
        //  TTL
        lbTTL = [[UILabel alloc] init];
        lbTTL.text = @"Giá trị TTL";
        [self addSubview: lbTTL];
        [lbTTL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbValue.mas_bottom).offset(margin);
            make.left.right.equalTo(lbValue);
            make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
        }];
        
        tfTTL = [[UITextField alloc] init];
        tfTTL.borderStyle = UITextBorderStyleNone;
        [self addSubview: tfTTL];
        [AppUtils setBorderForTextfield:tfTTL borderColor:BORDER_COLOR];
        [tfTTL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lbTTL);
            make.left.right.equalTo(tfValue);
        }];
        
        btnEdit = [[UIButton alloc] init];
        [btnEdit setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btnEdit setTitle:@"Sửa Record" forState:UIControlStateNormal];
        [btnEdit addTarget:self
                    action:@selector(clickOnEditButton:)
          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: btnEdit];
        [btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tfTTL.mas_bottom).offset(margin);
            make.left.equalTo(tfTTL);
            make.right.equalTo(tfTTL.mas_centerX).offset(-5.0);
            make.height.mas_equalTo(45.0);
        }];
        
        btnDelete = [[UIButton alloc] init];
        [btnDelete setTitle:@"Xóa Record" forState:UIControlStateNormal];
        [btnDelete addTarget:self
                      action:@selector(clickOnDeleteButton:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: btnDelete];
        [btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(btnEdit);
            make.left.equalTo(tfTTL.mas_centerX).offset(5.0);
            make.right.equalTo(tfTTL);
        }];
        
        btnEdit.layer.cornerRadius = btnDelete.layer.cornerRadius = [AppDelegate sharedInstance].radius;
        btnEdit.backgroundColor = BLUE_COLOR;
        btnDelete.backgroundColor = NEW_PRICE_COLOR;
        btnEdit.titleLabel.font = btnDelete.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
        
        lbName.textColor = lbType.textColor = lbValue.textColor = lbMX.textColor = lbTTL.textColor = TITLE_COLOR;
        lbName.font = lbType.font = lbValue.font = lbMX.font = lbTTL.font = [AppDelegate sharedInstance].fontRegular;
        tfName.font = tfType.font = tfValue.font = tfMX.font = tfTTL.font = [AppDelegate sharedInstance].fontRegular;
        
        tfName.enabled = tfType.enabled = tfMX.enabled = tfValue.enabled = tfTTL.enabled = FALSE;
        tfName.backgroundColor = tfType.backgroundColor = tfMX.backgroundColor = tfValue.backgroundColor = tfTTL.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    }
    return self;
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
            //  [self removeFromSuperview];
        }
    }];
}

- (void)closePopupView {
    [self fadeOut];
    
    if ([delegate respondsToSelector:@selector(closeDNSRecordOnPopupView)]) {
        [delegate closeDNSRecordOnPopupView];
    }
}

- (void)showDNSRecordInfoWithContent: (NSDictionary *)info {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] info = %@", __FUNCTION__, @[info])];
    
    if (info != nil) {
        NSString *record_name = [info objectForKey:@"record_name"];
        tfName.text = (![AppUtils isNullOrEmpty: record_name]) ? record_name : @"";
        
        NSString *record_type = [info objectForKey:@"record_type"];
        tfType.text = (![AppUtils isNullOrEmpty: record_type]) ? record_type : @"";
        
        NSString *record_mx = [info objectForKey:@"record_mx"];
        tfMX.text = (![AppUtils isNullOrEmpty: record_mx]) ? record_mx : @"";
        
        NSString *record_value = [info objectForKey:@"record_value"];
        tfValue.text = (![AppUtils isNullOrEmpty: record_value]) ? record_value : @"";
        
        NSString *record_ttl = [info objectForKey:@"record_ttl"];
        tfTTL.text = (![AppUtils isNullOrEmpty: record_ttl]) ? record_ttl : @"";
        
//        if (![AppUtils isNullOrEmpty: record_type] && [record_type isEqualToString: type_MX]) {
//            [self showMXField: TRUE];
//        }else{
//            [self showMXField: FALSE];
//        }
    }
}

- (void)clickOnEditButton: (UIButton *)sender {
    [self fadeOut];
    [self performSelector:@selector(callEditDelegate:) withObject:sender afterDelay:0.35];
}

- (void)callEditDelegate: (UIButton *)sender {
    if ([delegate respondsToSelector:@selector(editDNSRecordOnPopupViewWithTag:)]) {
        [delegate editDNSRecordOnPopupViewWithTag: (int)sender.tag];
    }
}

- (void)clickOnDeleteButton: (UIButton *)sender {
    if ([delegate respondsToSelector:@selector(deleteDNSRecordOnPopupViewWithTag:)]) {
        [delegate deleteDNSRecordOnPopupViewWithTag: (int)sender.tag];
    }
}

@end
