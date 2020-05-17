using LaymanWoods.CommonLayer.Aspects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaymanWoods.BusinessLayer.Base
{

    public abstract class ServiceBase : MarshalByRefObject
    {
        /// <summary>
        /// Property to get set object mapping instance
        /// </summary>
        [Unity.Dependency]
        public Mapper ObjectMapper
        {
            get;
            set;
        }

        /// <summary>
        /// Struct to get the container instance names for Data/Persistence layer registrations
        /// </summary>
        public struct ContainerDataLayerInstanceNames
        {
            public const string USER_REPOSITORY = "LaymanWoods_UserDataImpl";
            public const string SECURITY_REPOSITORY = "LaymanWoods_SecurityDataImpl";
            public const string PRODUCT_REPOSITORY = "LaymanWoods_ProductDataImpl";
            public const string NOTIFICATION_REPOSITORY = "LaymanWoods_NotificationDataImpl";
        }

        /// <summary>
        /// Struct to get the container instance names for Business layer registrations
        /// </summary>
        public struct ContainerBusinessLayerInstanceNames
        {
            public const string USER_MANAGER = "LaymanWoods_UserManager";
            public const string SECURITY_MANAGER = "LaymanWoods_SecurityManager";
            public const string PRODUCT_MANAGER = "LaymanWoods_ProductManager";
            public const string NOTIFICATION_MANAGER = "LaymanWoods_NotificationManager";
        }

    }
}
