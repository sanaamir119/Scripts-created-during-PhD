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
#$data3[2] =~ s/p__//g;
$hash{$data3[1]} = $data3[0]; #change

}
open (F1,$f1) or die "cannot open $f1\n";
while ($line = <F1>) {
chomp($line);

@data1 = split(/\t/,$line);
@data2 = "$data1[1]";
foreach $key (@data2){
if (exists $hash{$key})
        {
	my $count =  sprintf ("%.2f",($data1[0]/$hash{$key}));
	if ($count >= 0.5){
	print  "$data1[1]\t$data1[2]:100\n";
	}
        if ($count < 0.5){
                print "$data1[1]\t$data1[2]:50\n";
        }
        }
}
}
close(F1);

close(F);
