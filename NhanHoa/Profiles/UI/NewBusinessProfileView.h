//
//  NewBusinessProfileView.h
//  NhanHoa
//
//  Created by lam quang quan on 5/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewBusinessProfileView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbVision;
@property (weak, nonatomic) IBOutlet UIButton *icPersonal;
@property (weak, nonatomic) IBOutlet UILabel *lbPersonal;
@property (weak, nonatomic) IBOutlet UIButton *icBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbBusiness;

@property (weak, nonatomic) IBOutlet UILabel *lbInfoBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbBusinessName;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessName;
@property (weak, nonatomic) IBOutlet UILabel *lbBusinessAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbBusinessPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry;
@property (weak, nonatomic) IBOutlet UIImageView *imgCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgCity;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;

@property (weak, nonatomic) IBOutlet UILabel *lbInfoRegister;
@property (weak, nonatomic) IBOutlet UILabel *lbRegisterName;
@property (weak, nonatomic) IBOutlet UITextField *tfRegisterName;
@property (weak, nonatomic) IBOutlet UILabel *lbGender;
@property (weak, nonatomic) IBOutlet UIButton *icMale;
@property (weak, nonatomic) IBOutlet UILabel *lbMale;
@property (weak, nonatomic) IBOutlet UIButton *icFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbBOD;
@property (weak, nonatomic) IBOutlet UITextField *tfBOD;
@property (weak, nonatomic) IBOutlet UILabel *lbPosition;
@property (weak, nonatomic) IBOutlet UITextField *tfPosition;
@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UITextField *tfPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UIView *viewSecure;

@property (weak, nonatomic) IBOutlet UILabel *lbCode;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UIImageView *imgCode;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;


@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float hTextfield;
@property (nonatomic, assign) float hLabel;
@property (nonatomic, assign) float mTop;

@end
