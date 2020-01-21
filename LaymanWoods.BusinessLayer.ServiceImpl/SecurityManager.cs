using ECommerce.BusinessLayer.Services.Contracts;
using LaymanWoods.BusinessLayer.Base;
using LaymanWoods.CommonLayer.Aspects;
using LaymanWoods.CommonLayer.Aspects.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaymanWoods.BusinessLayer.ServiceImpl
{
    public class SecurityManager : ServiceBase, ISecurityService
    {
        [Microsoft.Practices.Unity.Dependency(ContainerDataLayerInstanceNames.SECURITY_REPOSITORY)]
        public ISecurityRepository SecurityRepository { get; set; }


        public bool SaveOTP(OTPDTO otp)
        {
            throw new NotImplementedException();
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
