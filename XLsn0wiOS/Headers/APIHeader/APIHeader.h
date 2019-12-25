
#ifndef APIHeader_h
#define APIHeader_h
/***********************************************************************************************************************/
/**********************详细API接口地址************************************************************************************/

#define BASEURL    ServerDomain
#define PicBASEURL ServerDomain
#define UrL_MACRO(p) [NSString stringWithFormat:@"%@%@",BASEURL,p]
/***********************************************************************************************************************/
/***********************************************************************************************************************/
#define getPharmaciesWithRowURL        HTTPAPI(@"/api/pharmacies/pharmaciesByDoctor")
#define getOintmentTotalCountURL       HTTPAPI(@"/api/orderMaster/itemQuantity")
#define getPackageArrayURL             HTTPAPI(@"/pharmaciesPackageMethod/query")
#define productTypeURL                 HTTPAPI(@"/api/productType/v1/getProductType")
#define CreateOrderURL                 HTTPAPI(@"/api/orderMaster/v1/storeOrder")

#define UrL_Login                      UrL_MACRO(@"/doctor/login")//登录
#define UrL_SendYanZhengMa             UrL_MACRO(@"/information/sendMessage")//验证码
#define UrL_CheckoutMessageForPhone    UrL_MACRO(@"/information/checkoutMessage")//短信验证
#define UrL_QueryDoctorProperty        UrL_MACRO(@"/information/queryDoctorProperty")//查询科室和职称
#define UrL_UpdatePassword             UrL_MACRO(@"/doctor/updatePassword")//忘记密码
#define UrL_ShortcutLogin              UrL_MACRO(@"/doctor/shortcutLogin")//医生快捷登陆
#define UrL_UserInfoShortcutLogin      UrL_MACRO(@"/userinfo/shortcutLogin")//患者快捷登陆
#define UrL_UpdateDoctor               UrL_MACRO(@"/doctor/updateDoctor")//修改个人信息和上传个人名片
#define UrL_QueryBanner                UrL_MACRO(@"/information/queryBanner")//查询轮播图
#define UrL_RegisterUser               UrL_MACRO(@"/doctor/register")//注册
#define UrL_QueryConsult               UrL_MACRO(@"/information/queryConsult")//查询咨询中心
#define UrL_UplodeCertificate          UrL_MACRO(@"/doctor/uplodeDoctorCertificate")//上传资格证书
#define UrL_QueryInquiryBillByDoctorId UrL_MACRO(@"/inquiryBill/queryInquiryBillByDoctorId")//查询问诊单
#define UrL_QueryMyAttentionOrMyFans   UrL_MACRO(@"/userinfo/queryMyAttentionOrMyFans")//查询医生的粉丝和患者
#define UrL_QueryDoctorCase            UrL_MACRO(@"/doctor/queryDoctorCase")//查询医案
#define UrL_QueryDoctorCaseDetails     UrL_MACRO(@"/doctor/queryDoctorCaseDetails")//查询医案详情
#define UrL_AddDoctorCase              UrL_MACRO(@"/doctor/addDoctorCase")//添加医案
#define UrL_CreationDoctorCase         UrL_MACRO(@"/doctor/creationDoctorCase")//创建医案
#define UrL_QueryPrescriptionBySelf    UrL_MACRO(@"/inquiryBill/queryPrescriptionBySelf")//查询医生给患者开的处方
#define UrL_QueryMedicinalMaterials    UrL_MACRO(@"/information/queryMedicinalMaterials")//查询药材库
#define UrL_SaveUserinfoPrescription   UrL_MACRO(@"/inquiryBill/saveUserinfoPrescription")//医生给患者开处方
#define UrL_QueryDoctorPrescription    UrL_MACRO(@"/doctor/queryDoctorPrescription")//查询自备良方
#define UrL_SaveOrUpdateDoctorPrescription UrL_MACRO(@"/doctor/saveOrUpdateDoctorPrescription")//添加和修改自备良方
#define UrL_QueryMedicineBook          UrL_MACRO(@"/information/queryMedicineBook")//查询处方大全
#define UrL_QueryMedicineBookDetail    UrL_MACRO(@"/information/queryMedicineBookDetail")//根据处方大全id查询处方
#define UrL_QueryCertificate           UrL_MACRO(@"/doctor/queryCertificate")//查询医生资格认证
#define UrL_UpdateShowType             UrL_MACRO(@"/doctor/updateShowType")//修改医生可见状态
#define UrL_QueryMyAttention           UrL_MACRO(@"/userinfo/queryMyAttention")//根据患者名字查询医生的患者
#define UrL_SaveFeedBack               UrL_MACRO(@"/information/saveFeedBack")//添加意见反馈
#define UrL_QueryInformation           UrL_MACRO(@"/information/queryInformation")//查询基本信息
#define UrL_Withdrawal                 UrL_MACRO(@"/doctor/withdrawal")//提现
#define UrL_QueryAccountDetail         UrL_MACRO(@"/doctor/v1/queryAccountDetail")//查流水
#define UrL_doctor_invite_award        UrL_MACRO(@"/doctor/invite/award")//邀请奖励详情
#define UrL_QueryDoctorInvite          UrL_MACRO(@"/doctor/queryDoctorInvite")//查询医生邀请的好友
#define UrL_QpdateinquiryBillState     UrL_MACRO(@"/inquiryBill/updateinquiryBillState")//将问诊单标注被回复
#define UrL_UpdateInquiryBillBySeeType UrL_MACRO(@"/inquiryBill/updateInquiryBillBySeeType")//将问诊单标记为已看
#define UrL_QueryUserinfoById          UrL_MACRO(@"/userinfo/queryUserinfoById")//根据患者id查询患者信息
#define UrL_GetRongYunToken            UrL_MACRO(@"/doctor/getRongYunToken")//重新获取融云token
#define UrL_QueryRoyalty               UrL_MACRO(@"/information/queryRoyalty")//查询提成
#define UrL_DeleteDoctorPrescription   UrL_MACRO(@"/doctor/deleteDoctorPrescription")//删除自备良方
#define UrL_DeleteDoctorCase           UrL_MACRO(@"/doctor/deleteDoctorCase")//删除医案
#define UrL_DoctorSendMessage          UrL_MACRO(@"/doctor/doctorSendMessage")//医生回复患者微信消息推送
#define UrL_QueryPatientOrder          UrL_MACRO(@"/patientOrder/queryPatientOrder")//查询患者订单
#define UrL_QueryNewestVersion         UrL_MACRO(@"/information/queryNewestVersion")//查最新版本信息
#define UrL_QueryBankCard              UrL_MACRO(@"/api/bankCards?doctorId=")//查询医生银行卡
#define UrL_DeleteBankCard             UrL_MACRO(@"/api/bankCards/")//删医生银行卡
#define UrL_SaveBankCard               UrL_MACRO(@"/api/bankCards")//增医生银行卡
#define UrL_GetBankInfoByBaiduApi      UrL_MACRO(@"/api/bankCards/getBankInfoByBaiduApi")//识别银行卡
#define UrL_AddRemarkNames             UrL_MACRO(@"/api/remarkNames")//新增备注
#define UrL_Protocols                  UrL_MACRO(@"/api/appNotices/1")//积分兑换提示语
#define UrL_PcheckTax                  UrL_MACRO(@"/api/appNotices/checkTax")//积分兑换提示语
#define UrL_Book2prescription          UrL_MACRO(@"/api/doctorPrescription/book2prescription")//处方大全一键变为自备良方
/***********************************************************************************************************************/
/***********************************************************************************************************************/
#endif /* APIHeader_h */
