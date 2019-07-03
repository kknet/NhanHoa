//
//  PaymentViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentMethodCell.h"

@interface PaymentViewController ()<UITableViewDelegate, UITableViewDataSource, OnepayPaymentViewDelegate> {
    
}
@end

@implementation PaymentViewController
@synthesize tbContent, btnContinue, money, typePaymentMethod, paymentView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Nạp tiền vào ví";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"PaymentViewController"];
    
    typePaymentMethod = ePaymentWithATM;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [self.paymentView removeFromSuperview];
}

- (void)setupUIForView {
    float padding = 15.0;
    
    btnContinue.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnContinue.layer.cornerRadius = 45.0/2;
    btnContinue.backgroundColor = BLUE_COLOR;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.btnContinue.mas_top).offset(-padding);
    }];
    [tbContent registerNib:[UINib nibWithNibName:@"PaymentMethodCell" bundle:nil] forCellReuseIdentifier:@"PaymentMethodCell"];
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
        cell.lbTitle.text = @"Thẻ ATM nội địa và Internet Banking";
        cell.lbSepa.hidden = FALSE;
        
    }else{
        cell.imgType.image = [UIImage imageNamed:@"master-card.png"];
        cell.lbTitle.text = @"Thẻ Visa / Master";
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

- (IBAction)btnContinuePress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startContinuePayment) withObject:nil afterDelay:0.05];
}

- (void)startContinuePayment {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    btnContinue.backgroundColor = BLUE_COLOR;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    [self addOnepayPaymentViewIfNeed];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.paymentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
        self.paymentView.typePaymentMethod = self.typePaymentMethod;
        [self.paymentView showPaymentContentViewWithMoney: self.money];
    }];
}

- (void)addOnepayPaymentViewIfNeed {
    if (paymentView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OnepayPaymentView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[OnepayPaymentView class]]) {
                paymentView = (OnepayPaymentView *) currentObject;
                break;
            }
        }
        UIWindow *curWindow = [[UIApplication sharedApplication] keyWindow];
        [curWindow addSubview: paymentView];
    }
    paymentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [paymentView setupUIForView];
    paymentView.delegate = self;
    paymentView.backgroundColor = UIColor.whiteColor;
}


#pragma mark - PaymentView Delegate
-(void)onBackIconClick {
    [self.navigationController popViewControllerAnimated: TRUE];
}

-(void)onBackIconResultViewClick {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)userClickCancelPayment {
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

- (void)paymentResultWithInfo:(NSDictionary *)info {
    //  reset hashkey
    [AppDelegate sharedInstance].hashKey = @"";
    
    NSString *vpc_TxnResponseCode = [info objectForKey:@"vpc_TxnResponseCode"];
    if (![AppUtils isNullOrEmpty: vpc_TxnResponseCode]) {
        if ([vpc_TxnResponseCode isEqualToString: User_cancel_Code]) {
            [self.view makeToast:@"Bạn đã hủy bỏ giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            //  [self performSelector:@selector(backToPreviousView) withObject:nil afterDelay:2.0];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_card_number_Code]) {
            [self.view makeToast:@"Số thẻ không chính xác. Vui lòng kiểm tra lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
    }
}

- (void)dismissView {
    [self.navigationController popViewControllerAnimated: TRUE];
}

@end
