namespace LaymanWoods.PersistenceLayer.Data.EDMX
{ 
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Email
    {
        public long ID { get; set; }

        public int CompanyID { get; set; }

        public int? UserID { get; set; }

        public int? TemplateID { get; set; }

        [StringLength(100)]
        public string FirstName { get; set; }

        [StringLength(50)]
        public string LastName { get; set; }

        [StringLength(20)]
        public string Mobile { get; set; }

        [StringLength(150)]
        public string EmailAddress { get; set; }

        [StringLength(1500)]
        public string Message { get; set; }

        public int Status { get; set; }

        public int? ProductID { get; set; }

        [StringLength(300)]
        public string Address { get; set; }

        [StringLength(30)]
        public string Pincode { get; set; }

        public DateTime CreatedDate { get; set; }
    }
}
