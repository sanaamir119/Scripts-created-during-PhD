use warnings;
#open the file where multi fasta are stored
my $f=$ARGV[0];
my $dir=$ARGV[1];
my $fheader = '';
unless(-d $dir){
`rm -rf $dir`;
`mkdir $dir`;
}
open(FASTA,$f)or die "cannot open $f\n";	#8JUN2021
open(OT2, ">$dir/contig_original_name.txt") or die "cannot write to header.txt";
#create a string variable;
my $fastadat='';
my %fastah=();
#run while loop and concatenate everything to $seq
while(<FASTA>)
{
        $fastadat .= $_;
}

#close filehandle
close(FASTA);
my @fastadat = split(/\n>/,$fastadat);
#print $fastadat[0];
#exit;
my $count =0;
foreach my $d(@fastadat)
{
	my @tm = split(/\n+/, $d);
	#if ($d =~ m/
	$fheader = shift@tm;
	#print $fheader;
	$fheader =~ s/>//g;
	#$fheader =~ s/\s+//g;
	my @head_file = $fheader;
	#print OT "@head_file\n";

	#my @fheader = split(/\s/,$fheader);
	#my $header = $fheader[0];
	#$header = s/\s//g;
	#print $header;
	my $fseq = join("\n",@tm);
	$fastah{$fheader} = $fseq;
	foreach my $l(@head_file)
	{
	$count++;
	print OT2 "contig\_$count.fna\t$fheader\n";		##8jun2021
	open (OT, ">$dir/contig\_$count.fna") or die "cannot write $l";
	print OT ">ORF\n$fastah{$fheader}\n";
	}
	
}
	
exit;
