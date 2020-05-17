using LaymanWoods.CommonLayer.Aspects.DTO;
using System.Collections.Generic;

namespace LaymanWoods.BusinessLayer.Services.Contracts
{
    public interface INotificationService
    {
        int SubmitContactEnquiry(ContactEnquiryDTO model);
        int SubmitEntrepreneurEnquiry(EntrepreneurEnquiryDTO model);
    }
}
