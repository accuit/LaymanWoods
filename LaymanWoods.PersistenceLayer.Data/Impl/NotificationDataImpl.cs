using System;
using System.Collections.Generic;
using System.Linq;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using LaymanWoods.PersistenceLayer.Data.Repository;

namespace LaymanWoods.PersistenceLayer.Data.Impl
{
    public class NotificationDataImpl : BaseDataImpl, INotificationRepository
    {
        public int SubmitContactEnquiry(ContactEnquiry model)
        {
            model.CreatedDate = DateTime.Now;
            DbContext.ContactEnquiries.Add(model);
            return DbContext.SaveChanges();
        }

        public int SubmitEntrepreneurEnquiry(EntrepreneurEnquiry model)
        {
            model.CreatedDate = DateTime.Now;
            DbContext.EntrepreneurEnquiries.Add(model);
            return DbContext.SaveChanges();
        }
    }
}
