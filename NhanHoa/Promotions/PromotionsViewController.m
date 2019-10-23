//
//  PromotionsViewController.m
//  NhanHoa
//
//  Created by OS on 10/17/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PromotionsViewController.h"

@interface PromotionsViewController (){
    AppDelegate *appDelegate;
}
@end

@implementation PromotionsViewController
@synthesize viewHeader, icBack, lbHeader, tbPromotions;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = FALSE;
    
    [self showContentWithCurrentLanguage];
}

- (IBAction)icBackClick:(UIButton *)sender {
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Promotions"];
}

- (void)setupUIForView {
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

@end
