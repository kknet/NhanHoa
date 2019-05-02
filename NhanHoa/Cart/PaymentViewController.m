//
//  PaymentViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentViewController.h"
#import "DomainProfileCell.h"

@interface PaymentViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listData;
    float hCell;
}

@end

@implementation PaymentViewController
@synthesize viewMenu, scvContent, tbContent, btnPayment;
@synthesize hMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUIForView {
    hMenu = 60.0;
    hCell = 138.0;  //  10 + 38 + 80 + 10
    
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self addStepMenuForView];
    
    float hTableView = listData.count * hCell;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.viewMenu.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
}

- (void)addStepMenuForView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"PaymentStepView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[PaymentStepView class]]) {
            viewMenu = (PaymentStepView *) currentObject;
            break;
        }
    }
    [self.scvContent addSubview: viewMenu];
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hMenu);
    }];
    [viewMenu setupUIForView];
}


@end
