//
//  PriceListView.m
//  NhanHoa
//
//  Created by admin on 5/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PriceListView.h"
#import "PriceDomainInfoCell.h"

@implementation PriceListView
@synthesize viewHeader, icClose, lbTitle, viewMenu, btnDomainsVN, btnDomainsQT, tbDomains, delegate, icWaiting;
@synthesize listQT, listVN, eTypePrice;

- (void)setupUIForView {
    float hHeader = [AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav;
    float padding = 15.0;
    
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(hHeader);
    }];
    
    lbTitle.font = [AppDelegate sharedInstance].fontBTN;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader).offset([AppDelegate sharedInstance].hStatusBar);
        make.centerX.equalTo(self.viewHeader.mas_centerX);
        make.bottom.equalTo(self.viewHeader);
        make.width.mas_equalTo(250);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbTitle.mas_centerY);
        make.left.equalTo(self.viewHeader).offset(padding - 8);
        make.width.height.mas_equalTo(40);
    }];
    
    //  view menu
    float hMenu = 40.0;
    viewMenu.layer.cornerRadius = hMenu/2;
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hMenu);
    }];
    
    eTypePrice = ePriceVN;
    [btnDomainsVN setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnDomainsVN.titleLabel.font = btnDomainsQT.titleLabel.font = [AppDelegate sharedInstance].fontDesc;
    btnDomainsVN.backgroundColor = BLUE_COLOR;
    btnDomainsVN.layer.cornerRadius = hMenu/2;
    [btnDomainsVN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.viewMenu);
        make.right.equalTo(self.viewMenu.mas_centerX);
    }];
    
    [btnDomainsQT setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnDomainsQT.backgroundColor = UIColor.clearColor;
    btnDomainsQT.layer.cornerRadius = btnDomainsVN.layer.cornerRadius;
    [btnDomainsQT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewMenu.mas_centerX);
        make.right.top.bottom.equalTo(self.viewMenu);
    }];
    
    //  table content
    tbDomains.delegate = self;
    tbDomains.dataSource = self;
    [tbDomains registerNib:[UINib nibWithNibName:@"PriceDomainInfoCell" bundle:nil] forCellReuseIdentifier:@"PriceDomainInfoCell"];
    tbDomains.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom).offset(padding);
        make.left.bottom.right.equalTo(self);
    }];
    [self createHeaderViewForTableView];
    
    icWaiting.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    icWaiting.backgroundColor = UIColor.whiteColor;
    icWaiting.alpha = 0.5;
    icWaiting.hidden = TRUE;
    [icWaiting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

- (void)showWaitingView:(BOOL)show
{
    icWaiting.hidden = !show;
    (show) ? [icWaiting startAnimating] : [icWaiting stopAnimating];
}

- (void)prepareToDisplayData {
    if (listQT == nil) {
        listQT = [[NSMutableArray alloc] init];
        if ([AppDelegate sharedInstance].domainsPrice != nil) {
            if ([[[AppDelegate sharedInstance].domainsPrice allKeys] containsObject:@"qt"]) {
                NSArray *qt = [[AppDelegate sharedInstance].domainsPrice objectForKey:@"qt"];
                if (qt != nil && [qt isKindOfClass:[NSArray class]]) {
                    [listQT addObjectsFromArray: qt];
                }
            }
        }
    }
    
    if (listVN == nil) {
        listVN = [[NSMutableArray alloc] init];
        if ([AppDelegate sharedInstance].domainsPrice != nil) {
            if ([[[AppDelegate sharedInstance].domainsPrice allKeys] containsObject:@"vn"]) {
                NSArray *vn = [[AppDelegate sharedInstance].domainsPrice objectForKey:@"vn"];
                if (vn != nil && [vn isKindOfClass:[NSArray class]]) {
                    [listVN addObjectsFromArray: vn];
                }
            }
        }
    }
    [tbDomains reloadData];
}

- (void)createHeaderViewForTableView {
    float padding = 15.0;
    float sizeItem = (SCREEN_WIDTH - 5*padding)/4;
    
    UIView *tbHeader = [[UIView alloc] init];
    tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40.0);
    
    UILabel *lbName = [[UILabel alloc] init];
    lbName.text = @"Tên miền";
    lbName.textAlignment = NSTextAlignmentLeft;
    [tbHeader addSubview: lbName];
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tbHeader).offset(padding);
        make.top.bottom.equalTo(tbHeader);
        make.width.mas_equalTo(sizeItem);
    }];
    
    UILabel *lbRenew = [[UILabel alloc] init];
    lbRenew.text = @"Phí khởi tạo";
    lbRenew.textAlignment = NSTextAlignmentRight;
    [tbHeader addSubview: lbRenew];
    [lbRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbName.mas_right).offset(padding);
        make.top.bottom.equalTo(tbHeader);
        make.right.equalTo(tbHeader.mas_centerX).offset(-padding/2);
    }];
    
    UILabel *lbSetup = [[UILabel alloc] init];
    lbSetup.text = @"Phí duy trì";
    lbSetup.textAlignment = NSTextAlignmentRight;
    [tbHeader addSubview: lbSetup];
    [lbSetup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tbHeader.mas_centerX).offset(padding/2);
        make.top.bottom.equalTo(tbHeader);
        make.width.mas_equalTo(sizeItem);
    }];
    
    UILabel *lbTransfer = [[UILabel alloc] init];
    lbTransfer.text = @"Chuyển về";
    lbTransfer.textAlignment = NSTextAlignmentRight;
    [tbHeader addSubview: lbTransfer];
    [lbTransfer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSetup.mas_right).offset(padding);
        make.top.bottom.equalTo(tbHeader);
        make.right.equalTo(tbHeader).offset(-padding);
    }];
    
    float fontSize = [AppDelegate sharedInstance].fontMedium.pointSize;
    
    lbName.font = lbRenew.font = lbSetup.font = lbTransfer.font = [UIFont fontWithName:RobotoMedium size:fontSize-2];
    lbName.textColor = lbRenew.textColor = lbSetup.textColor = lbTransfer.textColor = TITLE_COLOR;
    
    tbDomains.tableHeaderView = tbHeader;
}

- (IBAction)icCloseClicked:(UIButton *)sender {
    [delegate onCloseViewDomainPrice];
}

- (IBAction)btnAllDomainsPress:(UIButton *)sender {
    
}

- (IBAction)btnExpireDomainsPress:(UIButton *)sender {
}

- (IBAction)btnDomainsVNPress:(UIButton *)sender {
    if (eTypePrice == ePriceVN) {
        return;
    }
    
    eTypePrice = ePriceVN;
    [btnDomainsVN setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnDomainsVN.backgroundColor = BLUE_COLOR;
    
    [btnDomainsQT setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnDomainsQT.backgroundColor = UIColor.clearColor;
    
    [tbDomains reloadData];
}

- (IBAction)btnDomainsQTPress:(UIButton *)sender {
    if (eTypePrice == ePriceQT) {
        return;
    }
    
    eTypePrice = ePriceQT;
    [btnDomainsQT setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnDomainsQT.backgroundColor = BLUE_COLOR;
    
    [btnDomainsVN setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnDomainsVN.backgroundColor = UIColor.clearColor;
    
    [tbDomains reloadData];
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (eTypePrice == ePriceVN) {
        return listVN.count;
    }else{
        return listQT.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PriceDomainInfoCell *cell = (PriceDomainInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"PriceDomainInfoCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info;
    if (eTypePrice == ePriceVN) {
        info = [listVN objectAtIndex: indexPath.row];
    }else{
        info = [listQT objectAtIndex: indexPath.row];
    }
    [cell showContentWithInfo: info];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

@end
