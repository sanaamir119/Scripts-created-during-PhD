use warnings;
my $count = $ARGV[0];
my $file = $ARGV[1];
my $dir = $ARGV[2];
#print $count;
my $line = '';
open(ENZ,"$dir/$count") || die "Can't Open The File 'biosynth_enzym_info'\n";
my %enzyh = ();
while($line = <ENZ>)
{
        chomp($line);
        my @tm = split(/\t/,$line);
        $enzyh{$tm[0]} = $tm[2];
	#print $tm[2];
}
close(ENZ);
foreach my $keys (keys %enzyh){
#print "KEYSSSSS\t$keys\t$enzyh{$keys}\n";
}
open(FH1,"$dir/$file") || die "Can't find the fasta file $ARGV[0]\n";
my $dat ='';
my $lastheader ='';
my $firstheader ='';
my $c=0;
while(<FH1>)
{
        $dat .= $_;
        $c++;
        if(/^>/)
        {
                $lastheader =$_;
        }
        if($c == 1)
        {
                $firstheader =$_;
        }
}
close(FH1);
my %ripp_orfsh = ();
my @data = split(/>/, $dat);
shift@data;
chomp($lastheader);
chomp($firstheader);
my @lasthead = split(/:/,$lastheader);
my @firsthead = split(/:/,$firstheader);
my $range = $lasthead[2] - $firsthead[1];
print "LOCUS       NC_XXXXXX              $range bp    DNA     CON 11-JAN-2019\n";
print "FEATURES             Location/Qualifiers\n";
print "     source          1..$range\n";
print "                     /organism=\"NA\"\n";
print "                     /mol_type=\"genomic DNA\"\n";
print "                     /db_xref=\"taxon:XX\"\n";
my $firsthead=0;
for(my $i=0; $i<scalar@data; $i++)      #Array of Fasta Sequence
{
        my @tm = split(/\n+/, $data[$i]);
        my $header = $tm[0];
        my @head = split(/:/, $header);
        my $orfcounter = $i+1;
        my $orf_ky = $head[0];
        $head[0] = 'ORF_'.$orfcounter;
        if($i == 0)
        {
                $firsthead= $head[1];
        }
        $head[1] = $head[1] - $firsthead +1;
        $head[2] = $head[2] - $firsthead +1;
        shift@tm;
        my $seq = join("",@tm);
        if($head[3] == 1)
        {
                print "     gene            $head[1]..$head[2]\n";
        }elsif($head[3] == -1)
        {
                print "     gene            complement($head[1]..$head[2])\n";
        }
        print "                     /locus_tag=\"$head[0]\"\n";
        if($head[3] == 1)
        {
                print "     CDS             $head[1]..$head[2]\n";
        }elsif($head[3] == -1)
        {
                print "     CDS             complement($head[1]..$head[2])\n";
        }
        $seq = '/translation='.$seq;
        print "                     /locus_tag=\"$head[0]\"\n";
        if(exists $enzyh{$orf_ky})
        {
                print "                     /product=\"$enzyh{$orf_ky}\"\n";
        }
	else
        {
                print "                     /product=\"UNKNOWN\"\n";
        }
        $seq = make_formatted_seq($seq);
        print "                     $seq\n";
}
print "CONTIG      join(TMP:1..$lasthead[2])\n";
print "//\n";

exit;
sub make_formatted_seq
{
        my ($seq) = @_;
        my @seq = split(//, $seq);
        my $count=0;
        my $returnseq ='';
        for(my $i=0; $i<scalar@seq; $i++)
        {
                $count++;
                if($count == 58)
                {
                        $count=0;
                        $returnseq .= "$seq[$i]\n                     ";
                }else
                {
                        $returnseq .= $seq[$i];
                }
        }
        return $returnseq;
}

