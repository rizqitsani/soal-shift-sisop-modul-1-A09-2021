#!/bin/bash

#2a
export LC_ALL=C
awk '
BEGIN{FS="\t"}{
    ProfitPercentage=(($21/($18-$21))*100)
    if (ProfitPercentage>=ProfitMax){
        ProfitMax=ProfitPercentage
        RowID=$1
    }
}
END{
    print "Transaksi terakhir dengan profit percentage terbesar yaitu", RowID, "dengan persentase", ProfitMax, "%\n"}' /home/rizqi/Documents/shift1/Laporan-TokoShiSop.tsv >> hasil.txt

#2b
export LC_ALL=C
awk '
BEGIN{FS="\t"}{
    if ($2~"2017" && ($10=="Albuquerque")){
        CstName[$7]++
    }
}
END{
    print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:"
    for (i in CstName){
        print i
    }
}' /home/rizqi/Documents/shift1/Laporan-TokoShiSop.tsv >> hasil.txt

#2c
awk '
BEGIN{FS="\t"}{
    if (1!=NR){
        Segment[$8]+=1
    }
}
END{
    SalesMinimum=4000
    for (bidang in Segment){
        if (SalesMinimum > Segment[bidang]){
            SalesMinimum = Segment[bidang]
            SalesMinimum = bidang
        }
    }
print "\nTipe segmen customer yang penjualannya paling sedikit adalah", bidang, "dengan", Segment[bidang], "transaksi\n"}' /home/rizqi/Documents/shift1/Laporan-TokoShiSop.tsv >> hasil.txt

#2d
export LC_ALL=C
awk '
BEGIN{FS="\t"}{
    if (1!=NR){
        region[$13]=$21 + region[$13]
    }
}
END{
    ProfitMinimum=4000
    for (daerah in region){
        if (ProfitMinimum > region[daerah]){
            ProfitMinimum = region[daerah]
            ProfitMinimum = daerah
        }
    }
print "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah", daerah, "dengan total keuntungan", region[daerah]}' /home/rizqi/Documents/shift1/Laporan-TokoShiSop.tsv >> hasil.txt
