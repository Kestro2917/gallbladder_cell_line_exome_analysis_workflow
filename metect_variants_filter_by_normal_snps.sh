#######Filtering based on 4 fields for SNPs############################################################################
mkdir /media/LUN4/prajish/exome/processed_data/mutect/filtered/unpiared/T-N_MuTECT/
for file in $(find /media/LUN4/prajish/exome/processed_data/mutect/filtered/unpiared/* -type f -name "*.txt") ; 
do
	vcf_filename_with_extn=$(basename $file) ;
	#vcf_filename_without_extn="${vcf_filename_with_extn%T_SNP*}" ;
	#dir=$(dirname $file) ;
	#outputdir=$dir"/T-N" ; 
	
	awk 'NR==FNR {Ar[$1$2$4$5] ++ ; next} ! (($1$2$4$5) in Ar)' <(cat /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Normal/SNP/corrected_SNP/selected_uniq_SNP.txt) $file >>  /media/LUN4/prajish/exome/processed_data/mutect/filtered/unpiared/T-N_MuTECT/$vcf_filename_with_extn ;
done;