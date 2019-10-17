//
//  PromotionsViewController.m
//  NhanHoa
//
//  Created by OS on 10/17/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PromotionsViewController.h"

@interface PromotionsViewController ()

@end

@implementation PromotionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Promotions"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = FALSE;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
