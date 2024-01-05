use warnings;
my $f = $ARGV[0];
my $k = $f;
$k =~ s/^.*\///g;
#print $k;
#print $f;
my $dir =$ARGV[1];
my $fastadat = '';
my $line;
open(FH,$f) or die  "cannot open $f \n";
my $first = 1;
my $end = -1;
while (<FH>){
	if ($first){
	$first = 0;
	}
	if ($end){
        $end = 0;
        }
	else{
	$fastadat .= $_;
	}
}
close(FH);
my @fastadat = split(/\n+/,$fastadat);
shift@fastadat;
pop@fastadat;
#print "$fastadat[0]\n";
open(OT1,">$dir/$k\_tmp") or die "caanot write 'tmp_msaindexing' \n";
foreach my $k (@fastadat)
{
	my @tm = split(/\s+/,$k);
	push (@in,"$tm[1]\n");
	push (@tmp,"$tm[0]\t$tm[1]\n");
}
my $index = shift@in;
#print $index;
my @index = split(//,$index);
for (my $i=0; $i<scalar@index;$i++){
print OT1 "$i";
}
print OT1 "\n";
print OT1 @tmp;
open(OT,">$dir/$k\_linked_residues") or die "caanot open 'linked_residues' \n";
foreach my $l (@tmp){
	($a,$b) = split(/\t/,$l);
	print OT "$a\t";
	my @res = split(//,$b);
	my $c = $b;
	$c =~ s/-//g;
	my @res1 = split(//,$c);
for (my $i=0; $i<scalar@res;$i++){
	$j = $i+1;
	if ($res[$i] =~ /C/)
	{
		print OT "CYS-$j,";
	}
	if ($res[$i] =~ /S/)
	{
		print OT "Ser-$j,";
	}
	 if ($res[$i] =~ /T/)
        {
                print OT "Thr-$j,";
        }
	if ($res[$i] =~ /-/)
        {
                print OT "gap-$j,";
        }
}
print OT "\t";
for (my $i=0; $i<scalar@res1;$i++){
        $j = $i+1;
        if ($res[$i] =~ /C/)
        {
                print OT "CYS-$j,";
        }
        if ($res[$i] =~ /S/)
        {
                print OT "Ser-$j,";
        }
         if ($res[$i] =~ /T/)
        {
                print OT "Thr-$j,";
        }
        if ($res[$i] =~ /-/)
        {
                print OT "gap-$j,";
        }
}
print OT "\n";
}
`python data_matching.py $dir/$k\_linked_residues > $dir/$k\_linked_residues_output`;
#`perl test_linked_residues.pl $dir/$k\_linked_residues $dir  > $dir/$k\_linked_residues_output.txt`;
`perl test_linked_residues.pl $dir/$k\_linked_residues`;
#`sort $dir/$k\_linked_residues_output.txt | uniq -c > $dir/$k\_linked_residues_count`;
exit; 
