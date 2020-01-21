using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaymanWoods.CommonLayer.Aspects
{
    public static class AspectEnums
    {
        public enum ApplicationName
        {
            ECommerce,
        }

        public enum AspectInstanceNames
        {
            UserManager
        }

        public enum PeristenceInstanceNames
        {
            UserDataImpl
        }

        public enum RoleType
        {
            Admin = 1,
            Employee = 2,
            Customer = 3,
            Default = 99
        }

        public enum ImageFileTypes
        {
            Survey,
            User,
            General,
            Store,
            Expense,
            DealerCreation
        }

        public enum ConfigKeys
        {
            APKDownloadURL,
            HostName,
            FileProcessorURL,
            ImagesPath
        }

    }
}
