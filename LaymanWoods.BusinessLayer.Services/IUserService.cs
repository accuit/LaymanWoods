using LaymanWoods.BusinessLayer.Services.BO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaymanWoods.BusinessLayer.Services
{
    public interface IUserService
    {
        UserMasterBO UserLogin(string email, string password);
        List<UserMasterBO> GetUser();
        int SubmitUser(UserMasterBO user);
        int GetUserRoleID(int userID);
    }
}
