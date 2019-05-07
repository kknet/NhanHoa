//
//  SearchDomainViewController.h
//  NhanHoa
//
//  Created by admin on 4/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchDomainViewController : UIViewController<WebServicesDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTop;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *icSearch;
@property (weak, nonatomic) IBOutlet UILabel *lbWWW;

@property (weak, nonatomic) IBOutlet UIView *viewResult;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmoji;
@property (weak, nonatomic) IBOutlet UILabel *lbSearchContent;
@property (weak, nonatomic) IBOutlet UIView *viewDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainName;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbOldPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UIButton *btnChoose;

@property (weak, nonatomic) IBOutlet UILabel *lbSepaView;
@property (weak, nonatomic) IBOutlet UILabel *lbRelationDomain;
@property (weak, nonatomic) IBOutlet UITableView *tbDomains;

@property (nonatomic, assign) float padding;
@property (nonatomic, strong) NSString *strSearch;

@property (nonatomic, strong) WebServices *webService;
@property (nonatomic, strong) NSMutableDictionary *resultDict;
@property (nonatomic, assign) float hTableView;

- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icSearchClick:(UIButton *)sender;
- (IBAction)btnChoosePress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
