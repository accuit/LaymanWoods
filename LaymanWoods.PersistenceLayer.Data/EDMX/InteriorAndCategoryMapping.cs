namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("InteriorAndCategoryMapping")]
    public partial class InteriorAndCategoryMapping
    {
        [Key]
        public int ID { get; set; }
        [Required]
        public int InteriorID { get; set; }
        [Required]
        [StringLength(50)]
        public string CategoryCode { get; set; }
        public int? ProductID { get; set; }
        public decimal? Multiplier { get; set; }
        public decimal? Divisor { get; set; }
        public DateTime CreatedDate { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? ModifiedBy { get; set; }
        public bool IsDeleted { get; set; }
        public bool IsDefault { get; set; }
        public int WebPartType { get; set; }
        public bool isMultiSelect { get; set; }

    }
}
