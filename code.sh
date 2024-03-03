## Extracting Cosmic and novel information for individual tumor
mkdir /media/LUN4/prajish/exome/processed_data/Individual_tumor_old/Novel_cosmic/removed_3_dbs/
for f in $(find /media/LUN4/prajish/exome/processed_data/Individual_tumor_old/*exo.txt -name "*exo.txt" -type f ); 
do
  sample=$(basename $f);
	sample_name="${sample%.txt}"
awk -F'\t'  '{if($121 ~ /-/ && $257 ~ /-/ && $168 ~ /-/) print $0; 
              else if($121 !~ /-/ && $257 ~ /-/ && $168 ~ /-/) print $0;
              else if($121 !~ /-/ && $257 !~ /-/ && $168 ~ /-/) print $0;
              else if($121 !~ /-/ && $257 ~ /-/ && $168 !~ /-/) print $0;
              #else if($121 !~ /-/ && $257 !~ /-/ && $168 !~ /-/) print $0;
             }' < $f >> /media/LUN4/prajish/exome/processed_data/Individual_tumor_old/Novel_cosmic/removed_3_dbs/$sample_name"_novel_cosmic.txt"
done


###################################### Into cosmic and novel we make table of all types of mutations calculations
for f in $(find /media/LUN4/prajish/exome/processed_data/Individual_tumor_old/Novel_cosmic/removed_3_dbs/* -name "*.txt" -type f ); 
do
  sample=$(basename $f);
	sample_name="${sample%.*}"
awk -v file="$sample_name" -F'\t' 'BEGIN{missense=0; nonsense=0; nonstop=0; splice=0; threeutr=0; fiveflank=0; fiveutr=0; igr=0; intron=0; silent=0; DenovoStartInFrame=0; DenovoStartOutOfFrame=0; FrameShiftDel=0; FrameShiftIns=0; InFrameDel=0; InFrameIns=0; lincRNA=0; RNA=0; StartCodonDel=0; StartCodonIns=0; StartCodonSNP=0; StopCodonDel=0; StopCodonIns=0;} 
    {if($9 ~ "3" && $9 ~ "UTR") threeutr++;
    else if($9 ~ "5" && $9 ~ "Flank") fiveflank++;
    else if($9 ~ "5" && $9 ~ "UTR") fiveutr++;
    else if($9 == "IGR") igr++;
    else if($9 == "Intron") intron++;
    else if($9 == "De_novo_Start_InFrame") DenovoStartInFrame++;
    else if($9 == "De_novo_Start_OutOfFrame") DenovoStartOutOfFrame++;
    #else if($9 == "Non-coding_Transcript") noncoading++;
    else if($9 == "Frame_Shift_Del") FrameShiftDel++;
    else if($9 == "Frame_Shift_Ins") FrameShiftIns++;
    else if($9 == "In_Frame_Del") InFrameDel++;
    else if($9 == "In_Frame_Ins") InFrameIns++;
    else if($9 == "lincRNA") lincRNA++;
    else if($9 == "RNA") RNA++;
    else if($9 == "Start_Codon_Del") StartCodonDel++;
    else if($9 == "Start_Codon_Ins") StartCodonIns++;
    else if($9 == "Start_Codon_SNP") StartCodonSNP++;
    else if($9 == "Stop_Codon_Del") StopCodonDel++;
    else if($9 == "Stop_Codon_Ins") StopCodonIns++;
    else if($9 == "Missense_Mutation") missense++;
    else if($9 == "Nonsense_Mutation") nonsense++;
    else if($9 == "Nonstop_Mutation") nonstop++;
    else if($9 == "Silent") silent++;
    else if($9 == "Splice_Site") splice++;}
    END{print "Sample Name=""\t"file
    print "Total number of variants=""\t"missense+nonsense+nonstop+splice+threeutr+fiveflank+fiveutr+igr+intron+noncoading+silent+DenovoStartInFrame+DenovoStartOutOfFrame+FrameShiftDel+FrameShiftIns+InFrameDel+InFrameIns+lincRNA+RNA+StartCodonDel+StartCodonIns+StartCodonSNP+StopCodonDel+StopCodonIns;
    print "3UTR entries=""\t"threeutr;
    print "5Flank entries=""\t"fiveflank;
    print "5UTR entries=""\t"fiveutr;
    print "IGR entries=""\t"igr;
    print "Intron entries=""\t"intron;
    print "De_novo_Start_InF000rame entries=""\t"DenovoStartInFrame;
    print "De_novo_Start_OutOfFrame entries=""\t"DenovoStartOutOfFrame;
    #print "Non-coading transcript entries=""\t"noncoading;
    print "Frame_Shift_Del entries=""\t"FrameShiftDel;
    print "Frame_Shift_Ins entries=""\t"FrameShiftIns;
    print "In_Frame_Del entries=""\t"InFrameDel;
    print "In_Frame_Ins entries=""\t"InFrameIns;
    print "lincRNA entries=""\t"lincRNA;
    print "RNA entries=""\t"RNA;
    print "Start_Codon_Del entries=""\t"StartCodonDel;
    print "Start_Codon_Ins entries=""\t"StartCodonIns;
    print "Start_Codon_SNP entries=""\t"StartCodonSNP;
    print "Stop_Codon_Del entries=""\t"StopCodonDel;
    print "Stop_Codon_Ins entries=""\t"StopCodonIns;
    print "Missense mutation entries=""\t"missense;
    print "Nonsense mutation entries=""\t"nonsense;
    print "Nonstop entries=""\t"nonstop;
    print "Silent entries=""\t"silent;
    print "Splice entries=""\t"splice"\n"
    }' < $f >> /media/LUN4/prajish/exome/processed_data/Individual_tumor_old/Novel_cosmic/removed_3_dbs/Cosmic_novel_all_mutations.info
done