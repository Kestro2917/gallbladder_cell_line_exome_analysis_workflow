###############################Comma removal perl script for SNP and Indel##################################################################
perl /media/LUN4/prajish/exome/processed_data/GATK/unpaired/comma_removal_tumor.pl

#######Filtering based on 4 fields for SNPs############################################################################
mkdir /media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/T-N_snp/
for file in $(find /media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/* -type f -name "*T_fxd_sorted_DupRm_realn_recal_variantannotator_SNP.vcf") ; 
do
	vcf_filename_with_extn=$(basename $file) ;
	vcf_filename_without_extn="${vcf_filename_with_extn%T_fxd_sorted_DupRm_realn_recal_variantannotator_SNP*}" ;
	#dir=$(dirname $file) ;
	#outputdir=$dir"/T-N" ; 
	
	awk 'NR==FNR {Ar[$1$2$4$5] ++ ; next} ! (($1$2$4$5) in Ar)' <(cat /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Normal/SNP/corrected_SNP/merge_all_no_hash_5_columns_selected_tab_to_underscore_sort_uniq_again_underscore_tab.txt) $file >>  /media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/T-N_snp/$vcf_filename_without_extn"_T-N.vcf" ;
done;



#######Filtering based on 4 fields for Indel ############################################################################
mkdir /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/T-N_indels/
for file in $(find /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/* -type f -name "*T_fxd_sorted_DupRm_realn_recal_INDEL.vcf") ; 
do
	vcf_filename_with_extn=$(basename $file) ;
	vcf_filename_without_extn="${vcf_filename_with_extn%T_fxd_sorted_DupRm_realn_recal_INDEL.vcf}" ;
	#dir=$(dirname $file) ;
	#outputdir=$dir"/T-N" ; 
	
 awk 'NR==FNR {Ar[$1$2$4$5] ++ ; next} ! (($1$2$4$5) in Ar)' <(cat /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Normal/Indel/corrected_Indel/merge_all_no_hash_5_columns_selected_tab_to_underscore_sort_uniq_again_underscore_tab.txt) /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/$vcf_filename_without_extn"T_fxd_sorted_DupRm_realn_recal_INDEL.vcf" >>  /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/T-N_indels/$vcf_filename_without_extn"_T-N.vcf" ;
done;


##########################5X filter for SNP###################################################################
#!/bin/bash
mkdir /media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/T-N_snp/coverage_5x_filter_snp
for file in $(find /media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/T-N_snp/* -type f -name "*.vcf") ; 
do
vcf_filename_with_extn=$(basename $file) ;
#vcf_filename=$(basename "$1")
vcf_base_name="${vcf_filename_with_extn%_T-N*}"
alt_base_depth=5

	cat $file | while read LINE 
	do 
		if echo $LINE | grep -Eq '^#'
		then
				continue;
        #echo $LINE >> $vcf_base_name"_"$alt_base_depth"x_filtered.vcf"
		else
				
				echo $LINE | awk -v alt_base_count="$alt_base_depth" -v line="$LINE" '{split($10,a,":|,");if(a[3]>=alt_base_count) print line;}' >> /media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/T-N_snp/coverage_5x_filter_snp/$vcf_base_name"_T-N_"$alt_base_depth"x_filtered.vcf"

		fi
	done
	echo "Completed!!! Output File generated as $vcf_base_name"_T-N_"$alt_base_depth"x_filtered.vcf""

done;


##########################5X filter for Indel###################################################################
#!/bin/bash
mkdir /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/T-N_indels/coverage_5x_filter_Indel
for file in $(find /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/T-N_indels/* -type f -name "*.vcf") ; 
do
vcf_filename_with_extn=$(basename $file) ;
vcf_filename=$(basename "$1")
vcf_base_name="${vcf_filename_with_extn%.*}"
alt_base_depth=5

  cat $file | while read LINE 
	do 
		if echo $LINE | grep -Eq '^#'
		then
				continue;
        #echo $LINE >> $vcf_base_name"_"$alt_base_depth"x_filtered.vcf"
		else
				
				echo $LINE | awk -v alt_base_count="$alt_base_depth" -v line="$LINE" '{split($10,a,":|,");if(a[3]>=alt_base_count) print line;}' >> /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/T-N_indels/coverage_5x_filter_Indel/$vcf_base_name"_"$alt_base_depth"x_filtered.vcf"

	fi
	done
	echo "Completed!!! Output File generated as $vcf_base_name"_"$alt_base_depth"x_filtered.vcf""

done;

echo "Analysis of filtering completed!!!!!"


#################Extracting 5 fields from filtered file (chr_start_end_ref_alt) for SNP######################################

mkdir /media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/T-N_snp/coverage_5x_filter_snp/chr_start_end_ref_alt_snp/
for file in $(find /media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/T-N_snp/coverage_5x_filter_snp/* -type f -name "*.vcf") ; 
do
vcf_filename_with_extn=$(basename $file) ;
vcf_base_name="${vcf_filename_with_extn%.*}"
awk 'BEGIN { print "chr","\t","start","\t","end","\t","ref_allele","\t","alt_allele"} { print $1,"\t",$2,"\t",$3=length($4)+$2-1,"\t",$4,"\t",$5 }' $file | sed 's/ //g' >> /media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/T-N_snp/coverage_5x_filter_snp/chr_start_end_ref_alt_snp/$vcf_base_name".vcf" 
done;

#################Extracting 5 fields from filtered file (chr_start_end_ref_alt) for INDEL#########################################
mkdir /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/T-N_indels/coverage_5x_filter_Indel/chr_start_end_ref_alt_indel/
for file in $(find /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/T-N_indels/coverage_5x_filter_Indel/* -type f -name "*.vcf") ; 
do
vcf_filename_with_extn=$(basename $file) ;
vcf_base_name="${vcf_filename_with_extn%.*}"
awk 'BEGIN { print "chr","\t","start","\t","end","\t","ref_allele","\t","alt_allele"} { print $1,"\t",$2,"\t",$3=length($4)+$2-1,"\t",$4,"\t",$5 }' $file | sed 's/ //g' >> /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/T-N_indels/coverage_5x_filter_Indel/chr_start_end_ref_alt_indel/$vcf_base_name".vcf" 
done;














