use warnings;
mkdir "/media/LUN4/prajish/exome/processed_data/GATK_SNP_INDEL_MUTECT_merge/";

###################For paired sample
opendir DIR,"/media/LUN4/prajish/exome/processed_data/GATK/paired/SNP/corrected_SNP/T-N_snp/coverage_5x_filter_snp/chr_start_end_ref_alt_snp/";
@files=grep(/\.vcf/,readdir(DIR));

map{
$SNP=$_;
$SNP=~s/_T-N_5x_filtered.vcf//g;
chomp($SNP);
$filename1=$SNP."_T-N_5x_filtered.vcf";
$filename2=$SNP."_T-N_5x_filtered.vcf";
$filename3=$SNP."T_fxd_sorted_DupRm_realn_recal.mutect_5_fields.txt";
$filename4=$SNP.".txt";

$command1="(sed '1d' /media/LUN4/prajish/exome/processed_data/GATK/paired/SNP/corrected_SNP/T-N_snp/coverage_5x_filter_snp/chr_start_end_ref_alt_snp/$filename1; sed '1d' /media/LUN4/prajish/exome/processed_data/GATK/paired/Indel/corrected_Indel/T-N_indels/coverage_5x_filter_Indel/chr_start_end_ref_alt_indel/$filename2; cat /media/LUN4/prajish/exome/processed_data/mutect/keep_old/$filename3;)| sort | uniq > /media/LUN4/prajish/exome/processed_data/GATK_SNP_INDEL_MUTECT_merge/$filename4";

system($command1);
$command2="sed -i '1ichr\tstart\tend\tref_allele\talt_allele' /media/LUN4/prajish/exome/processed_data/GATK_SNP_INDEL_MUTECT_merge/$filename4";
system($command2);
}@files;

#system("bash /run/media/adlab/Data3/Nilesh_Pavan_TSCC_data/Exome/oncotator.sh");
###################For unpaired sample

opendir DIR,"/media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/T-N_snp/coverage_5x_filter_snp/chr_start_end_ref_alt_snp/";
@files=grep(/\.vcf/,readdir(DIR));

map{
$SNP=$_;
$SNP=~s/_T-N_5x_filtered.vcf//g;
chomp($SNP);
$filename1=$SNP."_T-N_5x_filtered.vcf";
$filename2=$SNP."_T-N_5x_filtered.vcf";
$filename3=$SNP."T_fxd_sorted_DupRm_realn_recal.mutect_5_fields.txt";
$filename4=$SNP.".txt";

$command1="(sed '1d' /media/LUN4/prajish/exome/processed_data/GATK/unpaired/SNP/corrected_SNP/T-N_snp/coverage_5x_filter_snp/chr_start_end_ref_alt_snp/$filename1; sed '1d' /media/LUN4/prajish/exome/processed_data/GATK/unpaired/Indel/corrected_Indel/T-N_indels/coverage_5x_filter_Indel/chr_start_end_ref_alt_indel/$filename2; cat /media/LUN4/prajish/exome/processed_data/mutect/keep_old/unpaired/T-N_MuTECT/$filename3;)| sort | uniq > /media/LUN4/prajish/exome/processed_data/GATK_SNP_INDEL_MUTECT_merge/$filename4";

system($command1);
$command2="sed -i '1ichr\tstart\tend\tref_allele\talt_allele' /media/LUN4/prajish/exome/processed_data/GATK_SNP_INDEL_MUTECT_merge/$filename4";
system($command2);
}@files;
             
                