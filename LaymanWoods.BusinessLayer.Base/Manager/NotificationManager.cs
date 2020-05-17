﻿using System.Collections.Generic;
using AutoMapper;
using LaymanWoods.BusinessLayer.Services.Contracts;
using LaymanWoods.CommonLayer.Aspects.DTO;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using LaymanWoods.PersistenceLayer.Data.Repository;

namespace LaymanWoods.BusinessLayer.Base.Manager
{
    public class NotificationManager : ServiceBase, INotificationService
    {
        #region initialize private fields

        [Unity.Dependency(ContainerDataLayerInstanceNames.NOTIFICATION_REPOSITORY)]
        public INotificationRepository NotificationRepository { get; set; }
        private readonly IMapper mapper;
        public NotificationManager(IMapper mapper)
        {
            this.mapper = mapper;
        }

        #endregion
        public int SubmitContactEnquiry(ContactEnquiryDTO model)
        {
            ContactEnquiry contact = new ContactEnquiry();
            contact = mapper.Map<ContactEnquiry>(model);
            return NotificationRepository.SubmitContactEnquiry(contact);
        }

        public int SubmitEntrepreneurEnquiry(EntrepreneurEnquiryDTO model)
        {
            EntrepreneurEnquiry contact = new EntrepreneurEnquiry();
            contact = mapper.Map<EntrepreneurEnquiry>(model);
            return NotificationRepository.SubmitEntrepreneurEnquiry(contact);
        }
    }
}
