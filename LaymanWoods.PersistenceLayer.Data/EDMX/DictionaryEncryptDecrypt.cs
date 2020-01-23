namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DictionaryEncryptDecrypt")]
    public partial class DictionaryEncryptDecrypt
    {
        [Key]
        [Column(Order = 0)]
        public int id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(5)]
        public string CharacterValue { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(5)]
        public string EncryptedValue { get; set; }
    }
}
