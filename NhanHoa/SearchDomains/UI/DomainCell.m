//
//  DomainCell.m
//  NhanHoa
//
//  Created by admin on 4/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainCell.h"

@implementation DomainCell
@synthesize lbDomain, lbPrice, btnChoose, btnWarning, parentView, padding, marginX, btnViewInfo;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    parentView.layer.cornerRadius = 5.0;
    
    marginX = 15.0;
    padding = 15.0;
    float hBTN = 50.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        hBTN = 40.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        hBTN = 42.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        hBTN = 50.0;
    }
    
    [parentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.right.equalTo(self).offset(-2.0);
        make.bottom.equalTo(self).offset(-15.0);
    }];
    
    btnChoose.titleLabel.font = textFont;
    btnChoose.layer.cornerRadius = 8.0;
    btnChoose.layer.borderWidth = 1.0;
    btnChoose.layer.borderColor = [UIColor colorWithRed:(176/255.0) green:(181/255.0)
                                                   blue:(193/255.0) alpha:1.0].CGColor;
    [btnChoose setTitleColor:[UIColor colorWithRed:(176/255.0) green:(181/255.0)
                                              blue:(193/255.0) alpha:1.0]
                    forState:UIControlStateNormal];
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(parentView.mas_centerY);
        make.right.equalTo(parentView).offset(-marginX);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(hBTN);
    }];
    
    float sizeText = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"View info"] withFont:textFont andMaxWidth:SCREEN_WIDTH].width + 10.0;
    
    btnViewInfo.titleLabel.font = textFont;
    btnViewInfo.layer.cornerRadius = 8.0;
    btnViewInfo.hidden = TRUE;
    btnViewInfo.backgroundColor = ORANGE_COLOR;
    [btnViewInfo setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnViewInfo setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"View info"] forState:UIControlStateNormal];
    [btnViewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(parentView.mas_centerY);
        make.right.equalTo(parentView).offset(-marginX);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbDomain.textColor = GRAY_50;
    lbDomain.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize];
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(parentView).offset(padding);
        make.bottom.equalTo(parentView.mas_centerY).offset(-2.0);
    }];
    
    btnWarning.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [btnWarning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbDomain.mas_right);
        make.centerY.equalTo(lbDomain.mas_centerY);
        make.width.height.mas_equalTo(35.0);
    }];
    
    lbPrice.textColor = ORANGE_COLOR;
    lbPrice.font = [UIFont fontWithName:RobotoThin size:textFont.pointSize];
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(parentView).offset(padding);
        make.top.equalTo(parentView.mas_centerY).offset(2.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateSizeButtonWithContent: (NSString *)content {
    float size = [AppUtils getSizeWithText:content withFont:btnChoose.titleLabel.font].width + 20.0;
    if (size < 60.0) {
        size = 60.0;
    }
    
    [btnChoose mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(parentView.mas_centerY);
        make.right.equalTo(parentView).offset(-marginX);
        make.width.mas_equalTo(size);
        make.height.mas_equalTo(36.0);
    }];
}

- (void)showPriceForDomainCell: (BOOL)show {
    float size = [AppUtils getSizeWithText:btnChoose.currentTitle withFont:btnChoose.titleLabel.font].width + 20.0;
    if (size < 60.0) {
        size = 60.0;
    }
    
    [btnChoose mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(parentView.mas_centerY);
        make.right.equalTo(parentView).offset(-marginX);
        make.width.mas_equalTo(size);
        make.height.mas_equalTo(36.0);
    }];
    
    if (show) {
        [lbDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(parentView).offset(marginX);
            make.bottom.equalTo(parentView.mas_centerY).offset(-2.0);
        }];
        
        [btnWarning mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbDomain.mas_right);
            make.centerY.equalTo(lbDomain.mas_centerY);
            make.width.height.mas_equalTo(35.0);
        }];
        
        lbPrice.hidden = FALSE;
        [lbPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(parentView).offset(marginX);
            make.top.equalTo(parentView.mas_centerY).offset(2.0);
        }];
        
    }else{
        [lbDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(parentView).offset(marginX);
            make.top.bottom.equalTo(parentView);
        }];
        
        [btnWarning mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbDomain.mas_right);
            make.centerY.equalTo(lbDomain.mas_centerY);
            make.width.height.mas_equalTo(35.0);
        }];
        lbPrice.hidden = TRUE;
    }
}

@end
