using LaymanWoods.CommonLayer.Aspects;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using System.Collections.Generic;


namespace LaymanWoods.PersistenceLayer.Data.Repository
{
    public interface INotificationRepository
    {
        int SubmitContactEnquiry(ContactEnquiry model);
        int SubmitEntrepreneurEnquiry(EntrepreneurEnquiry model);
    }
}
