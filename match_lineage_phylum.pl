use warnings;
my $f =$ARGV[0];
my $f1=$ARGV[1];
my $line;
my $line1;
my @array;
my @newarray;
my $v ='';
my %hash;
open (F,$f) or die "cannot open $f\n";
while ($line1 = <F>) {
chomp($line1);
@data3 = split(/\t/,$line1);
$data3[1] =~ s/p__//g;
$data3[0] =~ s/g__//g;
$hash{$data3[0]} = $data3[1]; #change

#print keys  %hash;
}
my $dat;
open (F1,$f1) or die "cannot open $f1\n";
while ($line = <F1>) {
chomp($line);
#next if ($line   =~ /^###.*$/);
if ($line =~ /^###.*$/){
#	print "$line\n";
}
@data1 = split(/\t/,$line);
$dat = $data1[0];
#$dat =~ s/.gff.fasta_DIR//g;
@data2 = "$dat";
#print @data2;
#<STDIN>;
#@data2 = <F1>;
foreach $key (@data2){
	#@lin = split(/\./,$l);
	#$key = "$lin[0]";
	#print $key;
	if (exists $hash{$key})
        {
	 #   print $headers;
	    #$data1[0] =~ s/\s+//g;
	    #print "$data1[1]";
            print  "$hash{$key}\t$data1[1]\n";
	    #<STDIN>;
	    #print  "$data3[0]";
        }
	else{
		#print "$data1[0]\t$key\tNA\t$data1[2]\t$data1[4]\n";
	}  
        }
} 
close(F1);

close(F);
