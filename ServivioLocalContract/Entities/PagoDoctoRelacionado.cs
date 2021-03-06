using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace ServicioLocalContract.Entities
{
    [Serializable()]
   public class PagoDoctoRelacionado
    {
        [DataMemberAttribute]
        public string ID { get; set; }
          
           [DataMemberAttribute]
           public string IdDocumento { get; set; }
           [DataMemberAttribute]
           public string Serie { get; set; }
           [DataMemberAttribute]
           public string Folio { get; set; }
           [DataMemberAttribute]
           public string MonedaDR { get; set; }
           [DataMemberAttribute]
           public string TipoCambioDR { get; set; }
           [DataMemberAttribute]
           public string MetodoDePagoDR { get; set; }
           [DataMemberAttribute]
           public string NumParcialidad { get; set; }
           [DataMemberAttribute]
           public string ImpSaldoAnt { get; set; }
           [DataMemberAttribute]
           public string ImpPagado { get; set; }
           [DataMemberAttribute]
           public string ImpSaldoInsoluto { get; set; }
         
    }

}
