//
//  ChooseCityPopupView.h
//  NhanHoa
//
//  Created by lam quang quan on 5/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityObject.h"

@protocol ChooseCityPopupViewDelegate
- (void)choosedCity: (CityObject *)city;
@end

@interface ChooseCityPopupView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) <NSObject, ChooseCityPopupViewDelegate> delegate;
@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) UIButton *icClose;
@property (nonatomic, strong) UILabel *lbTitle;

@property (nonatomic, strong) UITableView *tbCity;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (void)fadeOut;

@end
