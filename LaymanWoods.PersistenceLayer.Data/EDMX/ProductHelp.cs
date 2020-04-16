using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    [Table("ProductHelp")]
    public partial class ProductHelp
    {
        public int ID { get; set; }

        public int? ProductID { get; set; }

        [Required]
        [StringLength(150)]
        public string Title { get; set; }

        [StringLength(1000)]
        public string ImageUrl { get; set; }

        [Required]
        public string Description { get; set; }

        [StringLength(1000)]
        public string AdditionalInfo { get; set; }

        public string Specification { get; set; }

        public DateTime CreatedDate { get; set; }

        public int CreatedBy { get; set; }

        public DateTime? ModifiedDate { get; set; }

        public int? ModifiedBy { get; set; }

        public bool IsDeleted { get; set; }

        public int CompanyID { get; set; }

        public int? CategoryID { get; set; }

        [StringLength(50)]
        public string CategoryCode { get; set; }

        public virtual CategoryMaster CategoryMaster { get; set; }

        public virtual ProductMaster ProductMaster { get; set; }
    }
}

