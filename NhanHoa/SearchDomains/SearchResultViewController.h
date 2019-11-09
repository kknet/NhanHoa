//
//  SearchResultViewController.h
//  NhanHoa
//
//  Created by OS on 11/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIView *viewFooter;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;

@property (weak, nonatomic) IBOutlet UITableView *tbResult;

@property (nonatomic, strong) NSString *strSearch;
@property (nonatomic, strong) NSMutableArray *listSearch;

- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)btnContinuePress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
