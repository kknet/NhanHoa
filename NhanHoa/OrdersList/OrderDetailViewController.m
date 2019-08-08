//
//  OrderDetailViewController.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailView.h"
#import "OrderDetailDescriptionView.h"
#import "OrderProcessInfoView.h"

@interface OrderDetailViewController () {
    OrderDetailView *viewOrderDetail;
    float hDetailView;
    
    OrderDetailDescriptionView *viewDetailDescView;
    float hDetailDescView;
    
    OrderProcessInfoView *orderInfoView;
    float hInfoView;
}

@end

@implementation OrderDetailViewController
@synthesize scvContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"ORD881170";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self displayOrderDetailView];
    [self displayOrderDetailDescriptionView];
    [self displayOrderProcessInfoView];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hDetailView + hDetailDescView + hInfoView);
}

- (void)setupUIForView {
    scvContent.showsVerticalScrollIndicator = FALSE;
    scvContent.showsHorizontalScrollIndicator = FALSE;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

- (void)displayOrderDetailView {
    if (viewOrderDetail == nil) {
        [self addOrderDetailViewForMainView];
    }
    
    hDetailView = 50.0 + 14*45.0;
    [viewOrderDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hDetailView);
    }];
    [viewOrderDetail setupUIForView];
}

- (void)addOrderDetailViewForMainView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OrderDetailView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[OrderDetailView class]]) {
            viewOrderDetail = (OrderDetailView *) currentObject;
            break;
        }
    }
    [scvContent addSubview: viewOrderDetail];
}

- (void)displayOrderDetailDescriptionView {
    if (viewDetailDescView == nil) {
        [self addOrderDetailDescriptionViewForMainView];
    }
    
    hDetailDescView = 50.0 + 5*45.0;
    [viewDetailDescView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(hDetailView);
        make.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hDetailDescView);
    }];
    [viewDetailDescView setupUIForView];
}

- (void)addOrderDetailDescriptionViewForMainView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OrderDetailDescriptionView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[OrderDetailDescriptionView class]]) {
            viewDetailDescView = (OrderDetailDescriptionView *) currentObject;
            break;
        }
    }
    [scvContent addSubview: viewDetailDescView];
}

- (void)displayOrderProcessInfoView {
    if (orderInfoView == nil) {
        [self addOrderProcessInfoViewForMainView];
    }
    
    hInfoView = 50.0 + 4*45.0;
    [orderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(hDetailView + hDetailDescView);
        make.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hInfoView);
    }];
    [orderInfoView setupUIForView];
}

- (void)addOrderProcessInfoViewForMainView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OrderProcessInfoView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[OrderProcessInfoView class]]) {
            orderInfoView = (OrderProcessInfoView *) currentObject;
            break;
        }
    }
    [scvContent addSubview: orderInfoView];
}




@end
