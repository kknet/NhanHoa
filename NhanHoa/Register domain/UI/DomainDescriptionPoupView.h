//
//  DomainDescriptionPoupView.h
//  NhanHoa
//
//  Created by lam quang quan on 5/7/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DomainDescriptionPoupView : UIView

@property (nonatomic, strong) UILabel *lbContent;
@property (nonatomic, strong) UIButton *icClose;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (void)fadeOut;

@end
