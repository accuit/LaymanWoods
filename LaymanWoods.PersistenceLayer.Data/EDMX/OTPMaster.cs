namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("OTPMaster")]
    public partial class OTPMaster
    {
        public long OTPMasterID { get; set; }

        public long UserID { get; set; }

        [StringLength(500)]
        public string GUID { get; set; }

        [StringLength(20)]
        public string OTP { get; set; }

        public DateTime CreatedDate { get; set; }

        public int? Attempts { get; set; }
    }
}
