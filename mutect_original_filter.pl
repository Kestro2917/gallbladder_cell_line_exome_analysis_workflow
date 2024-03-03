#use warnings;
opendir DIR,"/media/LUN4/prajish/exome/processed_data/mutect/";
mkdir("/media/LUN4/prajish/exome/processed_data/mutect/filtered");
@files = grep(/\.txt/,readdir(DIR));
#@files=grep(-f,readdir(DIR));
#shift(@files);
#shift(@files);

map{
$code=$_;
$code=~s/\.txt//g;
open F1,"/media/LUN4/prajish/exome/processed_data/mutect/$code.txt";
open F3,">/media/LUN4/prajish/exome/processed_data/mutect/filtered/$code"."_5_fields".".txt";
#undef $/;
@arr1=<F1>;

if($arr1[0] eq "##MuTect:1.1.6-4-g69b7a37 Gatk:3.1-0-g72492bb\n")
	{
		foreach $line(@arr1)
		{
			#shift(@arr1);
			#shift(@arr1);
			@array=split("\t",$line);
			if($array[50] =~ /KEEP/)
			{
					if($array[38]==0 && (($array[25]+$array[26])>=5))
					{
						if($array[25]==0)
						{
						print F3 $array[0]."\t".$array[1]."\t".$array[1]."\t".$array[3]."\t".$array[4],"\n";
						}
		
						else
						{
							if(($array[26]/$array[25])>=0.2)
							{
							#print F3 $array[3],"\n";
							print F3 $array[0]."\t".$array[1]."\t".$array[1]."\t".$array[3]."\t".$array[4],"\n";
							}
							}
					}
					#print F3 $array[3],"\n";
					#print F3 $array[0]."\t".$array[1]."\t".$array[1]."\t".$array[2]."\t".$array[3],"\n";
					
				
		  }
		}
	}

}@files;