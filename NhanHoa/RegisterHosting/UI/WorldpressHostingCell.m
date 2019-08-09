//
//  WorldpressHostingCell.m
//  NhanHoa
//
//  Created by OS on 8/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WorldpressHostingCell.h"
#import "SelectAmountClvCell.h"

@implementation WorldpressHostingCell
@synthesize viewWrapper, viewHeader, lbName, lbPrice, lbAmount, tfAmount, btnAddCart, btnAmount, imgType, lbSepa, imgArr, clvAmount;
@synthesize paddingContent, padding;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    padding = 15.0;
    paddingContent = 7.0;
    
    float mTop = 15.0;
    
    viewWrapper.layer.borderColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0].CGColor;
    viewWrapper.layer.borderWidth = 1.0;
    [viewWrapper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(paddingContent);
        make.right.equalTo(self).offset(-paddingContent);
        make.bottom.equalTo(self).offset(-paddingContent - mTop);
    }];

    [AppUtils addBoxShadowForView:viewWrapper color:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0] opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(60.0);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(padding);
        make.top.equalTo(viewHeader).offset(5.0);
        make.width.height.mas_equalTo(30.0);
    }];
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgType.mas_right).offset(padding);
        make.top.bottom.equalTo(imgType);
        make.right.equalTo(viewHeader).offset(-padding);
    }];
    
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbName.mas_bottom);
        make.left.right.equalTo(lbName);
        make.height.mas_equalTo(20.0);
    }];
    
    //  Amount
    float hItem = 40.0;
    lbAmount.textColor = TITLE_COLOR;
    [lbAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.height.mas_equalTo(hItem);
    }];
    
    [AppUtils setBorderForTextfield:tfAmount borderColor:BORDER_COLOR];
    tfAmount.text = @"1";
    [tfAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAmount.mas_bottom);
        make.left.right.equalTo(lbAmount);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnAmount setTitle:@"" forState:UIControlStateNormal];
    [btnAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfAmount);
    }];
    
    [imgArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tfAmount.mas_centerY);
        make.right.equalTo(tfAmount).offset(-5.0);
        make.width.mas_equalTo(16.0);
        make.height.mas_equalTo(12.0);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfAmount.mas_bottom).offset(mTop);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    btnAddCart.backgroundColor = ORANGE_BUTTON;
    [btnAddCart setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAddCart.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnAddCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfAmount);
        make.height.mas_equalTo(45.0);
    }];
    
    //  collection view amount
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0;
    clvAmount.collectionViewLayout = layout;
    
    clvAmount.delegate = self;
    clvAmount.dataSource = self;
    clvAmount.backgroundColor = UIColor.whiteColor;
    [clvAmount registerNib:[UINib nibWithNibName:@"SelectAmountClvCell" bundle:nil] forCellWithReuseIdentifier:@"SelectAmountClvCell"];
    
    clvAmount.layer.borderColor = GRAY_220.CGColor;
    clvAmount.layer.borderWidth = 1.0;
    clvAmount.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    [clvAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tfAmount);
        make.bottom.equalTo(tfAmount.mas_top).offset(-2.0);
        make.height.mas_equalTo(0.0);
    }];
    
    lbName.textColor = BLUE_COLOR;
    
    if ([DeviceUtils isScreen320]) {
        lbName.font = [UIFont fontWithName:RobotoMedium size:20.0];
        lbPrice.font = [UIFont fontWithName:RobotoMedium size:16.0];
        lbAmount.font = tfAmount.font = [AppDelegate sharedInstance].fontRegular;
        
    }else{
        lbName.font = [UIFont fontWithName:RobotoMedium size:24.0];
        lbPrice.font = [UIFont fontWithName:RobotoMedium size:18.0];
        lbAmount.font = tfAmount.font = [AppDelegate sharedInstance].fontRegular;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnAmountPress:(UIButton *)sender {
    if (clvAmount.frame.size.height == 0) {
        [clvAmount mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(95.0);
        }];
    }else{
        [clvAmount mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.0);
        }];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectAmountClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectAmountClvCell" forIndexPath:indexPath];
    
    cell.lbNum.text = [NSString stringWithFormat:@"%d", (int)(indexPath.row) + 1];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [clvAmount mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.0);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
    tfAmount.text = [NSString stringWithFormat:@"%d", (int)(indexPath.row) + 1];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 2*paddingContent - 2*padding)/5, 95.0/2);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

@end
