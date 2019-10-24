//
//  PromotionTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/24/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PromotionTbvCell.h"

@implementation PromotionTbvCell
@synthesize viewWrap, lbTitle, lbContent, lbDateTime, imgPromos;
@synthesize padding;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    padding = 15.0;
    self.backgroundColor = UIColor.clearColor;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
    }
    
    viewWrap.clipsToBounds = TRUE;
    viewWrap.layer.cornerRadius = 10.0;
    viewWrap.backgroundColor = UIColor.whiteColor;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.right.equalTo(self).offset(-3.0);
        make.bottom.equalTo(self).offset(-padding);
    }];
    
    [imgPromos mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(viewWrap);
        make.height.mas_equalTo(0);
    }];
    
    lbTitle.textColor = GRAY_50;
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgPromos.mas_bottom).offset(5.0);
        make.left.equalTo(viewWrap).offset(padding);
        make.right.equalTo(viewWrap).offset(-padding);
        make.height.mas_equalTo(0);
    }];
    
    lbDateTime.textColor = GRAY_150;
    lbDateTime.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-4];
    [lbDateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(0);
    }];
    
    lbContent.textColor = GRAY_100;
    lbContent.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDateTime.mas_bottom).offset(5);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayContentWithInfo: (NSDictionary *)info
{
    NSString *photoName = [info objectForKey:@"photo"];
    UIImage *imgPhoto = [UIImage imageNamed: photoName];
    imgPromos.image = imgPhoto;
    
    float hImgPhoto = (SCREEN_WIDTH - 2*padding) * imgPhoto.size.height / imgPhoto.size.width;
    [imgPromos mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hImgPhoto);
    }];
    
    NSString *title = [info objectForKey:@"title"];
    lbTitle.text = title;
    
    NSString *datetime = [info objectForKey:@"datetime"];
    lbDateTime.text = SFM(@"Áp dụng trong tháng %@", datetime);
    
    NSString *content = [info objectForKey:@"content"];
    lbContent.text = content;
    
    //  height title
    [lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25.0);
    }];
    
    //  height datetime
    [lbDateTime mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20.0);
    }];
    
    //  height content
    float hContent = [AppUtils getSizeWithText:content withFont:lbContent.font andMaxWidth:(SCREEN_WIDTH - 4*padding)].height;
    
    [lbContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hContent);
    }];
}

@end
