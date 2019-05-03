//
//  SelectProfileView.h
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SelectProfileViewDelegate
- (void)onIconCloseClicked;
@end

@interface SelectProfileView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) id<NSObject, SelectProfileViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icAdd;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITableView *tbProfile;
@property (weak, nonatomic) IBOutlet UIButton *icClose;

@property (nonatomic, assign) float hHeader;
@property (nonatomic, assign) int selectedRow;

- (void)setupUIForView;
- (IBAction)icAddClick:(UIButton *)sender;
- (IBAction)icCloseClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
