using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;

namespace SANTSG.Web.Models
{
    public class RezervationCard
    {
        public RezervationCard()
        {

            //Operator.TourOperators.Add(new TourOperator("AMOR", "AMOR REISE GMBH"));
            //Operator.TourOperators.Add(new TourOperator("ARES", "ARES TRAVEL"));
        }

        public TourOperator Operator { get; set; }
        public int VoucherNo { get; set; }
        private object Customers { get; set; }

    }

    public class TourOperator
    {
        public TourOperator(string code, string name)
        {
            Code = code;
            Name = name;
        }
        public string Code { get; set; }
        public string Name { get; set; }
    }
}
