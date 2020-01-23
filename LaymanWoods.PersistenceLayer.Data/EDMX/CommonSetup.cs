namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CommonSetup")]
    public partial class CommonSetup
    {
        public int CommonSetupID { get; set; }

        [StringLength(200)]
        public string MainType { get; set; }

        [StringLength(200)]
        public string SubType { get; set; }

        [StringLength(200)]
        public string DisplayText { get; set; }

        public byte? DisplayValue { get; set; }

        public int? ParentID { get; set; }

        public bool IsDeleted { get; set; }

        public DateTime CreatedDate { get; set; }

        public DateTime? ModifiedDate { get; set; }

        public int? CompanyID { get; set; }

        [StringLength(200)]
        public string Description { get; set; }
    }
}
