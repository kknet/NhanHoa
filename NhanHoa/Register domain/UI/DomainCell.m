//
//  DomainCell.m
//  NhanHoa
//
//  Created by admin on 4/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainCell.h"

@implementation DomainCell
@synthesize lbDomain, lbPrice, btnChoose, btnWarning, parentView, padding;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    parentView.layer.cornerRadius = 5.0;
    
    padding = 15.0;
    
    [parentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self).offset(-self.padding);
        make.top.equalTo(self).offset(7.5);
        make.bottom.equalTo(self).offset(-7.5);
    }];
    
    btnChoose.backgroundColor = BLUE_COLOR;
    btnChoose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:16.0];
    btnChoose.layer.cornerRadius = 36.0/2;
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.parentView.mas_centerY);
        make.right.equalTo(self.parentView).offset(-self.padding);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(36.0);
    }];
    
    lbDomain.textColor = TITLE_COLOR;
    lbDomain.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.parentView).offset(self.padding);
        make.bottom.equalTo(self.parentView.mas_centerY).offset(-2.0);
    }];
    
    btnWarning.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [btnWarning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbDomain.mas_right);
        make.centerY.equalTo(self.lbDomain.mas_centerY);
        make.width.height.mas_equalTo(35.0);
    }];
    
    lbPrice.textColor = NEW_PRICE_COLOR;
    lbPrice.font = [UIFont fontWithName:RobotoMedium size:15.0];
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.parentView).offset(self.padding);
        make.top.equalTo(self.parentView.mas_centerY).offset(2.0);
    }];
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

- (void)updateSizeButtonWithContent: (NSString *)content {
    float size = [AppUtils getSizeWithText:content withFont:btnChoose.titleLabel.font].width + 10;
    if (size < 60.0) {
        size = 60.0;
    }
    
    [btnChoose mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.parentView.mas_centerY);
        make.right.equalTo(self.parentView).offset(-self.padding);
        make.width.mas_equalTo(size);
        make.height.mas_equalTo(36.0);
    }];
}

- (void)showPriceForDomainCell: (BOOL)show {
    float size = [AppUtils getSizeWithText:btnChoose.currentTitle withFont:btnChoose.titleLabel.font].width + 10;
    if (size < 60.0) {
        size = 60.0;
    }
    
    [btnChoose mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.parentView.mas_centerY);
        make.right.equalTo(self.parentView).offset(-self.padding);
        make.width.mas_equalTo(size);
        make.height.mas_equalTo(36.0);
    }];
    
    if (show) {
        [lbDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.parentView).offset(self.padding);
            make.bottom.equalTo(self.parentView.mas_centerY).offset(-2.0);
        }];
        
        [btnWarning mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbDomain.mas_right);
            make.centerY.equalTo(self.lbDomain.mas_centerY);
            make.width.height.mas_equalTo(35.0);
        }];
        
        lbPrice.hidden = FALSE;
        [lbPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.parentView).offset(self.padding);
            make.top.equalTo(self.parentView.mas_centerY).offset(2.0);
        }];
        
    }else{
        [lbDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.parentView).offset(self.padding);
            make.top.bottom.equalTo(self.parentView);
        }];
        
        [btnWarning mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbDomain.mas_right);
            make.centerY.equalTo(self.lbDomain.mas_centerY);
            make.width.height.mas_equalTo(35.0);
        }];
        lbPrice.hidden = TRUE;
    }
    
    
}

@end
