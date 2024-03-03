#######Filtering based on 4 fields for SNPs############################################################################
mkdir /media/LUN4/prajish/exome/processed_data/mutect/keep_old/unpaired/T-N_MuTECT/
for file in $(find /media/LUN4/prajish/exome/processed_data/mutect/keep_old/unpaired/* -type f -name "*.txt") ; 
do
	vcf_filename_with_extn=$(basename $file) ;
	#vcf_filename_without_extn="${vcf_filename_with_extn%T_SNP*}" ;
	#dir=$(dirname $file) ;
	#outputdir=$dir"/T-N" ; 
	
	awk 'NR==FNR {Ar[$1$2$4$5] ++ ; next} ! (($1$2$4$5) in Ar)' <(cat /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Normal/SNP/corrected_SNP/merge_all_no_hash_5_columns_selected_tab_to_underscore_sort_uniq_again_underscore_tab.txt) $file >>  /media/LUN4/prajish/exome/processed_data/mutect/keep_old/unpaired/T-N_MuTECT/$vcf_filename_with_extn ;
done;