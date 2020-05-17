namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ContactEnquiry")]
    public partial class ContactEnquiry
    {
        public long ID { get; set; }

        [Required]
        [StringLength(50)]
        public string Name { get; set; }

        [Required]
        [StringLength(100)]
        public string Email { get; set; }

        [Required]
        [StringLength(15)]
        public string Mobile { get; set; }

        [StringLength(1000)]
        public string Message { get; set; }

        [StringLength(300)]
        public string Address { get; set; }

        [StringLength(100)]
        public string City { get; set; }

        [StringLength(10)]
        public string Pincode { get; set; }

        public int? Status { get; set; }

        public int CompanyID { get; set; }
        public DateTime CreatedDate { get; set; }
    }
}
