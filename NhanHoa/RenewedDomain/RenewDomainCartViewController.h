//
//  RenewDomainCartViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RenewDomainCartViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UIView *viewFooter;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainPriceValue;
@property (weak, nonatomic) IBOutlet UILabel *lbVAT;
@property (weak, nonatomic) IBOutlet UILabel *lbVATValue;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPriceValue;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;

@property (nonatomic, strong) NSString *domain;

@property (nonatomic, assign) float hCell;

- (IBAction)btnContinuePress:(UIButton *)sender;

@property (nonatomic, strong) UITableView *tbSelectYear;

@end
