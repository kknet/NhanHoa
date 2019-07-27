//
//  SuggestDomainCell.m
//  NhanHoa
//
//  Created by admin on 4/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SuggestDomainCell.h"

@implementation SuggestDomainCell
@synthesize imgType, lbSepa, lbDomain, lbPrice, lbOldPrice, viewParent, padding, hItem, lbPriceLine;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float sizeIcon = 60.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
        sizeIcon = 40.0;
    }
    
    self.backgroundColor = UIColor.clearColor;
    viewParent.layer.cornerRadius = 5.0;
    
    [viewParent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(7.5);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(self).offset(-7.5);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewParent).offset(5.0);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgType.mas_right).offset(5.0);
        make.top.equalTo(self.viewParent).offset(5.0);
        make.bottom.equalTo(self.viewParent).offset(-5.0);
        make.width.mas_equalTo(1.0);
    }];
    
    lbPrice.textColor = [UIColor colorWithRed:(213/255.0) green:(52/255.0) blue:(93/255.0) alpha:1.0];
    lbPrice.font = [AppDelegate sharedInstance].fontRegular;
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewParent.mas_centerY);
        make.left.equalTo(self.lbSepa.mas_right).offset(5.0);
        make.right.equalTo(self.viewParent).offset(-5.0);
        make.height.mas_equalTo(25.0);
    }];
    
    lbDomain.textColor = [UIColor colorWithRed:(84/255.0) green:(99/255.0) blue:(128/255.0) alpha:1.0];
    lbDomain.font = [AppDelegate sharedInstance].fontMedium;
    
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbPrice);
        make.bottom.equalTo(self.lbPrice.mas_top);
    }];
    
    lbOldPrice.font = [UIFont fontWithName:RobotoRegular size:15.0];
    lbOldPrice.textColor = [UIColor colorWithRed:(177/255.0) green:(189/255.0) blue:(205/255.0) alpha:1.0];
    [lbOldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbPrice);
        make.top.equalTo(self.lbPrice.mas_bottom);
    }];
    
    lbPriceLine.text = @"";
    lbPriceLine.backgroundColor = lbOldPrice.textColor;
    [lbPriceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbOldPrice.mas_centerY);
        make.left.right.equalTo(self.lbOldPrice);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)showOldPriceForCell: (BOOL)show {
    if (show) {
        [lbPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.viewParent.mas_centerY);
            make.left.equalTo(self.lbSepa.mas_right).offset(10.0);
            make.right.equalTo(self.viewParent).offset(-5.0);
            make.height.mas_equalTo(25.0);
        }];
        
        [lbDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.lbPrice);
            make.bottom.equalTo(self.lbPrice.mas_top);
        }];
        
        lbOldPrice.hidden = FALSE;
        [lbOldPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbPrice);
            make.top.equalTo(self.lbPrice.mas_bottom);
        }];
        
        lbPriceLine.hidden = FALSE;
        [lbPriceLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lbOldPrice.mas_centerY);
            make.left.right.equalTo(self.lbOldPrice);
            make.height.mas_equalTo(1.0);
        }];
    }else{
        lbOldPrice.hidden = lbPriceLine.hidden = TRUE;
        [lbDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.viewParent.mas_centerY).offset(-2.0);
            make.left.equalTo(self.lbSepa.mas_right).offset(10.0);
            make.right.equalTo(self.viewParent).offset(-5.0);
        }];
        
        [lbPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.lbDomain);
            make.top.equalTo(self.viewParent.mas_centerY).offset(2.0);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addBoxShadowForView: (UIView *)view withColor: (UIColor *)color
{
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = 0.4;
}

@end
