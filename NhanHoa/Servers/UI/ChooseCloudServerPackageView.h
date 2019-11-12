//
//  ChooseCloudServerPackageView.h
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseCloudServerPackageView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lbBackground;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UIButton *icClose;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

@property (nonatomic, assign) float hContentView;
@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float hCell;
@property (nonatomic, strong) NSArray *listData;

- (void)setupUIForViewWithInfo: (NSArray *)infos;
- (void)showContentInfoView;

- (IBAction)btnConfirmPress:(UIButton *)sender;
- (IBAction)icCloseClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
