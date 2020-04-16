namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("InteriorProducts")]
    public partial class InteriorProduct
    {
        [Key]
        public int ID { get; set; }
        [Required]
        [StringLength(50)]
        public string Name { get; set; }
        [Required]
        [StringLength(100)]
        public string Title { get; set; }

        [StringLength(1500)]
        public string Image { get; set; }
        public int InteriorCategoryID { get; set; }
        public int Type { get; set; }
        public bool IsDeleted { get; set; }
        public int? CompanyID { get; set; }
        public virtual InteriorCategory InteriorCategory { get; set; }

    }
}
