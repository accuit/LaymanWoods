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
            LaymanWoods
        }

        public enum AspectInstanceNames
        {
            UserManager,
            SecurityManager,
            ProductManager,
            NotificationManager
        }

        public enum PeristenceInstanceNames
        {
            UserDataImpl,
            SecurityDataImpl,
            ProductDataImpl,
            NotificationDataImpl
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
            Product,
            Store,
            Expense,
            DealerCreation
        }

        public enum ConfigKeys
        {
            APKDownloadURL,
            HostName,
            FileProcessorURL,
            ImagesPath,
            ForgotPasswordURL,
            OTPExirationHrs,
            LastAttemptDuration
        }

        public enum EnquiryStatus
        {
            None = 0,
            Received = 1,
            InProcess = 2,
            Delivered = 3,
            Failed = 4,
        }

        public enum EmailStatus
        {
            None = 0,
            Pending = 1,
            Sent = 2,
            Delivered = 3,
            Failed = 4,
        }

        public enum EmailTemplateType
        {
            ForgotPassword = 1
        }

    }
}
