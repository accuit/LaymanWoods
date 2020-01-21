using LaymanWoods.CommonLayer.Aspects.DTO;
using ECommerce.CommonLayer.Utilities;
using LaymanWoods.CommonLayer.Aspects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MVC_Ecommerce.Controllers
{
    [RoutePrefix("api/notification")]
    public class NotificationController : BaseAPIController
    {

        [Route("email-appointment")]
        [HttpPost]
        public JsonResponse<int> SendAppointmentEmail(int UserId)
        {
            JsonResponse<int> response = new JsonResponse<int>();

            try
            {
                bool IsSuccess = false;
                #region Prepare OTP Data
                string UniqueString = AppUtil.GetUniqueGuidString();
                string OTPString = AppUtil.GetUniqueRandomNumber(100000, 999999); // Generate a Six Digit OTP
                OTPDTO objOTP = new OTPDTO() { GUID = UniqueString, OTP = OTPString, CreatedDate = DateTime.Now, UserID = UserId, Attempts = 0 };
                #endregion

                #region Save OTP and Send Email
                if (SecurityBusinessInstance.SaveOTP(objOTP))
                {
                    #region Send Email
                    string hostName = AppUtil.GetAppSettings(AspectEnums.ConfigKeys.HostName);
                    string rawURL = AppUtil.GetAppSettings(AspectEnums.ConfigKeys.ForgotPasswordURL);
                    string PasswordResetURL = String.Format(rawURL, hostName) + "?id=" + UniqueString;

                    EmailTemplateDTO objEmailTemplate = securityBusinessInstance.GetEmailTemplate(AspectEnums.EmailTemplateType.ForgotPassword);
                    var userProfile = UserBusinessInstance.DisplayUserProfile(UserId);
                    EmailServiceDTO emailService = new EmailServiceDTO();
                    emailService.Body = string.Format(objEmailTemplate.Body, userProfile.FirstName, OTPString, PasswordResetURL);
                    emailService.Priority = 1;
                    emailService.IsHtml = true;
                    emailService.Status = (int)AspectEnums.EmailStatus.Pending;
                    emailService.ToName = userProfile.FirstName;
                    emailService.ToEmail = userProfile.EmailID;
                    emailService.FromEmail = userProfile.EmailID;
                    emailService.Subject = objEmailTemplate.Subject;
                    //BatchBusinessInstance.InsertEmailRecord(emailService);

                    IsSuccess = true;

                    #endregion
                }
                #endregion

                return IsSuccess;
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = ex.Message;
                response.StatusCode = "500";
                response.SingleResult = 0;
            }

            return response;
        }
    }
}
