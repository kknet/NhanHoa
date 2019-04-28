//
//  RegisterDomainViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterDomainViewController.h"

@interface RegisterDomainViewController ()

@end

@implementation RegisterDomainViewController
@synthesize viewBanner, tfSearch, lbWWW, icSearch, viewInfo, lbTitle, viewSearch, imgSearch, lbSearch, viewRenew, imgRenew, lbRenew, viewTransferDomain, imgTransferDomain, lbTransferDomain, lbSepa, lbManyOptions, tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.title = @"Đăng ký tên miền";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUIForView {
    self.view.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    float padding = 10.0;
    float hBanner = 150.0;
    viewBanner.clipsToBounds = YES;
    [viewBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hBanner);
    }];
    
    //  search UI
    float hSearch = 40.0;
    tfSearch.backgroundColor = UIColor.whiteColor;
    tfSearch.layer.cornerRadius = hSearch/2;
    tfSearch.layer.borderColor = [UIColor colorWithRed:(86/255.0) green:(149/255.0) blue:(228/255.0) alpha:1.0].CGColor;
    tfSearch.layer.borderWidth = 1.5;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.centerY.equalTo(self.viewBanner.mas_bottom);
        make.height.mas_equalTo(hSearch);
    }];
    
    icSearch.layer.cornerRadius = hSearch/2;
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(hSearch);
    }];
    
    icSearch.layer.cornerRadius = hSearch/2;
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(hSearch);
    }];
    
    lbWWW.backgroundColor = UIColor.clearColor;
    lbWWW.text = @"WWW.";
    lbWWW.textColor = [UIColor colorWithRed:(41/255.0) green:(121/255.0) blue:(216/255.0) alpha:1.0];
    lbWWW.font = [UIFont fontWithName:RobotoBold size:15.0];
    [lbWWW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(60);
    }];
    
    //  info view
    float hItemView = 80.0;
    float hInfo = hSearch/2 + 40.0 + hItemView + 20.0;
    viewInfo.backgroundColor = UIColor.clearColor;
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.viewBanner.mas_bottom);
        make.height.mas_equalTo(hInfo);
    }];
    
    NSAttributedString *contentStr = [AppUtils generateTextWithContent:@"Nên đặt tên miền như thế nào?" font:[UIFont fontWithName:RobotoRegular size:15.0] color:[UIColor colorWithRed:(212/255.0) green:(53/255.0) blue:(91/255.0) alpha:1.0] image:[UIImage imageNamed:@"info_red"] size:16.0 imageFirst:YES];
    lbTitle.attributedText = contentStr;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo).offset(hSearch/2);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40.0);
    }];
    
    float sizeItem = (SCREEN_WIDTH - 4*padding)/3;
    
    //  view re-order domain
    UIImage *itemImg = [UIImage imageNamed:@"search_multi_domain"];
    float wItemImg = 50.0;
    float hItemImg = wItemImg * itemImg.size.height / itemImg.size.width;
    float smallPadding = 4.0;
    viewRenew.layer.cornerRadius = 5.0;
    [viewRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom);
        make.centerX.equalTo(self.viewInfo.mas_centerX);
        make.width.mas_equalTo(sizeItem);
        make.height.mas_equalTo(hItemView);
    }];
    
    lbRenew.textColor = UIColor.whiteColor;
    lbRenew.font = [UIFont fontWithName:RobotoRegular size:13.5];
    lbRenew.text = @"Kiểm tra nhiều tên miền";
    lbRenew.numberOfLines = 5.0;
    [lbRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewRenew.mas_centerY);
        make.left.equalTo(self.viewRenew).offset(3.0);
        make.right.equalTo(self.viewRenew).offset(-3.0);
    }];
    
    imgRenew.image = itemImg;
    [imgRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lbRenew.mas_top).offset(-smallPadding);
        make.centerX.equalTo(self.viewRenew.mas_centerX);
        make.width.mas_equalTo(wItemImg);
        make.height.mas_equalTo(hItemImg);
    }];
    
    //  view check multi domain
    viewSearch.layer.cornerRadius = 5.0;
    [viewSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewRenew);
        make.right.equalTo(self.viewRenew.mas_left).offset(-padding);
        make.width.mas_equalTo(sizeItem);
    }];
    
    lbSearch.textColor = lbRenew.textColor;
    lbSearch.font = lbRenew.font;
    lbSearch.text = @"Gia hạn tên miền";
    lbSearch.numberOfLines = 5.0;
    [lbSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewSearch.mas_centerY);
        make.left.equalTo(self.viewSearch).offset(3.0);
        make.right.equalTo(self.viewSearch).offset(-3.0);
    }];
    
    imgSearch.image = itemImg;
    [imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lbSearch.mas_top).offset(-smallPadding);
        make.centerX.equalTo(self.viewSearch.mas_centerX);
        make.width.mas_equalTo(wItemImg);
        make.height.mas_equalTo(hItemImg);
    }];
    
    //  view transfer domain
    viewTransferDomain.layer.cornerRadius = 5.0;
    [viewTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewRenew);
        make.left.equalTo(self.viewRenew.mas_right).offset(padding);
        make.width.mas_equalTo(sizeItem);
    }];
    
    lbTransferDomain.textColor = lbRenew.textColor;
    lbTransferDomain.font = lbRenew.font;
    lbTransferDomain.text = @"Chuyển tên miền về Nhân Hoà";
    lbTransferDomain.numberOfLines = 5.0;
    [lbTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewTransferDomain.mas_centerY);
        make.left.equalTo(self.viewTransferDomain).offset(3.0);
        make.right.equalTo(self.viewTransferDomain).offset(-3.0);
    }];
    
    imgTransferDomain.image = itemImg;
    [imgTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lbTransferDomain.mas_top).offset(-smallPadding);
        make.centerX.equalTo(self.viewTransferDomain.mas_centerX);
        make.width.mas_equalTo(wItemImg);
        make.height.mas_equalTo(hItemImg);
    }];
    
    //  sepa
    lbSepa.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0];
    lbSepa.adjustsFontSizeToFitWidth = NO;
    lbSepa.lineBreakMode = NSLineBreakByTruncatingTail;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo.mas_bottom);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(1.0);
    }];
    
    //  many options
    lbManyOptions.text = @"Nhiều lựa chọn với ưu đãi hấp dẫn";
    lbManyOptions.font = [UIFont fontWithName:RobotoBold size:16.0];
    lbManyOptions.textColor = [UIColor colorWithRed:(57/255.0) green:(65/255.0) blue:(86/255.0) alpha:1.0];
    [lbManyOptions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSepa.mas_bottom).offset(20.0);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.width.mas_equalTo(1.0);
    }];
    
    tbContent.backgroundColor = UIColor.lightGrayColor;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbManyOptions.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-5.0);
    }];
}

- (IBAction)icSearchClick:(UIButton *)sender {
}

@end
