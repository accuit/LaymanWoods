namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("InteriorCategory")]
    public partial class InteriorCategory
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public InteriorCategory()
        {
            InteriorProducts = new HashSet<InteriorProduct>();
        }

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
        public bool IsDeleted { get; set; }
        public int? CompanyID { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InteriorProduct> InteriorProducts { get; set; }
    }
}
