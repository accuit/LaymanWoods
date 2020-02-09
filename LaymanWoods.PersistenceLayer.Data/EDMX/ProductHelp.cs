using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    [Table("ProductHelp")]
    public partial class ProductHelp
    {
        [Key]
        public int ID { get; set; }

        [Required]
        [StringLength(50)]
        public string Title { get; set; }

        public int ProductID { get; set; }

        public string ImageUrl { get; set; }

        public string Description { get; set; }
        public string AdditionalInfo { get; set; }
        public string Specification { get; set; }

        public DateTime CreatedDate { get; set; }

        public int CreatedBy { get; set; }

        public DateTime? ModifiedDate { get; set; }

        public int? ModifiedBy { get; set; }

        public bool IsDeleted { get; set; }

        public int? CategoryID { get; set; }

        public int CompanyID { get; set; }

    }
}
