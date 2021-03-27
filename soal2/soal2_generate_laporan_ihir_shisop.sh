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
    if ($8=="Home Office") {
         seg1+=1
    }
    else if ($8=="Consumer") {
         seg2+=1
    }
    else if ($8=="Corporate") {
         seg3+=1
    }
}
END{
    if(seg1<seg2 && seg1<seg3){
        print "Tipe segmen customer yang penjualannya paling sedikit adalah Home Office dengan", seg1, "transaksi\n"
    }
    else if(seg2<seg1 && seg2<seg3){
        print "Tipe segmen customer yang penjualannya paling sedikit adalah Home Office dengan", seg2, "transaksi\n"
    }
    else if(seg3<seg1 && seg3<seg2){
        print "Tipe segmen customer yang penjualannya paling sedikit adalah Home Office dengan", seg3, "transaksi\n"
    }
}' /home/rizqi/Documents/shift1/Laporan-TokoShiSop.tsv >> hasil.txt

#2d
export LC_ALL=C
awk '
BEGIN{FS="\t"}{
    if ($13=="Central" || $13=="South" || $13=="East" || $13=="West"){
        reg[$13]+=$21
    }
}
END{
    profit=99999
    for(i in reg){
        if(profit>reg[i]){
            profit=reg[i]
            region=i
        }
    }
print "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah", region, "dengan total keuntungan", profit)}' /home/rizqi/Documents/shift1/Laporan-TokoShiSop.tsv >> hasil.txt
