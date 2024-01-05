use warnings;
#open the file where multi fasta are stored
my $f=$ARGV[0];
my $dir = $ARGV[1];
open(FASTA,"$dir/$f")or die "cannot open $f\n";
#open(OT, ">$outfile") or die "cannot write to header.txt";
#create a string variable;
my $fastadat='';
my $string='';
my %fastah=();
#run while loop and concatenate everything to $seq
while($fastadat=<FASTA>)
{
#	$fastadat=~ s/\s+//;
if ($fastadat =~ m/>/)
	{
		
		 $string = $string.$fastadat;
			push(@string, $string);
	}
}
#push (@string,$string);
#print @string;
#print scalar@string."\n";

if (scalar@string == 1)
	{
	# print "NO only one fasta\n";
	`perl preprocess_fasta.input.pl $f $dir > $dir/Genome_input.fasta`;
      	}
else {
	`perl create_fastafile.pl $f $dir`;
}

exit;
