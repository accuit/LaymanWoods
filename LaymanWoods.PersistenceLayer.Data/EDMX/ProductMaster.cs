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

        [Required]
        [StringLength(50)]
        public string Name { get; set; }

        [Required]
        [StringLength(150)]
        public string Title { get; set; }

        [Required]
        [StringLength(1000)]
        public string ImageUrl { get; set; }

        [Required]
        [StringLength(10)]
        public string CategoryCode { get; set; }

        [StringLength(50)]
        public string BasicModelCode { get; set; }

        [StringLength(100)]
        public string BasicModelName { get; set; }

        public int Color { get; set; }

        [StringLength(50)]
        public string SKUCode { get; set; }

        [StringLength(50)]
        public string SKUName { get; set; }

        public decimal? MRP { get; set; }

        public DateTime CreatedDate { get; set; }

        public int CreatedBy { get; set; }

        public DateTime? ModifiedDate { get; set; }

        [StringLength(50)]
        public string ModifiedBy { get; set; }

        public bool IsDeleted { get; set; }

        public bool IsActive { get; set; }

        public int CategoryID { get; set; }

        public int CompanyID { get; set; }

        public int? MeasurementUnit { get; set; }

        public virtual CategoryMaster CategoryMaster { get; set; }
    }
}
