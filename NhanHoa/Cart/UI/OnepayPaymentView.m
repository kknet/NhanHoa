//
//  OnepayPaymentView.m
//  NhanHoa
//
//  Created by admin on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OnepayPaymentView.h"
#import "PaymentMethodCell.h"

@implementation OnepayPaymentView
@synthesize tbMethod, wvPayment, typePaymentMethod;

- (void)setupUIForViewWithMenuHeight: (float)hMenu heightNav:(float)hNav padding: (float)padding
{
    self.clipsToBounds = TRUE;
    typePaymentMethod = 0;
    
    [tbMethod registerNib:[UINib nibWithNibName:@"PaymentMethodCell" bundle:nil] forCellReuseIdentifier:@"PaymentMethodCell"];
    tbMethod.delegate = self;
    tbMethod.dataSource = self;
    tbMethod.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    float hFooter = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + hNav + hMenu + 2*60.0);
    
    UIView *footerView;
    if (hFooter < 75) {
        hFooter = 75.0;
    }
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hFooter)];
    footerView.backgroundColor = UIColor.whiteColor;
    
    UIButton *btnConfirmPayment = [[UIButton alloc] initWithFrame:CGRectMake(padding, footerView.frame.size.height-padding-45.0, footerView.frame.size.width-2*padding, 45.0)];
    [btnConfirmPayment setTitle:@"Tiến hành thang toán" forState:UIControlStateNormal];
    btnConfirmPayment.backgroundColor = BLUE_COLOR;
    [btnConfirmPayment setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnConfirmPayment.layer.cornerRadius = 45.0/2;
    btnConfirmPayment.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [footerView addSubview: btnConfirmPayment];
    [btnConfirmPayment addTarget:self
                          action:@selector(btnConfirmPaymentPress)
                forControlEvents:UIControlEventTouchUpInside];
    tbMethod.tableFooterView = footerView;
    ssss
    wvPayment.hidden = TRUE;
    wvPayment.opaque = NO;
    wvPayment.scalesPageToFit = YES;
    //wvPayment.delegate = self;
    wvPayment.backgroundColor = UIColor.greenColor;
    [wvPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentMethodCell *cell = (PaymentMethodCell *)[tableView dequeueReusableCellWithIdentifier:@"PaymentMethodCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.imgType.image = [UIImage imageNamed:@"atm.png"];
        cell.lbTitle.text = @"Cổng thanh toán nội địa";
        cell.lbSepa.hidden = FALSE;
        
    }else{
        cell.imgType.image = [UIImage imageNamed:@"visa.png"];
        cell.lbTitle.text = @"Cổng thanh toán quốc tế";
        cell.lbSepa.hidden = TRUE;
    }
    
    if (typePaymentMethod == (PaymentMethod)indexPath.row) {
        cell.imgChoose.hidden = FALSE;
    }else{
        cell.imgChoose.hidden = TRUE;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    typePaymentMethod = (PaymentMethod)indexPath.row;
    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

@end
