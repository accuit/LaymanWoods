namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("UserMaster")]
    public partial class UserMaster
    {
        [Key]
        public long UserID { get; set; }

        public int CompanyID { get; set; }

        [StringLength(50)]
        public string UserCode { get; set; }

        [Required]
        [StringLength(50)]
        public string EmplCode { get; set; }

        [StringLength(50)]
        public string FirstName { get; set; }

        [StringLength(50)]
        public string LastName { get; set; }

        [StringLength(50)]
        public string Username { get; set; }

        [Required]
        [StringLength(100)]
        public string Password { get; set; }

        [StringLength(50)]
        public string MySingleID { get; set; }

        [StringLength(50)]
        public string Mobile_Calling { get; set; }

        [StringLength(50)]
        public string Mobile_SD { get; set; }

        [StringLength(150)]
        public string EmailID { get; set; }

        public bool IsSSOLogin { get; set; }

        [StringLength(50)]
        public string UserCommunicationGroup { get; set; }

        public int? ProductTypeID { get; set; }

        public DateTime? EnrollmentDate { get; set; }

        public int AccountStatus { get; set; }

        public bool IsOfflineProfile { get; set; }

        [StringLength(120)]
        public string ProfilePictureFileName { get; set; }

        [StringLength(300)]
        public string Address { get; set; }

        [StringLength(30)]
        public string Pincode { get; set; }

        [StringLength(150)]
        public string AlternateEmailID { get; set; }

        public DateTime CreatedDate { get; set; }

        public long CreatedBy { get; set; }

        public DateTime? ModifiedDate { get; set; }

        [StringLength(50)]
        public string ModifiedBy { get; set; }

        public bool IsPinRegistered { get; set; }

        public bool IsDeleted { get; set; }

        [StringLength(1000)]
        public string AndroidRegistrationId { get; set; }

        [StringLength(100)]
        public string DistrictCode { get; set; }

        [StringLength(100)]
        public string DistrictName { get; set; }

        public bool? IsActive { get; set; }
    }
}
