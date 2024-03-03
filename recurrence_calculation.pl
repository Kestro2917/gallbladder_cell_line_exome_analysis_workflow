use strict;
opendir DIR,"/media/LUN4/prajish/exome/processed_data/Recurrence_analysis_exome/GATK_recal_mutect_ori/";
open F3,">/media/LUN4/prajish/exome/processed_data/Recurrence_analysis_exome/GATK_recal_mutect_ori/recurrent_data_with_sample_names.out";
#mkdir("/media/LUN1/NIlesh_analysis/Exome/MuTECT/filtered");
my @files = grep(/\.txt/,readdir(DIR));
my %hash1=();
map{
my $code=$_;
open F1,"/media/LUN4/prajish/exome/processed_data/Recurrence_analysis_exome/GATK_recal_mutect_ori/$code";
my @arr=<F1>; close(F1);
foreach my $line(@arr){
        chomp($line);
        my @array=split("\t",$line);
        push(@{$hash1{$array[0]}},$array[1]);
          }
}@files;

foreach(keys(%hash1)){
                      local $"=",";
      print F3 "$_\t@{$hash1{$_}}\n";
}