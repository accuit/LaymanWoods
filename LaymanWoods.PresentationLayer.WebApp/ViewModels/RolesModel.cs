using LaymanWoods.BusinessLayer.Services.BO;
using System;
using System.Collections.Generic;

namespace LaymanWoods.PresentationLayer.WebApp.ViewModels
{
    public class RolesModel
    {
        public List<RoleMasterBO> roles { get; set; }
        public List<UserRoleBO> userRoles { get; set; }
    }


}