using LaymanWoods.PersistenceLayer.Data.EDMX;
using LaymanWoods.PersistenceLayer.Data.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaymanWoods.PersistenceLayer.Data.Impl
{
    public class UserDataImpl : BaseDataImpl, IUserRepository
    {
        //public List<UserMaster> GetUser()
        //{
        //    try
        //    {
        //        return LaymanWoodsDbContext.UserMasters.ToList();
        //    }
        //    catch (Exception ex)
        //    {
        //        return new List<UserMaster>();
        //    }

        //}

        public UserMaster UserLogin(string email, string password)
        {
            return DbContext.UserMasters.Where(x => x.EmailID == email && x.Password == password).FirstOrDefault();
        }

        //public int SubmitUser(UserMaster user)
        //{
        //    LaymanWoodsDbContext.UserMasters.Add(user);
        //    return LaymanWoodsDbContext.SaveChanges();
        //}

        //public int GetUserRoleID(int userID)
        //{
        //    return Convert.ToInt32(LaymanWoodsDbContext.UserRoles.Where(x => x.UserID == userID).FirstOrDefault().RoleID);
        //}
    }
}
