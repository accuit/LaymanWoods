using AutoMapper;
using LaymanWoods.BusinessLayer.Services;
using LaymanWoods.BusinessLayer.Services.BO;
using LaymanWoods.PersistenceLayer.Data.Repository;
using LaymanWoods.PersistenceLayer.Data.Impl;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Unity;
using static LaymanWoods.BusinessLayer.Base.ServiceBase;
using LaymanWoods.PersistenceLayer.Data.EDMX;

namespace LaymanWoods.BusinessLayer.Base
{
    public class UserManager : ServiceBase, IUserService
    {
        [Unity.Dependency(ContainerDataLayerInstanceNames.USER_REPOSITORY)]
        public IUserRepository UserRepository { get; set; }
        private readonly IMapper mapper;

        public UserManager(IMapper mapper)
        {
            this.mapper = mapper;
        }

        //public UserMasterBO UserLogin(string email, string password)
        //{
        //    //UserMasterBO user = new UserMasterBO();
        //    //UserMaster result = UserRepository.UserLogin(email, password);
        //    //user = Mapper.Map<UserMaster, UserMasterBO> result;
        //    //ObjectMapper.Map(UserRepository.UserLogin(email, password), user);

        //    return mapper.Map<UserMasterBO>(UserRepository.UserLogin(email, password));
        //}

        //public List<UserMasterBO> GetUser()
        //{
        //    return mapper.Map<List<UserMasterBO>>(UserRepository.GetUser());
        //}

        //public int SubmitUser(UserMasterBO user)
        //{
        //    UserMaster U = mapper.Map<UserMaster>(user);

        //    return UserRepository.SubmitUser(U);
        //}

        //public int GetUserRoleID(int userID)
        //{
        //    return UserRepository.GetUserRoleID(userID);
        //}
    }
}
