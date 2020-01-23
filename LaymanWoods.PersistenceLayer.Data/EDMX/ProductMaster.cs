namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ProductMaster")]
    public partial class ProductMaster
    {
        [Key]
        public int ProductID { get; set; }

        public int? CompanyID { get; set; }

        [Required]
        [StringLength(50)]
        public string ProductTypeCode { get; set; }

        [Required]
        [StringLength(50)]
        public string ProductTypeName { get; set; }

        [Required]
        [StringLength(50)]
        public string ProductGroupCode { get; set; }

        [Required]
        [StringLength(50)]
        public string ProductGroupName { get; set; }

        [Required]
        [StringLength(50)]
        public string CategoryCode { get; set; }

        [Required]
        [StringLength(50)]
        public string CategoryName { get; set; }

        [Required]
        [StringLength(50)]
        public string BasicModelCode { get; set; }

        [Required]
        [StringLength(50)]
        public string BasicModelName { get; set; }

        [StringLength(50)]
        public string SKUCode { get; set; }

        [StringLength(50)]
        public string SKUName { get; set; }

        public decimal? MRP { get; set; }

        public decimal? DealerPrice { get; set; }

        public DateTime CreatedDate { get; set; }

        public int CreatedBy { get; set; }

        public DateTime? ModifiedDate { get; set; }

        [StringLength(50)]
        public string ModifiedBy { get; set; }

        public bool IsDeleted { get; set; }

        public bool IsActive { get; set; }
    }
}
