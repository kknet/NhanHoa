//
//  ChooseHostingPackgeView.h
//  NhanHoa
//
//  Created by Khai Leo on 11/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseHostingPackgeView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lbBackground;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

@property (nonatomic, assign) float hContentView;
@property (nonatomic, assign) float padding;

- (void)setupUIForViewWithInfo: (NSArray *)infos;
- (void)showContentInfoView;

@end

NS_ASSUME_NONNULL_END
