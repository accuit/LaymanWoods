using ECommerce.BusinessLayer.Services.Contracts;
using LaymanWoods.BusinessLayer.Services;
using LaymanWoods.CommonLayer.Aspects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace MVC_Ecommerce.Controllers
{
    public class BaseAPIController : ApiController
    {
        private IUserService userBusinessInstance;
        private ISecurityService securityBusinessInstance;

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

    }
}