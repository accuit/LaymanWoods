using LaymanWoods.BusinessLayer.Base;
using LaymanWoods.CommonLayer.Aspects;
using LaymanWoods.CommonLayer.Aspects.DTO;
using LaymanWoods.PersistenceLayer.Data.Repository;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using LaymanWoods.BusinessLayer.Services.Contracts;

namespace LaymanWoods.BusinessLayer.ServiceImpl
{
    public class SecurityManager : ServiceBase, ISecurityService
    {
        [Unity.Dependency(ContainerDataLayerInstanceNames.SECURITY_REPOSITORY)]
        public ISecurityRepository SecurityRepository { get; set; }


        public bool SaveOTP(OTPDTO otp)
        {
            OTPMaster otpmaster = new OTPMaster();
            ObjectMapper.Map(otp, otpmaster);
            return SecurityRepository.SaveOTP(otpmaster);
        }

        /// <summary>
        /// Get Email Template based on ID
        /// </summary>
        /// <param name="TemplateTypeID">Template ID</param>
        /// <returns>Obejct of EmailTemplate</returns>
        public EmailTemplateDTO GetEmailTemplate(AspectEnums.EmailTemplateType TemplateTypeID)
        {
            EmailTemplateDTO emailTemplate = new EmailTemplateDTO();
            ObjectMapper.Map(SecurityRepository.GetEmailTemplate(TemplateTypeID), emailTemplate);
            return emailTemplate;
        }
    }
}
