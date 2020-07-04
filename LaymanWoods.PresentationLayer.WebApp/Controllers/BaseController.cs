using LaymanWoods.BusinessLayer.Services;
using LaymanWoods.CommonLayer.Aspects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LaymanWoods.PresentationLayer.WebApp.Controllers
{
    public class BaseController: Controller
    {
        private IUserService userBusinessInstance;

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
    }
}