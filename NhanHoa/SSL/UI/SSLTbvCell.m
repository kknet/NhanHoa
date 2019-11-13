//
//  SSLTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SSLTbvCell.h"
#import "SSLDetailsTbvCell.h"

@implementation SSLTbvCell
@synthesize viewWrap, lbTitle, lbPrice, tbInfo, lbSepa, btnBuy;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float hTitle = 40.0;
    float hBTN = 45.0;
    self.backgroundColor = UIColor.clearColor;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:24.0];
    UIFont *btnFont = [UIFont fontWithName:RobotoBold size:20.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        btnFont = [UIFont fontWithName:RobotoBold size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        btnFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:24.0];
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
    lbTitle.textColor = GRAY_80;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWrap).offset(padding);
        make.left.equalTo(viewWrap).offset(padding);
        make.right.equalTo(viewWrap).offset(-padding);
        make.height.mas_equalTo(hTitle);
    }];
    
    btnBuy.backgroundColor = [UIColor colorWithRed:(36/255.0) green:(111/255.0) blue:(213/255.0) alpha:1.0];
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
    
    lbPrice.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-2];
    lbPrice.textColor = [UIColor colorWithRed:(240/255.0) green:(127/255.0) blue:(5/255.0) alpha:1.0];
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWrap).offset(padding);
        make.centerY.equalTo(btnBuy.mas_centerY);
        make.right.equalTo(btnBuy.mas_left).offset(-padding);
    }];
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btnBuy.mas_top).offset(-padding);
        make.left.equalTo(viewWrap).offset(padding);
        make.right.equalTo(viewWrap).offset(-padding);
        make.height.mas_equalTo(1.0);
    }];
    
    [tbInfo registerNib:[UINib nibWithNibName:@"SSLDetailsTbvCell" bundle:nil] forCellReuseIdentifier:@"SSLDetailsTbvCell"];
    tbInfo.separatorStyle = UITableViewCellSelectionStyleNone;
    tbInfo.backgroundColor = UIColor.whiteColor;
    tbInfo.scrollEnabled = FALSE;
    tbInfo.delegate = self;
    tbInfo.dataSource = self;
    tbInfo.showsVerticalScrollIndicator = FALSE;
    [tbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(padding);
        make.left.right.equalTo(lbTitle);
        make.bottom.equalTo(lbSepa.mas_top).offset(-padding);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSLDetailsTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SSLDetailsTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.lbTitle.text = @"Phí cài đặt:";
        cell.lbValue.text = @"Miễn phí";
        
    }else if (indexPath.row == 1){
        cell.lbTitle.text = @"Chứng thực:";
        cell.lbValue.text = @"Tên miền (DV)";
        
    }else if (indexPath.row == 2){
        cell.lbTitle.text = @"Số domain được bảo mật:";
        cell.lbValue.text = @"1";
        
    }else if (indexPath.row == 3){
        cell.lbTitle.text = @"Hỗ trợ SAN:";
        cell.lbValue.text = @"-";
        
    }else if (indexPath.row == 4){
        cell.lbTitle.text = @"Thanh địa chỉ màu xanh:";
        cell.lbValue.text = @"-";
        
    }else if (indexPath.row == 5){
        cell.lbTitle.text = @"Chỉnh sách bảo hiểm:";
        cell.lbValue.text = @"$10.000";
        
    }else if (indexPath.row == 6){
        cell.lbTitle.text = @"Trust level:";
        cell.lbValue.text = @"Standard";
        
    }else if (indexPath.row == 7){
        cell.lbTitle.text = @"Thời hạn đăng ký:";
        cell.lbValue.text = @"1-2 năm";
        
    }else{
        cell.lbTitle.text = @"Hỗ trợ khách hàng:";
        cell.lbValue.text = @"24/7";
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35.0;
}

@end
