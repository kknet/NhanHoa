//
//  CartMoreInfoView.h
//  NhanHoa
//
//  Created by OS on 10/21/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartMoreInfoView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *clvInfo;

@property (nonatomic, assign) float hContentView;
@property (nonatomic, assign) float hCollectionView;
@property (nonatomic, assign) float padding;

- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
