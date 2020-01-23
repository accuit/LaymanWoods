namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CategoryMaster")]
    public partial class CategoryMaster
    {
        [Key]
        public int CategoryID { get; set; }

        [Required]
        [StringLength(32)]
        public string CategoryName { get; set; }

        [Required]
        [StringLength(50)]
        public string CategoryCode { get; set; }

        public int? CompanyID { get; set; }
    }
}
