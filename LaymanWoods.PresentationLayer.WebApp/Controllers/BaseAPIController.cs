﻿using LaymanWoods.BusinessLayer.Services;
using LaymanWoods.BusinessLayer.Services.Contracts;
using LaymanWoods.CommonLayer.Aspects;
using System.Web.Http;

namespace LaymanWoods.PresentationLayer.WebApp.Controllers
{
    public class BaseAPIController : ApiController
    {
        private IUserService userBusinessInstance;
        private ISecurityService securityBusinessInstance;
        private IProductService productBusinessInstance;
        private INotificationService notificationBusinessInstance;
        public IUserService UserBusinessInstance
        {
            get
            {
                if (userBusinessInstance == null)
                {
                    userBusinessInstance = AopEngine.Resolve<IUserService>(AspectEnums.AspectInstanceNames.UserManager, AspectEnums.ApplicationName.LaymanWoods);
                }
                return userBusinessInstance;
            }
        }

        public ISecurityService SecurityBusinessInstance
        {
            get
            {
                if (securityBusinessInstance == null)
                {
                    securityBusinessInstance = AopEngine.Resolve<ISecurityService>(AspectEnums.AspectInstanceNames.SecurityManager, AspectEnums.ApplicationName.LaymanWoods);
                }
                return securityBusinessInstance;
            }
        }

        public IProductService ProductBusinessInstance
        {
            get
            {
                if (productBusinessInstance == null)
                {
                    productBusinessInstance = AopEngine.Resolve<IProductService>(AspectEnums.AspectInstanceNames.ProductManager, AspectEnums.ApplicationName.LaymanWoods);
                }
                return productBusinessInstance;
            }
        }

        public INotificationService NotificationBusinessInstance
        {
            get
            {
                if (notificationBusinessInstance == null)
                {
                    notificationBusinessInstance = AopEngine.Resolve<INotificationService>(AspectEnums.AspectInstanceNames.NotificationManager, AspectEnums.ApplicationName.LaymanWoods);
                }
                return notificationBusinessInstance;
            }
        }

    }
}