//
//  SelectProfileView.m
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SelectProfileView.h"
#import "ProfileDetailCell.h"

@implementation SelectProfileView
@synthesize viewHeader, icAdd, lbTitle, tbProfile, icClose, icBack;
@synthesize hHeader, delegate, selectedRow;

//  Add profile
@synthesize scvAddProfile, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbName, tfName, lbSex, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, lbPassport, tfPassport, lbPhone, tfPhone, lbEmail, tfEmail, lbAddress, tfAddress, lbCountry, tfCountry, imgArrCountry, btnCountry, lbCity, tfCity, imgArrCity, btnCity, imgPassport, lbTitlePassport, imgPassportFront, imgPassportBehind, lbPassportFront, lbPassportBehind, btnSave, btnCancel;

- (void)setupUIForView {
    selectedRow = 0;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(self.hHeader);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([AppDelegate sharedInstance].hStatusBar);
        make.left.equalTo(self);
        make.width.height.mas_equalTo(self.hHeader - [AppDelegate sharedInstance].hStatusBar);
    }];
    
    icBack.hidden = TRUE;
    icBack.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.icClose);
    }];
    
    icAdd.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    [icAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icClose);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.icClose.mas_width);
    }];
    
    lbTitle.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icClose);
        make.left.equalTo(self.icClose.mas_right).offset(5.0);
        make.right.equalTo(self.icAdd.mas_left).offset(-5.0);
    }];
    
    tbProfile.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbProfile registerNib:[UINib nibWithNibName:@"ProfileDetailCell" bundle:nil] forCellReuseIdentifier:@"ProfileDetailCell"];
    tbProfile.delegate = self;
    tbProfile.dataSource = self;
    [tbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    //  setup for add profile
    float padding = 15.0;
    float mTop = 10.0;
    float hLabel = 30.0;
    float hTextfield = 38.0;
    
    [scvAddProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.equalTo(self).offset(SCREEN_WIDTH);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self);
    }];
    
    lbVision.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbVision.textColor = TITLE_COLOR;
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvAddProfile);
        make.left.equalTo(self).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(40.0);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVision.mas_bottom).offset(mTop);
        make.left.equalTo(self.lbVision).offset(-4.0);
        make.width.height.mas_equalTo(hLabel);
    }];
    
    lbPersonal.textColor = lbVision.textColor;
    lbPersonal.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icPersonal);
        make.left.equalTo(self.icPersonal.mas_right).offset(3.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    icBusiness.imageEdgeInsets = icPersonal.imageEdgeInsets;
    [icBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icPersonal);
        make.left.equalTo(self.mas_centerX);
        make.width.equalTo(self.icPersonal.mas_width);
    }];
    
    lbBusiness.textColor = lbVision.textColor;
    lbBusiness.font = lbPersonal.font;
    [lbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPersonal);
        make.left.equalTo(self.icBusiness.mas_right).offset(3.0);
        make.right.equalTo(self).offset(-padding);
    }];
    
    //  Name
    lbName.textColor = lbVision.textColor;
    lbName.font = lbPersonal.font;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusiness.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfName.layer.borderWidth = 1.0;
    tfName.layer.borderColor = BORDER_COLOR.CGColor;
    tfName.layer.cornerRadius = 3.0;
    tfName.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbName.mas_bottom);
        make.left.right.equalTo(self.lbName);
        make.height.mas_equalTo(hTextfield);
    }];
    tfName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfName.leftViewMode = UITextFieldViewModeAlways;
    
    //  sexial and birth of day
    lbBOD.font = lbName.font;
    lbBOD.textColor = lbName.textColor;
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfName.mas_bottom).offset(mTop);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBOD.layer.borderWidth = tfName.layer.borderWidth;
    tfBOD.layer.borderColor =  tfName.layer.borderColor;
    tfBOD.layer.cornerRadius = tfName.layer.cornerRadius;
    tfBOD.font = tfName.font;
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.mas_equalTo(hTextfield);
    }];
    tfBOD.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfBOD.leftViewMode = UITextFieldViewModeAlways;
    
    lbSex.font = lbName.font;
    lbSex.textColor = lbName.textColor;
    [lbSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfName.mas_bottom).offset(5.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(hLabel);
    }];
    
    icMale.imageEdgeInsets = self.icPersonal.imageEdgeInsets;
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icPersonal.mas_left);
        make.centerY.equalTo(self.tfBOD.mas_centerY);
        make.width.equalTo(self.icPersonal.mas_width);
        make.height.equalTo(self.icPersonal.mas_height);
    }];
    
    icFemale.imageEdgeInsets = self.icPersonal.imageEdgeInsets;
    [icFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SCREEN_WIDTH/4);
        make.top.bottom.equalTo(self.icMale);
        make.width.equalTo(self.icMale.mas_width);
    }];
    
    //  add action when tap on male label
    UITapGestureRecognizer *tapOnMale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMale)];
    lbMale.userInteractionEnabled = TRUE;
    [lbMale addGestureRecognizer: tapOnMale];
    
    lbMale.font = lbPersonal.font;
    lbMale.textColor = lbPersonal.textColor;
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icMale);
        make.left.equalTo(self.icMale.mas_right).offset(5.0);
        make.right.equalTo(self.icFemale.mas_left).offset(-5.0);
    }];
    
    //  add action when tap on female label
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemale)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    lbFemale.font = lbMale.font;
    lbFemale.textColor = lbMale.textColor;
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icFemale);
        make.left.equalTo(self.icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  CMND
    lbPassport.textColor = lbVision.textColor;
    lbPassport.font = lbPersonal.font;
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBOD.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbName);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPassport.layer.borderWidth = tfName.layer.borderWidth;
    tfPassport.layer.borderColor =  tfName.layer.borderColor;
    tfPassport.layer.cornerRadius = tfName.layer.cornerRadius;
    tfPassport.font = tfName.font;
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.mas_equalTo(hTextfield);
    }];
    tfPassport.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPassport.leftViewMode = UITextFieldViewModeAlways;
    
    //  Phone
    lbPhone.textColor = lbVision.textColor;
    lbPhone.font = lbPersonal.font;
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassport.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPassport);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPhone.layer.borderWidth = tfName.layer.borderWidth;
    tfPhone.layer.borderColor =  tfName.layer.borderColor;
    tfPhone.layer.cornerRadius = tfName.layer.cornerRadius;
    tfPhone.font = tfName.font;
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.mas_equalTo(hTextfield);
    }];
    tfPhone.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPhone.leftViewMode = UITextFieldViewModeAlways;
    
    //  Email
    lbEmail.textColor = lbVision.textColor;
    lbEmail.font = lbPersonal.font;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfEmail.layer.borderWidth = tfName.layer.borderWidth;
    tfEmail.layer.borderColor =  tfName.layer.borderColor;
    tfEmail.layer.cornerRadius = tfName.layer.cornerRadius;
    tfEmail.font = tfName.font;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom);
        make.left.right.equalTo(self.lbEmail);
        make.height.mas_equalTo(hTextfield);
    }];
    tfEmail.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfEmail.leftViewMode = UITextFieldViewModeAlways;
    
    //  address
    lbAddress.textColor = lbVision.textColor;
    lbAddress.font = lbPersonal.font;
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfEmail.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfEmail);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfAddress.layer.borderWidth = tfName.layer.borderWidth;
    tfAddress.layer.borderColor =  tfName.layer.borderColor;
    tfAddress.layer.cornerRadius = tfName.layer.cornerRadius;
    tfAddress.font = tfName.font;
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress.mas_bottom);
        make.left.right.equalTo(self.lbAddress);
        make.height.mas_equalTo(hTextfield);
    }];
    tfAddress.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfAddress.leftViewMode = UITextFieldViewModeAlways;
    
    //  country, district
    lbCountry.font = lbVision.font;
    lbCountry.textColor = lbVision.textColor;
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfAddress.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfCountry.layer.borderWidth = tfName.layer.borderWidth;
    tfCountry.layer.borderColor =  tfName.layer.borderColor;
    tfCountry.layer.cornerRadius = tfName.layer.cornerRadius;
    tfCountry.font = tfName.font;
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCountry.mas_bottom);
        make.left.right.equalTo(self.lbCountry);
        make.height.mas_equalTo(hTextfield);
    }];
    tfCountry.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfCountry.leftViewMode = UITextFieldViewModeAlways;
    
    [imgArrCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCountry.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCountry.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    tfCountry.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30.0, hTextfield)];
    tfCountry.rightViewMode = UITextFieldViewModeAlways;
    
    [btnCountry setTitle:@"" forState:UIControlStateNormal];
    [btnCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCountry);
    }];
    
    
    lbCity.font = lbVision.font;
    lbCity.textColor = lbVision.textColor;
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    tfCity.layer.borderWidth = tfName.layer.borderWidth;
    tfCity.layer.borderColor =  tfName.layer.borderColor;
    tfCity.layer.cornerRadius = tfName.layer.cornerRadius;
    tfCity.font = tfName.font;
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.tfCountry);
        make.left.right.equalTo(self.lbCity);
    }];
    
    
    
    [imgArrCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCity.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    tfCity.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfCity.leftViewMode = UITextFieldViewModeAlways;
    
    tfCity.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30.0, hTextfield)];
    tfCity.rightViewMode = UITextFieldViewModeAlways;
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCity);
    }];
    
    //  image passport
    [imgPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvAddProfile).offset(padding);
        make.top.equalTo(self.tfCountry.mas_bottom).offset(mTop+(hTextfield-20.0)/2);
        make.width.height.mas_equalTo(20.0);
    }];
    
    lbTitlePassport.font = lbVision.font;
    lbTitlePassport.textColor = lbVision.textColor;
    [lbTitlePassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgPassport.mas_right).offset(10.0);
        make.centerY.equalTo(self.imgPassport.mas_centerY);
        make.right.equalTo(self.lbAddress.mas_right);
        make.height.mas_equalTo(hTextfield);
    }];
    
    float wItem = (SCREEN_WIDTH-3*padding)/2;
    float hItem = wItem * 2/3;
    imgPassportFront.clipsToBounds = TRUE;
    [imgPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitlePassport.mas_bottom);
        make.left.equalTo(self.scvAddProfile).offset(padding);
        make.width.mas_equalTo(wItem);
        make.height.mas_equalTo(hItem);
    }];
    
    lbPassportFront.font = lbName.font;
    lbPassportFront.textColor = lbName.textColor;
    [lbPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportFront);
        make.top.equalTo(self.imgPassportFront.mas_bottom);
        make.height.equalTo(self.lbName.mas_height);
    }];
    
    imgPassportBehind.clipsToBounds = TRUE;
    [imgPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.imgPassportFront);
        make.left.equalTo(self.imgPassportFront.mas_right).offset(padding);
        make.width.equalTo(self.imgPassportFront.mas_width);
    }];
    
    lbPassportBehind.font = lbName.font;
    lbPassportBehind.textColor = lbName.textColor;
    [lbPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportBehind);
        make.top.equalTo(self.imgPassportBehind.mas_bottom);
        make.height.equalTo(self.lbName.mas_height);
    }];
    
    btnCancel.layer.cornerRadius = 40.0/2;
    btnCancel.backgroundColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
    btnCancel.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportFront);
        make.top.equalTo(self.lbPassportFront.mas_bottom).offset(2*padding);
        make.height.mas_equalTo(40.0);
    }];
    
    btnSave.layer.cornerRadius = btnCancel.layer.cornerRadius;
    btnSave.backgroundColor = BLUE_COLOR;
    btnSave.titleLabel.font = btnCancel.titleLabel.font;
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportBehind);
        make.top.bottom.equalTo(self.btnCancel);
    }];
}

- (void)selectMale {
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (void)selectFemale {
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (IBAction)icAddClick:(UIButton *)sender {
    lbTitle.text = @"Thêm mới hồ sơ";
    icBack.hidden = FALSE;
    icClose.hidden = icAdd.hidden = TRUE;
    
    [scvAddProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [delegate onIconCloseClicked];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [scvAddProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.equalTo(self).offset(SCREEN_WIDTH);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        lbTitle.text = @"Danh sách hồ sơ";
        icBack.hidden = TRUE;
        icClose.hidden = icAdd.hidden = FALSE;
    }];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileDetailCell *cell = (ProfileDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        [cell updateUIForBusinessProfile: FALSE];
    }else{
        [cell updateUIForBusinessProfile: TRUE];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != selectedRow) {
        selectedRow = (int)indexPath.row;
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == selectedRow) {
        if (selectedRow == 0) {
            return [self getHeightProfileForBusiness: FALSE];
        }else{
            return [self getHeightProfileForBusiness: TRUE];
        }
    }else{
        if (indexPath.row == 0) {
            return 61.0;
        }else{
            return 81.0;
        }
    }
}

- (float)getHeightProfileForBusiness: (BOOL)isBusiness {
    float hItem = 30.0;
    
    float wPassport = (SCREEN_WIDTH - 3*15.0)/2;
    float hPassport = wPassport * 2/3;
    float hDetailView = 15 + 9 * hItem + hPassport + hItem + 15;
    
    if (isBusiness) {
        return 80 + hDetailView + 1;
    }else{
        return 60 + hDetailView + 1;
    }
}


- (IBAction)icPersonalClick:(UIButton *)sender {
}

- (IBAction)icBusinessClick:(UIButton *)sender {
}

- (IBAction)icMaleClick:(UIButton *)sender {
}

- (IBAction)icFemaleClick:(UIButton *)sender {
}

- (IBAction)btnCountryPress:(UIButton *)sender {
}

- (IBAction)btnCancelPress:(UIButton *)sender {
}

- (IBAction)btnSavePress:(UIButton *)sender {
}
@end
