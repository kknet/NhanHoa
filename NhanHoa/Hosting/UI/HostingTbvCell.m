//
//  HostingTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HostingTbvCell.h"

@implementation HostingTbvCell
@synthesize viewWrap, lbTitle, lbPrice, tbInfo, lbSepa, tfPackage, imgPackage, btnChoosePackage, btnBuy;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float hTitle = 40.0;
    float hBTN = 45.0;
    self.backgroundColor = UIColor.clearColor;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:26.0];
    UIFont *btnFont = [UIFont fontWithName:RobotoBold size:20.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        btnFont = [UIFont fontWithName:RobotoBold size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:24.0];
        btnFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:26.0];
        btnFont = [UIFont fontWithName:RobotoBold size:20.0];
    }
    
    viewWrap.backgroundColor = UIColor.whiteColor;
    viewWrap.layer.cornerRadius = 10.0;
    viewWrap.clipsToBounds = TRUE;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-15.0);
    }];
    
    lbTitle.font = textFont;
    lbTitle.textColor = GRAY_50;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWrap).offset(padding);
        make.left.equalTo(viewWrap).offset(padding);
        make.right.equalTo(viewWrap).offset(-padding);
        make.height.mas_equalTo(hTitle);
    }];
    
    lbPrice.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-4];
    lbPrice.textColor = ORANGE_COLOR;
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.right.equalTo(lbTitle);
        make.right.equalTo(viewWrap).offset(-padding);
        make.height.mas_equalTo(hTitle);
    }];
    
    btnBuy.backgroundColor = BLUE_COLOR;
    btnBuy.titleLabel.font = btnFont;
    [btnBuy setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnBuy.layer.cornerRadius = 8.0;
    btnBuy.clipsToBounds = TRUE;
    [btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewWrap).offset(-padding);
        make.bottom.equalTo(viewWrap).offset(-padding);
        make.width.mas_equalTo(100.0);
        make.height.mas_equalTo(hBTN);
    }];
    
    [tfPackage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnBuy);
        make.left.equalTo(viewWrap).offset(padding);
        make.right.equalTo(btnBuy.mas_left).offset(-padding);
    }];
    
    [btnChoosePackage setTitle:@"" forState:UIControlStateNormal];
    [btnChoosePackage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(btnBuy);
    }];
    
    [imgPackage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfPackage).offset(-10.0);
        make.centerY.equalTo(tfPackage.mas_centerY);
        make.width.height.mas_equalTo(18.0);
    }];
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btnBuy.mas_top).offset(-padding);
        make.left.equalTo(viewWrap).offset(padding);
        make.right.equalTo(viewWrap).offset(-padding);
        make.height.mas_equalTo(1.0);
    }];
    
    tbInfo.separatorStyle = UITableViewCellSelectionStyleNone;
    tbInfo.backgroundColor = ORANGE_COLOR;
    [tbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPrice.mas_bottom).offset(padding);
        make.left.right.equalTo(lbPrice);
        make.bottom.equalTo(lbSepa.mas_top).offset(-padding);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
