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
    typePaymentMethod = ePaymentWithATM;
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
        cell.imgType.image = [UIImage imageNamed:@"visa.png"];
        cell.lbTitle.text = @"Thẻ ghi nợ";
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
    [self addOnepayPaymentViewIfNeed];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.paymentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
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
        [[AppDelegate sharedInstance].window addSubview: paymentView];
    }
    paymentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    [paymentView setupUIForView];
    paymentView.delegate = self;
}


#pragma mark - PaymentView Delegate
-(void)userClickCancelPayment {
    [self.view makeToast:@"Bạn đã hủy giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.paymentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    }completion:^(BOOL finished) {
        [self.paymentView removeFromSuperview];
        self.paymentView = nil;
    }];
}

@end
