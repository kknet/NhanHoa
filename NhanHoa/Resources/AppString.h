//
//  AppString.h
//  NhanHoa
//
//  Created by admin on 4/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#ifndef AppString_h
#define AppString_h

#define SFM(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define MoMo_Merchant_ID    @"MOMOIQA420180417"
#define MoMo_Partner_Code   @"MOMOIQA420180417"
#define MoMo_IOS_SCHEME_ID  @"momoiqa420180417"
#define MoMo_PublicKey      @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAkpa+qMXS6O11x7jBGo9W3yxeHEsAdyDE40UoXhoQf9K6attSIclTZMEGfq6gmJm2BogVJtPkjvri5/j9mBntA8qKMzzanSQaBEbr8FyByHnf226dsLt1RbJSMLjCd3UC1n0Yq8KKvfHhvmvVbGcWfpgfo7iQTVmL0r1eQxzgnSq31EL1yYNMuaZjpHmQuT24Hmxl9W9enRtJyVTUhwKhtjOSOsR03sMnsckpFT9pn1/V9BE2Kf3rFGqc6JukXkqK6ZW9mtmGLSq3K+JRRq2w8PVmcbcvTr/adW4EL2yc1qk9Ec4HtiDhtSYd6/ov8xLVkKAQjLVt7Ex3/agRPfPrNwIDAQAB"
#define MoMo_SecretKey      @"PPuDXq1KowPT1ftR8DvlQTHhC03aul17"
#define MoMo_AccessKey      @"TNWFx9JWayevKPiB8LyTgODiCSrjstXN"

#define MoMo_Request_Type_Confirm   @"capture"
#define MoMo_Request_Type_Cancel    @"revertAuthorize"

//  #define MoMo_AccessKey      @"SvDmj2cOTYZmQQ3H"
//Access key: SvDmj2cOTYZmQQ3H
//Secret key: PPuDXq1KowPT1ftR8DvlQTHhC03aul17

#define APP_NAME        @"Nhân Hòa"

//  define for language
#define language_key            @"language_key"
#define key_en                  @"en"
#define key_vi                  @"vi"

#define SCREEN_WIDTH_IPHONE_5       320
#define SCREEN_WIDTH_IPHONE_6       375
#define SCREEN_WIDTH_IPHONE_6PLUS   414

#define simulator       @"x86_64"
#define Iphone4s        @"iPhone4,1"
#define Iphone5_1       @"iPhone5,1"
#define Iphone5_2       @"iPhone5,2"
#define Iphone5c_1      @"iPhone5,3"
#define Iphone5c_2      @"iPhone5,4"
#define Iphone5s_1      @"iPhone6,1"
#define Iphone5s_2      @"iPhone6,2"
#define Iphone6         @"iPhone7,2"
#define Iphone6_Plus    @"iPhone7,1"
#define Iphone6s        @"iPhone8,1"
#define Iphone6s_Plus   @"iPhone8,2"
#define IphoneSE        @"iPhone8,4"
#define Iphone7_1       @"iPhone9,1"
#define Iphone7_2       @"iPhone9,3"
#define Iphone7_Plus1   @"iPhone9,2"
#define Iphone7_Plus2   @"iPhone9,4"
#define Iphone8_1       @"iPhone10,1"
#define Iphone8_2       @"iPhone10,4"
#define Iphone8_Plus1   @"iPhone10,2"
#define Iphone8_Plus2   @"iPhone10,5"
#define IphoneX_1       @"iPhone10,3"
#define IphoneX_2       @"iPhone10,6"
#define IphoneXR        @"iPhone11,8"
#define IphoneXS        @"iPhone11,2"
#define IphoneXS_Max1   @"iPhone11,6"
#define IphoneXS_Max2   @"iPhone11,4"

#define RobotoBlack         @"Roboto-Black"
#define RobotoBlackItalic   @"Roboto-BlackItalic"
#define RobotoBold          @"Roboto-Bold"
#define RobotoBoldItalic    @"Roboto-BoldItalic"
#define RobotoItalic        @"Roboto-Italic"
#define RobotoLight         @"Roboto-Light"
#define RobotoLightItalic   @"Roboto-LightItalic"
#define RobotoMedium        @"Roboto-Medium"
#define RobotoMediumItalic  @"Roboto-MediumItalic"
#define RobotoRegular       @"Roboto-Regular"
#define RobotoThin          @"Roboto-Thin"
#define RobotoThinItalic    @"Roboto-ThinItalic"

#define link_forgot_password    @"https://id.nhanhoa.com/login/forgot.html"
#define nhanhoa_website_link    @"https://nhanhoa.com/"
#define nhanhoa_link            @"nhanhoa.com/"
#define phone_support           @"19006680"
#define email_support           @"support@nhanhoa.com"
#define nhanhoa_facebook_link   @"https://www.facebook.com/nhanhoacom"




#define HEADER_ICON_WIDTH 35.0

#define PASSWORD_MIN_CHARS  6
#define MAX_YEAR_FOR_RENEW  10
#define MIN_MONEY_TOPUP     100000


#define type_na             2
#define type_men            1
#define type_women          0

#define type_personal       0
#define type_business       1

#define type_A              @"A"
#define type_AAAA           @"AAAA"
#define type_CNAME          @"CNAME"
#define type_MX             @"MX"
#define type_URL_Redirect   @"URL Redirect"
#define type_URL_Frame      @"URL Frame"
#define type_TXT            @"TXT"
#define type_SRV            @"SRV"
#define type_SPF            @"SPF"

#define TTL_MIN     300
#define TTL_MAX     86400

#define MX_MIN      1
#define MX_MAX      100

#define TAG_HUD             100
#define TIME_FOR_SLIDER     6
#define COUNTRY_CODE        @"231"

#define URL_Payment         @"https://onepay.vn/onecomm-pay/vpc.op"
#define MERCHANT_ID         @"NHANHOA"
#define ACCESSCODE          @"KCGTKP1O"
#define HASHCODE            @"CD67F28EA5A64ED380D8388F686AE727"

#define URL_Payment_VISA    @"https://onepay.vn/vpcpay/vpcpay.op"
#define MERCHANT_ID_VISA    @"NHANHOA"
#define ACCESSCODE_VISA     @"2A5A6E8D"
#define HASHCODE_VISA       @"DBDBB856693DF3086604FDB60277D4A5"

#define register_domain     @"register_domain"
#define renew_domain        @"renew_domain"
#define topup_money         @"topup_money"

#define Approved_Code               @"0"
#define Bank_Declined_Code          @"1"
#define Merchant_not_exist_Code     @"3"
#define Invalid_access_Code         @"4"
#define Invalid_amount_Code         @"5"
#define Invalid_currency_Code       @"6"
#define Unspecified_failure_Code    @"7"
#define Invalid_card_number_Code    @"8"
#define Invalid_card_name_Code      @"9"
#define Expired_card_Code           @"10"
#define Card_not_registed_Code      @"11"
#define Invalid_card_date_Code      @"12"
#define Exist_Amount_Code           @"13"
#define Insufficient_fund_Code      @"21"
#define User_cancel_Code            @"99"
#define Failured_Content            @"Giao dịch thất bại"


#define link_api_call           @"https://api.vfone.vn:51100/cskhvoip"

#define link_support            @"https://tongdai.vfone.vn/callnew.php"
#define link_upload_photo       @"https://api.websudo.xyz"
#define return_url              @"https://nhanhoa.com/app-awk/onepay.php"
#define link_api                @"https://nhanhoa.com/app-awk"
#define login_func              @"Login"
#define whois_func              @"Whois"
#define get_profile_func        @"ListContact"
#define register_account_func   @"RegisterAccount"
#define add_contact_func        @"AddContact"
#define edit_contact_func       @"EditContact"
#define change_pass_func        @"ChangePassword"
#define list_domain_func        @"ListDomain"
#define domain_pricing_func     @"DomainPricing"
#define info_domain_func        @"InfoDomain"
#define update_cmnd_func        @"UpdateCMND"
#define change_dns_func         @"ChangeDNS"
#define get_dns_func            @"GetDNS"
#define send_question_func      @"SendQuestion"
#define edit_profile_func       @"EditProfile"
#define profile_photo_func      @"ProfilePhoto"
#define update_token_func       @"UpdateToken"
#define hash_key_func           @"HashKey"
#define check_otp_func          @"CheckOTP"
#define resend_otp_func         @"ResendOTP"
#define get_history_func        @"History"
#define renew_domain_func       @"RenewDomain"
#define renew_order_func        @"RenewOrder"
#define info_bank_func          @"InfoBank"
#define withdraw_func           @"Withdraw"
#define add_order_func          @"AddOrder"
#define addfun_func             @"Addfun"
#define WhoisProtect_func       @"WhoisProtect"
#define DNSRecord_func          @"DNSRecord"


#define login_mod               @"login"
#define whois_mod               @"whois"
#define get_profile_mod         @"contact_list"
#define register_account_mod    @"register_account"
#define add_contact_mod         @"add_contact"
#define edit_contact_mod        @"edit_contact"
#define change_password_mod     @"change_password"
#define list_domain_mod         @"list_domain"
#define domain_pricing_mod      @"domain_pricing"
#define info_domain_mod         @"info_domain"
#define update_cmnd_mod         @"update_cmnd"
#define change_dns_mod          @"change_dns"
#define get_dns_mod             @"get_dns"
#define question_mod            @"question"
#define edit_profile_mod        @"edit_profile"
#define profile_photo_mod       @"profile_photo"
#define update_token_mod        @"update_token"
#define hash_key_mod            @"hash_key"
#define check_otp_mod           @"check_otp"
#define resend_otp_mod          @"resend_otp"
#define get_history_mod         @"history"
#define renew_domain_mod        @"renew_domain"
#define renew_order_mod         @"renew_order"
#define info_bank_mod           @"info_bank"
#define withdraw_mod            @"withdraw"
#define add_order_mod           @"add_order"
#define addfun_mod              @"addfun"
#define whois_protect_mod       @"whois_protect"
#define dns_record_mod          @"dns_record"

#define GetAccVoipAction        @"GetAccVoip"
#define UpdateTokenAction       @"UpdateToken"
#define GetListCSKHAction       @"GetListCSKH"

#define logsFolderName      @"LogFiles"
#define login_state         @"login_state"
#define year_for_domain     @"year_for_domain"
#define whois_protect       @"whois_protect"

#define key_login           @"key_login"
#define key_password        @"key_password"
#define pass_for_backup     @"pass_for_backup"
#define domainvn_type       @"domainvn"
#define domain_type         @"domain"
#define profile_cart        @"profile_cart"

#define USERNAME ([[NSUserDefaults standardUserDefaults] objectForKey:key_login])
#define PASSWORD ([[NSUserDefaults standardUserDefaults] objectForKey:key_password])

#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define NAV_COLOR [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0]
#define ORANGE_COLOR [UIColor colorWithRed:(255/255.0) green:(152/255.0) blue:(33/255.0) alpha:1.0]
#define YELLOW_COLOR [UIColor colorWithRed:(253/255.0) green:(169/255.0) blue:(70/255.0) alpha:1.0]
#define TITLE_COLOR [UIColor colorWithRed:(61/255.0) green:(77/255.0) blue:(103/255.0) alpha:1.0]
#define BLUE_COLOR [UIColor colorWithRed:(29/255.0) green:(104/255.0) blue:(209/255.0) alpha:1.0]
#define GREEN_COLOR [UIColor colorWithRed:(28/255.0) green:(189/255.0) blue:(92/255.0) alpha:1.0]
#define NEW_PRICE_COLOR [UIColor colorWithRed:(213/255.0) green:(53/255.0) blue:(93/255.0) alpha:1.0]
#define OLD_PRICE_COLOR [UIColor colorWithRed:(172/255.0) green:(185/255.0) blue:(204/255.0) alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0]
#define LIGHT_GRAY_COLOR [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0]
#define ORANGE_BUTTON   UIColorFromRGB(0xf16725)

#define GRAY_245 [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0]
#define GRAY_240 [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0]
#define GRAY_235 [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0]
#define GRAY_230 [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0]
#define GRAY_225 [UIColor colorWithRed:(225/255.0) green:(225/255.0) blue:(225/255.0) alpha:1.0]
#define GRAY_220 [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0]
#define GRAY_215 [UIColor colorWithRed:(215/255.0) green:(215/255.0) blue:(215/255.0) alpha:1.0]
#define GRAY_210 [UIColor colorWithRed:(210/255.0) green:(210/255.0) blue:(210/255.0) alpha:1.0]
#define GRAY_200 [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1.0]
#define GRAY_50 [UIColor colorWithRed:(50/255.0) green:(50/255.0) blue:(50/255.0) alpha:1.0]
#define GRAY_80 [UIColor colorWithRed:(80/255.0) green:(80/255.0) blue:(80/255.0) alpha:1.0]
#define GRAY_100 [UIColor colorWithRed:(100/255.0) green:(100/255.0) blue:(100/255.0) alpha:1.0]
#define GRAY_150 [UIColor colorWithRed:(150/255.0) green:(150/255.0) blue:(150/255.0) alpha:1.0]
#define ProgressHUD_BG [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]


#define FRONT_EMPTY_IMG     [UIImage imageNamed:@"passport_empty_front.png"]
#define BEHIND_EMPTY_IMG    [UIImage imageNamed:@"passport_empty_behind.png"]
#define DEFAULT_AVATAR      [UIImage imageNamed:@"default_avatar.png"]

#define nhanhoa_software_company    @"Công ty TNHH Phần mềm Nhân Hòa"

#define N_A             @"Không giá trị"
#define unknown         @"Chưa xác định"
#define not_support_yet @"Chưa hỗ trợ"

#define not_access_camera   @"Không thể truy cập vào camera. Vui lòng kiểm tra lại quyền truy cập của ứng dụng!"


#define text_close      @"Đóng"
#define text_choose     @"Chọn"






#define text_not_support    @"Tính năng đang được phát triển"

#define text_today      @"Hôm nay"
#define text_yesterday  @"Hôm qua"

#define text_signed_contract    @"Hợp đồng đã ký tên"
#define text_signing_contract   @"Ký tên lên hợp đồng"

#define notifCallStateChanged       @"notifCallStateChanged"
#define notifRegStateChanged        @"notifRegStateChanged"

#define CALL_INV_STATE_NULL         @"PJSIP_INV_STATE_NULL"
#define CALL_INV_STATE_CALLING      @"PJSIP_INV_STATE_CALLING"
#define CALL_INV_STATE_INCOMING     @"PJSIP_INV_STATE_INCOMING"
#define CALL_INV_STATE_EARLY        @"PJSIP_INV_STATE_EARLY"
#define CALL_INV_STATE_CONNECTING   @"PJSIP_INV_STATE_CONNECTING"
#define CALL_INV_STATE_CONFIRMED    @"PJSIP_INV_STATE_CONFIRMED"
#define CALL_INV_STATE_DISCONNECTED @"PJSIP_INV_STATE_DISCONNECTED"

#define text_checking_please_wait           @"Đang kiểm tra. Vui lòng chờ trong giây lát..."
#define text_register_to_protect_brand      @"Đăng ký ngay để bảo vệ thương hiệu của bạn."


#define text_main_account       @"Tài khoản chính"
#define text_bonus_money        @"Tiền thưởng"

#define text_register_domains       @"Đăng ký tên miền"
#define text_domains_pricing_list   @"Bảng giá tên miền"
#define text_search_domains         @"Kiểm tra tên miền"
#define text_top_up_into_account    @"Nạp tiền vào tài khoản"
#define text_bonus_account          @"Tài khoản thưởng"
#define text_draw_bonuses           @"Rút tiền thưởng"
#define text_profiles_list          @"Danh sách hồ sơ"

#define text_renew_domains          @"Gia hạn tên miền"
#define text_check_multi_domains    @"Kiểm tra nhiều tên miền"
#define text_transfer_to_nhanhoa    @"Chuyển tên miền về Nhân Hòa"
#define text_can_use_domains        @"Chúc mừng! Bạn có thể sử dụng tên miền:"
#define text_cannot_use_domains     @"Xin lỗi! Bạn không thể sử dụng tên miền:"
#define cannot_get_domains_pricing  @"Không thể lấy bảng giá tên miền"



#define text_domains            @"Tên miền"
#define text_registration_fee   @"Phí khởi tạo"
#define text_renewal_fee        @"Phí gia hạn"
#define text_transfer_to        @"Chuyển về"
#define text_free               @"Miễn phí"


#define text_loading    @"Đang tải..."
#define text_processing @"Đang xử lý..."

#define this_func_not_support_on_ipad   @"Chức năng này không hỗ trợ trên iPad"
#define you_are_using_newest_version    @"Bạn đang sử dụng phiên bản mới nhất."
#define text_update_version_now         @"Phiên bản hiện tại trên AppStore là %@. Bạn có muốn cập nhật ngay không?"
#define text_confirm_sign_out           @"Bạn có muốn đăng xuất khỏi ứng dụng hay không?"
#define text_failed_to_upload_avatar    @"Tải ảnh không thành công"
#define avatar_has_been_uploaded        @"Ảnh đại diện đã được cập nhật thành công."
#define your_info_has_been_updated      @"Thông tin đã được cập nhật thành công."
#define pls_enter_current_password      @"Vui lòng nhập mật khẩu hiện tại!"
#define pls_enter_new_password          @"Bạn chưa nhập mật khẩu mới!"
#define pls_enter_confirm_password      @"Bạn chưa nhập mật khẩu xác nhận!"
#define current_pass_is_incorrect       @"Mật khẩu hiện tại bạn nhập không chính xác. Vui lòng kiểm tra lại!"
#define password_must_be_at_least       @"Mật khẩu phải có độ dài tối thiểu %d kí tự"
#define password_has_been_updated       @"Mật khẩu đã được cập nhật thành công. Vui lòng đăng nhập lại với mật khẩu bạn vừa cập nhật."
#define your_message_was_sent           @"Tin nhắn của bạn đã được gửi"
#define pls_enter_your_email            @"Vui lòng nhập địa chỉ email của bạn!"
#define pls_enter_question_content      @"Vui lòng nhập nội dung muốn gửi!"
#define text_at_least_characters        @"Tối thiểu %d ký tự"
#define text_hide_info_when_whois       @"Ẩn thông tin của quý khách khi whois tên miền."

#define not_enough_money_to_register_domains    @"Số tiền hiện tại trong ví của bạn không đủ để thanh toán.\nBạn có muốn nạp tiền ngay?"
#define confirm_payment_when_register_domains   @"Số tiền thanh toán sẽ được trừ vào ví của bạn.\nBấm Xác nhận để tiến hành thanh toán."

#define text_home               @"Trang chủ"
#define text_account            @"Tài khoản"
#define text_trans_history      @"Lịch sử giao dịch"

#define text_account_settings   @"Cài đặt tài khoản"
#define text_domains_management @"Quản lý tên miền"
#define text_customers_support  @"Hỗ trợ khách hàng"
#define text_bank_account_info  @"Thông tin tài khoản ngân hàng"
#define text_app_info           @"Thông tin ứng dụng"

#define text_version            @"Phiên bản"
#define text_release_date       @"Ngày phát hành"
#define text_check_for_update   @"Kiểm tra cập nhật"
#define text_sign_out           @"Đăng xuất"
#define text_no                 @"Không"
#define text_update             @"Cập nhật"
#define text_save_update        @"Lưu cập nhật"
#define text_updating           @"Đang cập nhật..."
#define text_update_my_info     @"Cập nhật thông tin"
#define text_change_password    @"Đổi mật khẩu"

#define text_send_message       @"Gửi tin nhắn"
#define text_sending            @"Đang gửi..."

#define text_email_address      @"Địa chỉ email"
#define text_question_content   @"Nội dung câu hỏi"

#define text_reset              @"Nhập lại"
#define text_send_question      @"Gửi câu hỏi"

#define text_current_password   @"Mật khẩu hiện tại"
#define text_new_password       @"Mật khẩu mới"


#define enter_current_password  @"Nhập mật khẩu hiện tại"
#define enter_new_password      @"Nhập mật khẩu mới"
#define enter_confirm_password  @"Nhập xác nhận mật khẩu"








#define have_not_found_issue_yet    @"Bạn vẫn chưa tìm thấy vấn đề?"
#define text_call_hotline           @"Gọi tổng đài"
#define text_customers_care         @"Chăm sóc khách hàng"
#define text_cant_make_call_now     @"Không thể thực hiện cuộc gọi vào lúc này"

#define text_bank_name              @"Tên ngân hàng"
#define text_owner_name             @"Tên chủ sở hữu"
#define text_bank_account_number    @"Số tài khoản"
#define enter_bank_name             @"Nhập tên ngân hàng"
#define enter_owner_name            @"Nhập tên chủ sở hữu"
#define enter_bank_account_number   @"Nhập số  tài khoản"

#define register_vietnam_domains        @"Đăng ký tên miền quốc gia"
#define register_international_domains  @"Đăng ký tên miền quốc tế"

#define text_view_info          @"Xem thông tin"
#define text_creation_date      @"Ngày đăng ký"
#define text_expiration_date    @"Ngày hết hạn"
#define text_owner              @"Chủ sở hữu"
#define text_status             @"Trạng thái"
#define text_registrar          @"Nhà đăng ký"
#define text_name_servers       @"Name Servers"
#define text_DNSSEC             @"DNSSEC"
#define text_related_domains    @"Tên miền liên quan"
#define text_continue           @"Tiếp tục"
#define text_contact_price      @"Giá liên hệ"

#define text_shopping_cart      @"Giỏ hàng"
#define text_empty_cart         @"Giỏ hàng trống"
#define text_whois_protect      @"Whois Protect"

#define proceed_to_register     @"Tiến hành đăng ký"
#define continue_shopping       @"Tiếp tục mua hàng"
#define text_select_profile     @"Chọn hồ sơ"


//  SIGN IN & SIGN UP SCREEN
#define one_of_the_largest_domain_registrars_in_Vietnam @"Một trong những nhà đăng ký tên miền lớn nhất Việt Nam"
#define your_account_have_not_actived_yet               @"Tài khoản của bạn chưa được kích hoạt"
#define pls_fill_full_informations                      @"Vui lòng nhập đầy đủ thông tin"
#define your_version_is_old_please_update_new_version   @"Phiên bản quý khách đang sử dụng đã cũ.\nVui lòng cập nhật phiên bản mới để trải nghiệm tốt hơn."
#define do_you_already_have_an_account                  @"Bạn đã có tài khoản?"
#define otp_code_has_been_sent_to_your_phone_number     @"Mã OTP đã được gửi đến số điện thoại của bạn"
#define your_account_has_been_activated_successfully    @"Tài khoản của bạn đã được kích hoạt thành công"

#define no_internet             @"Không có kết nối internet. Vui lòng kiểm tra lại!"
#define text_welcome_to         @"Chào mừng đến với"
#define text_sign_in            @"Đăng nhập"
#define text_sign_up            @"Đăng ký"
#define text_signin_account     @"Tài khoản đăng nhập"
#define text_password           @"Mật khẩu"
#define text_forgot_password    @"Quên mật khẩu"
#define you_have_not_account    @"Bạn chưa có tài khoản?"
#define text_actived            @"Kích hoạt"
#define text_signing            @"Đang đăng nhập..."
#define text_account_info       @"Thông tin tài khoản"
#define text_profile_info       @"Thông tin hồ sơ"
#define text_email              @"Email"
#define text_confirm_password   @"Xác nhận mật khẩu"
#define enter_account_info      @"Nhập thông tin tài khoản"
#define enter_email_address     @"Nhập địa chỉ email"
#define enter_password          @"Nhập mật khẩu"
#define enter_confirm_password  @"Nhập xác nhận mật khẩu"
#define text_active_account     @"Kích hoạt tài khoản"
#define text_enter_confirm_code @"Nhập mã xác nhận"
#define text_confirm            @"Xác nhận"
#define text_resend             @"Gửi lại"
#define text_update_profile     @"Cập nhật hồ sơ"

#define email_format_is_incorrect   @"Định dạng email không chính xác!"
#define confirm_pass_is_incorrect   @"Xác nhận mật khẩu không chính xác!"
#define your_acc_is_being_actived   @"Tài khoản đang được kích hoạt..."
#define did_not_receive_otp_code    @"Không nhận được mã OTP?"
#define pls_enter_confirm_code      @"Vui lòng nhập mã xác nhận"

#define text_registration_purpose       @"Mục đích đăng ký"
#define text_enter_permanent_address    @"Nhập địa chỉ thường trú"

#define text_fullname           @"Họ tên"
#define text_enter_fullname     @"Nhập họ tên"
#define text_birthday           @"Ngày sinh"
#define text_gender             @"Giới tính"
#define text_male               @"Nam"
#define text_female             @"Nữ"
#define text_passport           @"CMND"
#define text_enter_passport     @"Nhập CMND"
#define text_phonenumber        @"Số điện thoại"
#define text_enter_phonenumber  @"Nhập số điện thoại"
#define text_address            @"Địa chỉ"
#define text_permanent_address  @"Địa chỉ thường trú"
#define text_country            @"Quốc gia"
#define text_city               @"Tỉnh/thành phố"
#define text_choose_city        @"Chọn tỉnh/thành phố"

#define pls_enter_fullname          @"Vui lòng nhập họ tên"
#define pls_choose_birthday         @"Vui lòng chọn ngày sinh"
#define pls_enter_birthday          @"Vui lòng nhập CMND"
#define pls_enter_phone_number      @"Vui lòng nhập Số điện thoại"
#define pls_enter_permanent_address @"Vui lòng nhập địa chỉ thường trú"
#define pls_choose_city             @"Vui lòng chọn Tỉnh/Thành phố"

#define text_unselect           @"Bỏ chọn"
#define text_select             @"Chọn"
#define text_vietnam            @"Việt Nam"
#define text_personal           @"Cá nhân"
#define text_business           @"Doanh nghiệp"

#define text_business_info      @"Phần thông tin doanh nghiệp"
#define text_business_name      @"Tên doanh nghiệp"
#define text_business_tax_code  @"Mã số thuế"
#define text_business_address   @"Địa chỉ doanh nghiệp"
#define text_business_phone     @"Số điện thoại doanh nghiệp"
#define text_registrar_info     @"Phần thông tin người đăng ký"
#define text_registrant_name    @"Họ tên người đăng ký"
#define text_postition          @"Chức vụ"
#define registrant_phone_number @"Số điện thoại người đăng ký"
#define registrant_address      @"Địa chỉ người đăng ký"

#define enter_business_name     @"Nhập tên doanh nghiệp"
#define enter_business_tax_code @"Nhập mã số thuế"
#define enter_business_address  @"Nhập địa chỉ doanh nghiệp"
#define enter_business_phone    @"Nhập số điện thoại doanh nghiệp"
#define enter_registrant_name   @"Nhập tên người đăng ký (CMND)"
#define enter_postition         @"Nhập chức vụ"
#define enter_passport          @"Nhập CMND"
#define enter_phone_number      @"Nhập số điện thoại"
#define enter_address           @"Nhập địa chỉ"
#define enter_email             @"Nhập địa chỉ email"

#define enter_registrant_address        @"Nhập địa chỉ người đăng ký"
#define pls_enter_business_name         @"Vui lòng nhập tên doanh nghiệp!"
#define pls_enter_business_tax_code     @"Vui lòng nhập mã số thuế doanh nghiệp!"
#define pls_enter_business_address      @"Vui lòng nhập địa chỉ doanh nghiệp!"
#define pls_enter_business_phone        @"Vui lòng nhập số điện thoại doanh nghiệp!"
#define pls_choose_business_city        @"Vui lòng chọn tỉnh/thành phố cho doanh nghiệp!"
#define pls_enter_registrant_name       @"Vui lòng nhập tên người đăng ký!"
#define pls_enter_registrant_dob        @"Vui lòng nhập ngày sinh người đăng ký!"
#define pls_enter_registrant_postition  @"Vui lòng nhập chức vụ người đăng ký!"
#define pls_enter_registrant_passport   @"Vui lòng nhập CMND người đăng ký!"
#define pls_enter_registrant_phone      @"Vui lòng nhập số điện thoại người đăng ký!"
#define pls_enter_registrant_address    @"Vui lòng nhập địa chỉ người đăng ký!"
#define pls_enter_registrant_email      @"Vui lòng nhập email người đăng ký!"

#define many_options_with_attractive_offers         @"Nhiều lựa chọn với ưu đãi hấp dẫn"
#define enter_one_or_more_domains_you_want_to_check @"Nhập một hay nhiều tên miền bạn muốn kiểm tra"

#define you_can_check_x_domains_at_time @"Bạn chỉ có thể tìm kiếm %d tên miền cùng lúc"
#define text_add_more_domains           @"Thêm tên miền"
#define text_enter_domains_to_check     @"Vui lòng nhập tên miền muốn kiểm tra!"

#define text_enter_domain_name  @"Nhập tên miền"
#define text_check              @"Kiểm tra"
#define text_search_results     @"Kết quả tra cứu"
#define text_checking           @"Đang kiểm tra..."
#define text_enter_to_search    @"Nhập để tìm kiếm..."
#define text_all_domains        @"Tất cả"
#define text_about_to_expire    @"Sắp hết hạn"
#define text_expires_on         @"Hết hạn ngày"
#define text_price_updating     @"Đang cập nhật"
#define text_undefined          @"Không xác định"

#define text_activated          @"Đã kích hoạt"
#define text_cancelled          @"Đã hủy"
#define text_in_process         @"Đang xử lý"
#define text_waiting            @"Đang chờ"
#define text_renewing           @"Đang gia hạn"
#define text_waiting_for_renewal @"Đang chờ gia hạn"
#define text_expired            @"Đã hết hạn"
#define text_suspending         @"Đang suspend"
#define text_suspended          @"Đã suspend"

#define text_proceed_renewals   @"Tiến hành gia hạn"
#define text_total              @"Tổng cộng"
#define text_total_payment      @"Thành tiền"
#define text_VAT                @"Thuế VAT"
#define text_later              @"Để sau"
#define topup_now               @"Nạp ngay"
#define text_renewals           @"Gia hạn"
#define text_year               @"năm"
#define text_years              @"năm"
#define text_first_year         @"1 năm đầu"

#define text_not_enough_money_to_renewals           @"Số tiền hiện tại trong ví của bạn không đủ để thanh toán.\nBạn có muốn nạp tiền ngay?"
#define text_do_you_want_to_renewals_this_domain    @"Bạn chắc chắn muốn gia hạn tên miền này?"
#define text_data_is_invalid                        @"Dữ liệu không hợp lệ. Vui lòng thử lại sau!"
#define text_your_domain_was_renewed_successfully   @"Tên miền đã được gia hạn thành công."
#define text_can_not_get_renewal_informations       @"Không thể lấy thông tin gia hạn."
#define pls_choose_photo_to_update                  @"Vui lòng chọn hình ảnh để cập nhật"
#define failed_to_upload_passport_photo             @"Tải ảnh CMND thất bại!"

#define text_data_is_invalidate     @"Dữ liệu không hợp lệ!"
#define text_birth_certificate      @"Bản khai"
#define text_front                  @"Mặt trước"
#define text_backside               @"Mặt sau"
#define text_update_passport        @"Cập nhật CMND"
#define text_change_name_server     @"Thay đổi Name Server"
#define text_dns_record_management  @"Quản lý DNS Records"
#define text_no_data                @"Không có dữ liệu"
#define text_edit                   @"Sửa"
#define text_capture                @"Chụp ảnh"
#define text_gallery                @"Thư viện ảnh"
#define text_remove                 @"Xóa"
#define text_TTL                    @"TTL"
#define text_MX                     @"MX"


//  #define text_record_notify          @"If it is A record, after creating it, wait 1 minute later to access it to prevent DNS cache."
#define text_record_notify          @"Nếu là A record thì sau khi tạo, đợi 1 phút sau hãy truy cập để tránh bị dính cache DNS."
#define text_add_new_record         @"Thêm mới record"
#define text_update_record          @"Cập nhật record"
#define text_record_value           @"Giá trị record"
#define text_record_name            @"Tên record"
#define text_record_type            @"Loại record"
#define text_choose_record_type     @"Chọn loại record"
#define text_MX_value               @"Giá trị MX"
#define text_TTL_value              @"Giá trị TTL"
#define text_create_record          @"Tạo record"
#define text_edit_record            @"Sửa record"
#define text_delete_record          @"Xóa record"
#define text_record_information     @"Thông tin Record"
#define text_not_found_your_domain  @"Không tìm thấy tên miền"
#define text_deleting               @"Đang xoá..."
#define text_type                   @"Loại"
#define text_value                  @"Giá trị"
#define text_name                   @"Tên"

#define you_are_adding_record_for_domains   @"Bạn đang thêm record cho tên miền"
#define you_are_updating_record_for_domains @"Bạn đang cập nhật record cho tên miền"
#define do_you_want_to_delete_this_record   @"Bạn chắc chắn muốn xoá record này?"

#define text_passport_photos        @"Ảnh CMND 2 mặt"
#define text_cancel                 @"Hủy"
#define text_save_profile           @"Lưu hồ sơ"
#define text_profile_detail         @"Chi tiết hồ sơ"

#define right_information_pay_now   @"Thông tin đúng, thanh toán ngay"


#endif /* AppString_t */
