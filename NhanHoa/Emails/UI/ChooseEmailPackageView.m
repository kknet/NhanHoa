//
//  ChooseEmailPackageView.m
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChooseEmailPackageView.h"
#import "EmailPackageTbvCell.h"

@implementation ChooseEmailPackageView

@synthesize lbBackground, viewContent, icClose, lbTitle, lbDesc, tbContent, btnConfirm;
@synthesize hContentView, padding, listData, hCell;
@synthesize delegate;

- (void)setupUIForViewWithInfo: (NSArray *)infos
{
    listData = infos;
    
    padding = 15.0;
    float hBTN = 50.0;
    float hTitle = 40.0;
    float hDesc = 25.0;
    hCell = 85.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        hBTN = 45.0;
        hCell = 75.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        hBTN = 48.0;
        hCell = 80.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        hBTN = 53.0;
        hCell = 85.0;
    }
    
    if ([AppDelegate sharedInstance].safeAreaBottomPadding > 0) {
        hContentView = padding + hTitle + hDesc + padding + infos.count * hCell + padding + hBTN + [AppDelegate sharedInstance].safeAreaBottomPadding;
    }else{
        hContentView = padding + hTitle + hDesc + padding + infos.count * hCell + padding + hBTN + 2*padding;
    }
    
    
    self.backgroundColor = UIColor.clearColor;
    
    lbBackground.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [lbBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    viewContent.backgroundColor = UIColor.whiteColor;
    viewContent.layer.cornerRadius = 10.0;
    viewContent.clipsToBounds = TRUE;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_HEIGHT);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(hContentView);
    }];
    
    lbTitle.textColor = GRAY_50;
    lbTitle.font = textFont;
    lbTitle.text = @"Chọn thời gian";
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewContent).offset(padding);
        make.centerX.equalTo(viewContent.mas_centerX);
        make.width.mas_equalTo(250.0);
        make.height.mas_equalTo(hTitle);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewContent).offset(5.0);
        make.centerY.equalTo(lbTitle.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbDesc.textColor = GRAY_100;
    lbDesc.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.equalTo(viewContent).offset(5.0);
        make.right.equalTo(viewContent).offset(-5.0);
        make.height.mas_equalTo(hDesc);
    }];
    
    [btnConfirm setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Confirm"] forState:UIControlStateNormal];
    btnConfirm.backgroundColor = BLUE_COLOR;
    [btnConfirm setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnConfirm.layer.cornerRadius = 8.0;
    btnConfirm.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-2];
    if ([AppDelegate sharedInstance].safeAreaBottomPadding > 0) {
        [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(viewContent).offset(-[AppDelegate sharedInstance].safeAreaBottomPadding);
            make.left.equalTo(viewContent).offset(padding);
            make.right.equalTo(viewContent).offset(-padding);
            make.height.mas_equalTo(hBTN);
        }];
    }else{
        [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(viewContent).offset(-2*padding);
            make.left.equalTo(viewContent).offset(padding);
            make.right.equalTo(viewContent).offset(-padding);
            make.height.mas_equalTo(hBTN);
        }];
    }
    
    tbContent.backgroundColor = UIColor.clearColor;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbContent registerNib:[UINib nibWithNibName:@"EmailPackageTbvCell" bundle:nil] forCellReuseIdentifier:@"EmailPackageTbvCell"];
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDesc.mas_bottom).offset(padding);
        make.left.right.equalTo(btnConfirm);
        make.bottom.equalTo(btnConfirm.mas_top).offset(-padding);
    }];
}

- (void)showContentInfoView {
    float originY;
    if ([AppDelegate sharedInstance].safeAreaBottomPadding > 0) {
        originY = SCREEN_HEIGHT - hContentView;
    }else{
        originY = SCREEN_HEIGHT - hContentView + padding;
    }
    
    [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(originY);
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
    }];
}

- (IBAction)btnConfirmPress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(confirmAfterChooseEmailPackageView)]) {
        [delegate confirmAfterChooseEmailPackageView];
    }
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_HEIGHT);
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        lbBackground.hidden = TRUE;
        if ([delegate respondsToSelector:@selector(closeChooseEmailPackageView)]) {
            [delegate closeChooseEmailPackageView];
        }
    }];
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (int)listData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EmailPackageTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmailPackageTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [listData objectAtIndex: indexPath.row];
    
    cell.lbMonths.text = SFM(@"%@ Tháng", [info objectForKey:@"month"]);
    
    NSString *price = [info objectForKey:@"price"];
    price = [AppUtils convertStringToCurrencyFormat:price];
    cell.lbPrice.text = SFM(@"%@đ/Tháng", price);
    
    NSString *total = [info objectForKey:@"total"];
    total = [AppUtils convertStringToCurrencyFormat:total];
    cell.lbTotal.text = SFM(@"Tổng %@đ", total);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

@end
