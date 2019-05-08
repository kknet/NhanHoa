//
//  RegisterDomainViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterDomainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIView *viewBanner;
@property (weak, nonatomic) IBOutlet UIScrollView *scvBanner;

@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UILabel *lbWWW;
@property (weak, nonatomic) IBOutlet UIButton *icSearch;

@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UIImageView *imgSearch;
@property (weak, nonatomic) IBOutlet UILabel *lbSearch;

@property (weak, nonatomic) IBOutlet UIView *viewRenew;
@property (weak, nonatomic) IBOutlet UIImageView *imgRenew;
@property (weak, nonatomic) IBOutlet UILabel *lbRenew;

@property (weak, nonatomic) IBOutlet UIView *viewTransferDomain;
@property (weak, nonatomic) IBOutlet UIImageView *imgTransferDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbTransferDomain;

@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

@property (weak, nonatomic) IBOutlet UILabel *lbManyOptions;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;

@property (nonatomic, assign) float hCell;
@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float hBanner;

- (IBAction)icSearchClick:(UIButton *)sender;

@end
