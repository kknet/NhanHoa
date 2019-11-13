//
//  ChooseCloudServerPackageView.m
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChooseCloudServerPackageView.h"
#import "CloudServerTemplateTbvCell.h"
#import "HostingPackageTbvCell.h"

@implementation ChooseCloudServerPackageView
@synthesize lbBackground, viewContent, icClose, lbDesc, lbTitle, tbContent, btnConfirm;
@synthesize hContentView, padding, listTemplates, selectedTemplate, hCell, hTimeCell, curType, listPackageTimes;
@synthesize delegate;

- (void)setupUIForViewWithInfo: (NSArray *)infos
{
    listTemplates = infos;
    selectedTemplate = @"";
    curType = 1;
    
    padding = 15.0;
    float hBTN = 50.0;
    hCell = 60.0;
    hTimeCell = 75.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        hBTN = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        hBTN = 48.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        hBTN = 50.0;
    }
    
    hContentView = padding + 30.0 + 30.0 + padding + infos.count * hCell + padding + hBTN + 2*padding;
    if (hContentView >= (SCREEN_HEIGHT - 100.0)) {
        hContentView = SCREEN_HEIGHT - 100.0;
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
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewContent);
        make.left.equalTo(viewContent).offset(40.0);
        make.right.equalTo(viewContent).offset(-40.0);
        make.height.mas_equalTo(padding + 30.0);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewContent);
        make.centerY.equalTo(lbTitle.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbDesc.textColor = GRAY_100;
    lbDesc.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.equalTo(viewContent).offset(5.0);
        make.right.equalTo(viewContent).offset(-5.0);
        make.height.mas_equalTo(30.0);
    }];
    
    [btnConfirm setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Confirm"] forState:UIControlStateNormal];
    btnConfirm.backgroundColor = BLUE_COLOR;
    [btnConfirm setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnConfirm.layer.cornerRadius = 8.0;
    btnConfirm.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-2];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewContent).offset(-2*padding);
        make.left.equalTo(viewContent).offset(padding);
        make.right.equalTo(viewContent).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    tbContent.backgroundColor = UIColor.clearColor;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbContent registerNib:[UINib nibWithNibName:@"CloudServerTemplateTbvCell" bundle:nil] forCellReuseIdentifier:@"CloudServerTemplateTbvCell"];
    [tbContent registerNib:[UINib nibWithNibName:@"HostingPackageTbvCell" bundle:nil] forCellReuseIdentifier:@"HostingPackageTbvCell"];
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDesc.mas_bottom).offset(padding);
        make.left.right.equalTo(btnConfirm);
        make.bottom.equalTo(btnConfirm.mas_top).offset(-padding);
    }];
}

- (void)showContentInfoView {
    float originY = SCREEN_HEIGHT - hContentView + padding;
    [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(originY);
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
    }];
}

- (IBAction)btnConfirmPress:(UIButton *)sender {
    if (curType == 1)
    {
        curType = 2;
        
        lbTitle.text = @"Chọn thời gian";
        lbDesc.text = SFM(@"%@ - %@", @"SSD Cloud Server A", selectedTemplate);
        [btnConfirm setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Buy"] forState:UIControlStateNormal];
        [icClose setImage:[UIImage imageNamed:@"back_gray"] forState:UIControlStateNormal];
        
        [self createListTimeInfoForCurrentPackage];
        [tbContent reloadData];
    }else{
        if ([delegate respondsToSelector:@selector(confirmAfterChooseSSDCloudServerPackageView)]) {
            [delegate confirmAfterChooseSSDCloudServerPackageView];
        }
    }
}

- (IBAction)icCloseClick:(UIButton *)sender {
    if (curType == 2) {
        curType = 1;
        lbTitle.text = @"Chọn template";
        lbDesc.text = @"SSD Cloud Server A";
        [btnConfirm setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Continue"] forState:UIControlStateNormal];
        [icClose setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
        
        [tbContent reloadData];
    }else{
        [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(SCREEN_HEIGHT);
        }];
        
        [UIView animateWithDuration:0.1 animations:^{
            [self layoutIfNeeded];
        }completion:^(BOOL finished) {
            lbBackground.hidden = TRUE;
            if ([delegate respondsToSelector:@selector(closeChooseSSDCloudServerPackageView)]) {
                [delegate closeChooseSSDCloudServerPackageView];
            }
        }];
    }
}

- (void)createListTimeInfoForCurrentPackage {
    if (listPackageTimes == nil) {
        listPackageTimes = [[NSMutableArray alloc] init];
        
        NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:@"6", @"month", @"36000", @"price", @"432000", @"total", nil];
        [listPackageTimes addObject: info];
        
        NSDictionary *info1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"12", @"month", @"32400", @"price", @"777000", @"total", nil];
        [listPackageTimes addObject: info1];
        
        NSDictionary *info2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"36", @"month", @"30600", @"price", @"1101600", @"total", nil];
        [listPackageTimes addObject: info2];
        
        NSDictionary *info3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"48", @"month", @"28800", @"price", @"1382400", @"total", nil];
        [listPackageTimes addObject: info3];
        
        NSDictionary *info4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"60", @"month", @"27000", @"price", @"1620000", @"total", nil];
        [listPackageTimes addObject: info4];
    }
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (curType == 1) {
        return (int)listTemplates.count;
    }else{
        return (int)listPackageTimes.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (curType == 1) {
        CloudServerTemplateTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CloudServerTemplateTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *template = [listTemplates objectAtIndex: indexPath.row];
        cell.lbContent.text = template;
        cell.imgChecked.hidden = ([template isEqualToString: selectedTemplate]) ? FALSE : TRUE;
        
        if ([template isEqualToString: selectedTemplate]) {
            [cell setCellIsSelected: TRUE];
        }else{
            [cell setCellIsSelected: FALSE];
        }
        
        return cell;
    }else{
        HostingPackageTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingPackageTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary *info = [listPackageTimes objectAtIndex: indexPath.row];
        
        cell.lbMonths.text = SFM(@"%@ Tháng", [info objectForKey:@"month"]);
        
        NSString *price = [info objectForKey:@"price"];
        price = [AppUtils convertStringToCurrencyFormat:price];
        cell.lbPrice.text = SFM(@"%@đ/Tháng", price);
        
        NSString *total = [info objectForKey:@"total"];
        total = [AppUtils convertStringToCurrencyFormat:total];
        cell.lbTotal.text = SFM(@"Tổng %@đ", total);
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (curType == 1) {
        NSString *template = [listTemplates objectAtIndex: indexPath.row];
        if (![template isEqualToString: selectedTemplate]) {
            selectedTemplate = template;
        }
    }
    //  [tbContent reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (curType == 1) {
        return hCell;
    }else{
        return hTimeCell;
    }
}

@end
