//
//  CartViewController.m
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CartViewController.h"
#import "CartDomainItemCell.h"
#import "PaymentViewController.h"

@interface CartViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listData;
    float hCell;
}

@end

@implementation CartViewController

@synthesize scvContent, viewInfo, lbInfo, lbCount, tbDomains, promoView, viewFooter, lbPrice, lbPriceValue, lbVAT, lbVATValue, lbPromo, lbPromoValue, lbTotal, lbTotalValue, btnContinue, btnGoShop;
@synthesize hInfo, hPromoView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createDemoData];
    [self setupUIForView];
    self.title = @"Giỏ hàng";
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    PaymentViewController *paymentVC = [[PaymentViewController alloc] initWithNibName:@"PaymentViewController" bundle:nil];
    [self.navigationController pushViewController:paymentVC animated:TRUE];
}

- (IBAction)btnGoShopPress:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)createDemoData {
    listData = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *domain1 = [[NSMutableDictionary alloc] init];
    [domain1 setObject:@"lanhquadi.com" forKey:@"name"];
    [domain1 setObject:@".com" forKey:@"type"];
    [domain1 setObject:@"280.000" forKey:@"first_price"];
    [domain1 setObject:@"1.480.000" forKey:@"total_price"];
    [domain1 setObject:@"2" forKey:@"years"];
    [listData addObject: domain1];
    
    NSMutableDictionary *domain2 = [[NSMutableDictionary alloc] init];
    [domain2 setObject:@"lanhquadi.com.vn" forKey:@"name"];
    [domain2 setObject:@".com" forKey:@"type"];
    [domain2 setObject:@"180.000" forKey:@"first_price"];
    [domain2 setObject:@"630.000" forKey:@"total_price"];
    [domain2 setObject:@"1" forKey:@"years"];
    [listData addObject: domain2];
    
    NSMutableDictionary *domain3 = [[NSMutableDictionary alloc] init];
    [domain3 setObject:@"lequangkhai.com" forKey:@"name"];
    [domain3 setObject:@".com" forKey:@"type"];
    [domain3 setObject:@"80.000" forKey:@"first_price"];
    [domain3 setObject:@"780.000" forKey:@"total_price"];
    [domain3 setObject:@"3" forKey:@"years"];
    [listData addObject: domain3];
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    float padding = 15.0;
    hInfo = 40.0;
    hCell = 106.0;
    
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    //  view top
    viewInfo.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hInfo);
    }];
    
    lbInfo.font = [UIFont fontWithName:RobotoRegular size:17.0];
    [lbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewInfo).offset(padding);
        make.top.bottom.equalTo(self.viewInfo);
        make.right.equalTo(self.viewInfo.mas_centerX);
    }];
    
    lbCount.font = lbInfo.font;
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewInfo).offset(-padding);
        make.top.bottom.equalTo(self.viewInfo);
        make.left.equalTo(self.viewInfo.mas_centerX);
    }];
    
    float hTableView = listData.count * hCell;
    tbDomains.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbDomains registerNib:[UINib nibWithNibName:@"CartDomainItemCell" bundle:nil] forCellReuseIdentifier:@"CartDomainItemCell"];
    tbDomains.delegate = self;
    tbDomains.dataSource = self;
    [tbDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.viewInfo.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
    
    [self addPromotionView];
    
    //  footer view
    float hFooter = padding + 4*30 + 2*padding + 50 + padding + 50.0 + padding;
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.promoView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hFooter);
    }];
    
    //  price
    lbPrice.textColor = TITLE_COLOR;
    lbPrice.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.viewFooter).offset(padding);
        make.right.equalTo(self.viewFooter.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(30.0);
    }];
    
    lbPriceValue.textColor = lbPrice.textColor;
    lbPriceValue.font = lbPrice.font;
    [lbPriceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewFooter.mas_centerX).offset(padding/2);
        make.top.bottom.equalTo(self.lbPrice);
        make.right.equalTo(self.viewFooter).offset(-padding);
    }];
    
    //  VAT
    lbVAT.textColor = TITLE_COLOR;
    lbVAT.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbVAT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPrice.mas_bottom);
        make.left.right.equalTo(self.lbPrice);
        make.height.equalTo(self.lbPrice.mas_height);
    }];
    
    lbVATValue.textColor = lbPrice.textColor;
    lbVATValue.font = lbPrice.font;
    [lbVATValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbPriceValue);
        make.top.bottom.equalTo(self.lbVAT);
    }];
    
    //  Promotions
    lbPromo.textColor = TITLE_COLOR;
    lbPromo.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbPromo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVAT.mas_bottom);
        make.left.right.equalTo(self.lbVAT);
        make.height.equalTo(self.lbVAT.mas_height);
    }];
    
    lbPromoValue.textColor = lbPrice.textColor;
    lbPromoValue.font = lbPrice.font;
    [lbPromoValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbVATValue);
        make.top.bottom.equalTo(self.lbPromo);
    }];
    
    //  Total price
    lbTotal.textColor = TITLE_COLOR;
    lbTotal.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPromo.mas_bottom);
        make.left.right.equalTo(self.lbPromo);
        make.height.equalTo(self.lbPromo.mas_height);
    }];
    
    lbTotalValue.textColor = NEW_PRICE_COLOR;
    lbTotalValue.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotalValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbPromoValue);
        make.top.bottom.equalTo(self.lbTotal);
    }];
    
    btnContinue.layer.cornerRadius = 50.0/2;
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTotalValue.mas_bottom).offset(2*padding);
        make.left.equalTo(self.viewFooter).offset(padding);
        make.right.equalTo(self.viewFooter).offset(-padding);
        make.height.mas_equalTo(50.0);
    }];
    
    btnGoShop.backgroundColor = [UIColor colorWithRed:(84/255.0) green:(99/255.0) blue:(128/255.0) alpha:1.0];
    btnGoShop.layer.cornerRadius = btnContinue.layer.cornerRadius;
    btnGoShop.titleLabel.font = btnContinue.titleLabel.font;
    [btnGoShop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnContinue.mas_bottom).offset(padding);
        make.left.right.equalTo(self.btnContinue);
        make.height.equalTo(self.btnContinue.mas_height);
    }];
    
    self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hInfo+hTableView+hPromoView+hFooter);
}

- (void)addPromotionView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"PromotionCodeView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[PromotionCodeView class]]) {
            promoView = (PromotionCodeView *) currentObject;
            break;
        }
    }
    [self.scvContent addSubview: promoView];
    
    hPromoView = 108.0;
    [promoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.tbDomains.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hPromoView);
    }];
    [promoView setupUIForView];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartDomainItemCell *cell = (CartDomainItemCell *)[tableView dequeueReusableCellWithIdentifier:@"CartDomainItemCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *domain = [listData objectAtIndex: indexPath.row];
    NSString *domainName = [domain objectForKey:@"name"];
    NSString *type = [domain objectForKey:@"type"];
    NSString *firstPrice = [domain objectForKey:@"first_price"];
    NSString *totalPrice = [domain objectForKey:@"total_price"];
    NSString *years = [domain objectForKey:@"years"];
    
    cell.lbNum.text = [NSString stringWithFormat:@"%d.", (int)indexPath.row + 1];
    cell.lbName.text = domainName;
    cell.lbPrice.text = [NSString stringWithFormat:@"%@đ", firstPrice];
    cell.lbDescription.text = [NSString stringWithFormat:@"Tên miền quốc tế .%@", type];
    cell.tfYears.text = [NSString stringWithFormat:@"%@ năm", years];
    cell.lbTotalPrice.text = [NSString stringWithFormat:@"%@đ", totalPrice];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}
@end
