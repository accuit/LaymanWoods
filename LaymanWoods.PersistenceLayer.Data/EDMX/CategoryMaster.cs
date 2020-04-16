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
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CategoryMaster()
        {
            ProductHelps = new HashSet<ProductHelp>();
            ProductMasters = new HashSet<ProductMaster>();
        }

        [Key]
        public int CategoryID { get; set; }

        [Required]
        [StringLength(32)]
        public string CategoryName { get; set; }

        [Required]
        [StringLength(50)]
        public string CategoryCode { get; set; }
        [StringLength(150)]
        public string Title { get; set; }
        public int? CompanyID { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProductHelp> ProductHelps { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProductMaster> ProductMasters { get; set; }
    }
}
