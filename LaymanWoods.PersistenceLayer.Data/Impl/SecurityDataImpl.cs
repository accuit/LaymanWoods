using LaymanWoods.CommonLayer.Aspects;
using LaymanWoods.CommonLayer.Aspects.Utilities;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using LaymanWoods.PersistenceLayer.Data.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaymanWoods.PersistenceLayer.Data.Impl
{
    /// <summary>
    /// Implementation class for system/user authorization and security in application
    /// </summary>
    public class SecurityDataImpl : BaseDataImpl, ISecurityRepository
    {
        /// <summary>
        /// Method to fetch user authorization parameters for various modules in application
        /// </summary>
        /// <param name="userID">user ID</param>
        /// <returns>returns entity collection</returns>
        //public IList<SecurityAspect> GetUserAuthorization(long userID)
        //{
        //    return (from urm in LaymanWoodsDbContext.UserRoleModulePermissions
        //            join rm in LaymanWoodsDbContext.RoleModules on urm.RoleModuleID equals rm.RoleModuleID
        //            join m in LaymanWoodsDbContext.Modules on rm.ModuleID equals m.ModuleID
        //            join rl in LaymanWoodsDbContext.RoleMasters on rm.RoleID equals rl.RoleID
        //            join ur in LaymanWoodsDbContext.UserRoles on rl.RoleID equals ur.RoleID
        //            join um in LaymanWoodsDbContext.UserMasters on ur.UserID equals um.UserID
        //            where um.UserID == userID && !um.IsDeleted && !m.IsDeleted && !rl.IsDeleted && urm.PermissionValue.Equals("1")
        //            && ur.IsActive && !ur.IsDeleted
        //            orderby urm.UserRolePermissionID
        //            select new SecurityAspect()
        //            {
        //                ModuleID = m.ModuleID,
        //                PermissionID = urm.PermissionID,
        //                PermissionValue = urm.PermissionValue,
        //                RoleID = ur.RoleID,
        //                UserID = um.UserID,
        //                UserRolePermissionID = urm.UserRolePermissionID,
        //                ModuleCode = m.ModuleCode.HasValue ? m.ModuleCode.Value : 0,
        //            }).ToList();

        //}


        #region Forgot Password Functions
        /// <summary>
        /// Validate Employee if given Employee Code is correct or not
        /// </summary>
        /// <param name="EmplCode">Employee Code of User</param>
        /// <param name="Type">Validation type (Only Employee Code, Employee Code and Email etc)</param>
        /// <returns></returns>
        //public bool ValidateEmployee(long userID, AspectEnums.EmployeeValidationType Type)
        //{
        //    bool IsValid = false;
        //    UserMaster user = null;
        //    //if (Type == AspectEnums.EmployeeValidationType.EmplCode)
        //    //{
        //    //    user = LaymanWoodsDbContext.UserMasters.FirstOrDefault(k => k.EmplCode == EmplCode && !k.IsDeleted);
        //    //}
        //    if (Type == AspectEnums.EmployeeValidationType.EmplCode_Email)
        //    {
        //        user = LaymanWoodsDbContext.UserMasters.FirstOrDefault(k => k.UserID == userID && !k.IsDeleted && !string.IsNullOrEmpty(k.EmailID));
        //    }
        //    if (Type == AspectEnums.EmployeeValidationType.FotgotPasswordAttempts)
        //    {

        //        DateTime Today = DateTime.Today;
        //        DateTime Tomorrow = DateTime.Today.AddDays(1);
        //        //UserMaster user1 = LaymanWoodsDbContext.UserMasters.FirstOrDefault(k => k.EmplCode == EmplCode && !k.IsDeleted);
        //        //// Check Max Attempts
        //        //if (user1 != null)
        //        //{
        //        int TodaysAttempts = LaymanWoodsDbContext.OTPMasters.Where(k => k.UserID == userID && k.CreatedDate >= Today && k.CreatedDate < Tomorrow).Count();
        //        int PasswordAttempts = Convert.ToInt32(AppUtil.GetAppSettings(AspectEnums.ConfigKeys.FotgotPasswordAttempts));
        //        IsValid = TodaysAttempts < PasswordAttempts;
        //        //}

        //    }
        //    if (Type == AspectEnums.EmployeeValidationType.LastAttemptDuration)
        //    {
        //        DateTime Now = DateTime.Now;
        //        //UserMaster user1 = LaymanWoodsDbContext.UserMasters.FirstOrDefault(k => k.EmplCode == EmplCode && !k.IsDeleted);
        //        //// Check Last Attempt
        //        //if (user1 != null)
        //        //{
        //        string LastAttemptDuration = AppUtil.GetAppSettings(AspectEnums.ConfigKeys.LastAttemptDuration);
        //        string[] TimeArr = LastAttemptDuration.Split(':');

        //        DateTime LastAttemptStart = Now.Subtract(new TimeSpan(Int32.Parse(TimeArr[0]), Int32.Parse(TimeArr[1]), Int32.Parse(TimeArr[2])));

        //        IsValid = LaymanWoodsDbContext.OTPMasters.Where(k => k.UserID == userID && k.CreatedDate >= LastAttemptStart && k.CreatedDate < Now).Count() <= 0;


        //        //}

        //    }

        //    if (user != null)
        //        IsValid = true;

        //    return IsValid;
        //}

        /// <summary>
        /// Get Email Template based on ID
        /// </summary>
        /// <param name="TemplateTypeID">Template ID</param>
        /// <returns>Obejct of EmailTemplate</returns>
        public EmailTemplate GetEmailTemplate(AspectEnums.EmailTemplateType TemplateTypeID)
        {
            return LaymanWoodsDbContext.EmailTemplates.FirstOrDefault(k => k.TemplateID == (int)TemplateTypeID && k.IsActive);
        }

        /// <summary>
        /// save OTP (One Time Password) to database
        /// </summary>
        /// <param name="otp"> Object of OTP</param>
        /// <returns>returns true when data is saved</returns>
        public bool SaveOTP(OTPMaster otp)
        {
            bool IsSuccess = false;
            // In case from Generating OTP from Automatic redirect to Change Password because of not complex password multiple OTPs can be generated
            // Use this validation to restrict user to generate multiple OTPs
            //if (ValidateEmployee(otp.UserID, AspectEnums.EmployeeValidationType.LastAttemptDuration))
            //{
            LaymanWoodsDbContext.Entry<OTPMaster>(otp).State = System.Data.Entity.EntityState.Modified;
            IsSuccess = LaymanWoodsDbContext.SaveChanges() > 0;
            //}
            return IsSuccess;

        }


        /// <summary>
        /// Authenticate OTP (One Time Password) entered by user
        /// </summary>
        /// <param name="userid">Userid</param>
        /// <param name="otp">One Time Password</param>
        /// <returns>reurns true if user have enterered latest OTP</returns>
        public bool AuthenticateOTP(long userid, string otp, out string GuidString, out int MaxAttempts)
        {
            OTPMaster ObjOTP = LaymanWoodsDbContext.OTPMasters.OrderByDescending(k => k.CreatedDate).FirstOrDefault(k => k.UserID == userid);

            GuidString = "";
            MaxAttempts = 0;
            if (ObjOTP != null)
            {
                MaxAttempts = ObjOTP.Attempts.Value;
                if (ObjOTP.OTP == otp)
                {
                    GuidString = ObjOTP.GUID;
                    return true;
                }
                else
                {
                    ObjOTP.Attempts = ++MaxAttempts;
                    LaymanWoodsDbContext.Entry<OTPMaster>(ObjOTP).State = System.Data.Entity.EntityState.Modified;
                    LaymanWoodsDbContext.SaveChanges(); // TBD
                }
            }

            //}

            return false;
        }
        /// <summary>
        /// Get UserID By Employee Code given in parameter
        /// </summary>
        /// <param name="EmplCode"></param>
        /// <returns></returns>
        //public long? GetUserIDByEmployeeCode(string EmplCode)
        //{
        //    UserMaster user = null;
        //    user = LaymanWoodsDbContext.UserMasters.FirstOrDefault(k => k.EmplCode == EmplCode && !k.IsDeleted);
        //    if (user != null)
        //        return user.UserID;
        //    else
        //        return null;
        //}

        /// <summary>
        /// Validate GUID in the link of forget password email
        /// </summary>
        /// <param name="GUID"> uniqe string </param>
        /// <returns>true if GUID in the URL is correct</returns>
        public bool ValidateGUID(string GUID)
        {
            int OTPExirationHrs = Convert.ToInt32(AppUtil.GetAppSettings(AspectEnums.ConfigKeys.OTPExirationHrs));

            DateTime StartTime = DateTime.Now.Subtract(new TimeSpan(OTPExirationHrs, 0, 0));
            DateTime EndTime = DateTime.Now.AddMinutes(1);
            OTPMaster objOTP = LaymanWoodsDbContext.OTPMasters.FirstOrDefault(k => k.CreatedDate >= StartTime && k.CreatedDate <= EndTime && k.GUID == GUID);
            if (objOTP != null)
                return true;
            else
                return false;
        }

        /// <summary>
        /// Change password of User
        /// </summary>
        /// <param name="GUID"> uniqe string </param>
        /// <param name="Password">password entered by user</param>
        /// <returns></returns>
        //public bool ChangePassword(string GUID, string Password)
        //{
        //    int OTPExirationHrs = Convert.ToInt32(AppUtil.GetAppSettings(AspectEnums.ConfigKeys.OTPExirationHrs));
        //    DateTime StartTime = DateTime.Now.Subtract(new TimeSpan(OTPExirationHrs, 0, 0));
        //    DateTime EndTime = DateTime.Now;
        //    OTPMaster objOTP = LaymanWoodsDbContext.OTPMasters.FirstOrDefault(k => k.CreatedDate >= StartTime && k.CreatedDate <= EndTime && k.GUID == GUID);
        //    if (objOTP != null)
        //    {
        //        UserMaster user = LaymanWoodsDbContext.UserMasters.FirstOrDefault(k => k.UserID == objOTP.UserID && !k.IsDeleted);
        //        user.Password = EncryptionEngine.EncryptString(Password);
        //        LaymanWoodsDbContext.Entry<UserMaster>(user).State = System.Data.EntityState.Modified;
        //        //Delete all previous OTPs
        //        foreach (var o in LaymanWoodsDbContext.OTPMasters.Where(k => k.UserID == user.UserID))
        //            LaymanWoodsDbContext.OTPMasters.Remove(o);

        //        return LaymanWoodsDbContext.SaveChanges() > 0;
        //    }
        //    else
        //        return false;
        //}

        #endregion
    }
}
