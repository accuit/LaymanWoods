using LaymanWoods.CommonLayer.Aspects.DTO;
using LaymanWoods.CommonLayer.Aspects;
using System;
using System.Web.Http;
using LaymanWoods.CommonLayer.Aspects.Utilities;
using System.Collections.Generic;

namespace LaymanWoods.PresentationLayer.WebApp.Controllers
{
    [RoutePrefix("api/notification")]
    public class NotificationController : BaseAPIController
    {
        [Route("values")]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        [Route("appointment/{UserId}")]
        [HttpGet]
        public JsonResponse<int> SendAppointmentEmail(int UserId)
        {
            JsonResponse<int> response = new JsonResponse<int>();

            try
            {
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

                    EmailTemplateDTO objEmailTemplate = SecurityBusinessInstance.GetEmailTemplate(AspectEnums.EmailTemplateType.ForgotPassword);
                    var userProfile = new Object(); // UserBusinessInstance.DisplayUserProfile(UserId);
                    EmailServiceDTO emailService = new EmailServiceDTO();
                    //emailService.Body = string.Format(objEmailTemplate.Body, userProfile.FirstName, OTPString, PasswordResetURL);
                    //emailService.Priority = 1;
                    //emailService.IsHtml = true;
                    //emailService.Status = (int)AspectEnums.EmailStatus.Pending;
                    //emailService.ToName = userProfile.FirstName;
                    //emailService.ToEmail = userProfile.EmailID;
                    //emailService.FromEmail = userProfile.EmailID;
                    //emailService.Subject = objEmailTemplate.Subject;
                    //BatchBusinessInstance.InsertEmailRecord(emailService);

                    response.IsSuccess = true;
                    #endregion
                }
                #endregion

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
