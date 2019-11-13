//
//  CloudServerTemplateTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CloudServerTemplateTbvCell.h"

@implementation CloudServerTemplateTbvCell
@synthesize viewWrap, lbContent, imgChecked;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    
    float padding = 15.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:24.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:24.0];
    }
    
    viewWrap.layer.cornerRadius = 5.0;
    viewWrap.layer.borderColor = UIColor.clearColor.CGColor;
    viewWrap.layer.borderWidth = 2.0;
    viewWrap.clipsToBounds = TRUE;
    viewWrap.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(244/255.0) blue:(246/255.0) alpha:1.0];
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-10.0);
    }];
    
    [imgChecked mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewWrap).offset(-padding);
        make.centerY.equalTo(viewWrap.mas_centerY);
        make.width.height.mas_equalTo(24.0);
    }];
    
    lbContent.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2.0];
    lbContent.textColor = GRAY_50;
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWrap).offset(padding);
        make.top.bottom.equalTo(viewWrap);
        make.right.equalTo(imgChecked.mas_left).offset(-10.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        viewWrap.layer.borderColor = [UIColor colorWithRed:(240/255.0) green:(155/255.0) blue:(52/255.0) alpha:1.0].CGColor;
        imgChecked.hidden = FALSE;
    }else{
        viewWrap.layer.borderColor = UIColor.clearColor.CGColor;
        imgChecked.hidden = TRUE;
    }
}

- (void)setCellIsSelected: (BOOL)selected {
    if (selected) {
        viewWrap.layer.borderColor = [UIColor colorWithRed:(240/255.0) green:(155/255.0) blue:(52/255.0) alpha:1.0].CGColor;
        imgChecked.hidden = FALSE;
    }else{
        viewWrap.layer.borderColor = UIColor.clearColor.CGColor;
        imgChecked.hidden = TRUE;
    }
}

@end
