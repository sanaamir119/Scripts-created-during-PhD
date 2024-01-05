`source /home/project/anaconda3/etc/profile.d/conda.csh`;
`conda activate py37`;
use warnings;
my $fastadat='';
my $string='';
my @string = ();
my @blast = ();
my $f2 = $ARGV[0];
open(OT,">$f2\_blast.out.csv") or die "cannot write '$f2\_blast.out'\n";
open(OT1,">$f2\_blast_ali.out.txt") or die "cannot write '$f2\_blast_ali.out'\n";
open(FASTA,$f2) or die "cannot open $f2\n";
while($fastadat=<FASTA>)
{
	if ($fastadat =~ m/>/)
        {

                 $string = $string.$fastadat;
                        push(@string, $string);
        }
}
if  (scalar@string == 1)
        {
	#`echo "query acc.ver\tsubject acc.ver\t% identity\talignment length\tmismatches\tgap opens\tq. start\tq. end\ts. start\ts. end\tevalue\tbit score" >$f2\_blast.out`;
	my $blast_out_a = `blastp -query $f2 -db database_name_test -outfmt 6 -max_target_seqs 10`;
	my $blast_out_new = `blastp -query $f2 -db database_name_test -outfmt 0 -max_target_seqs 10`;
	print OT1 $blast_out_new;
#	print $blast_out_a;
	 #$blast_out_a = `blastp -query $f2 -db database_name_test -outfmt 0 -num_alignments 10 -max_target_seqs 10`;
	 @blast_new = split (/\n>/, $blast_out_new);
	shift @blast_new;
	#print $blast_new[0];
	@blast  = split (/\n/, $blast_out_a);
	#my @ali_out = split (/(?=^Query=)/m, $blast_out_a); ## (?=pattern) is a positive look ahead assertion
	print OT "query acc.ver,subject acc.ver,% identity,alignment length,q. start,q. end,evalue\n";
	#print "$blast_out[0],$blast_out[1],$blast_out[2],$blast_out[3],$blast_out[6],$blast_out[7],$blast_out[10]\n";
}
	foreach my $k (@blast){
	my @blast_out = split (/\t/, $k);
	print OT "$blast_out[0],$blast_out[1],$blast_out[2],$blast_out[3],$blast_out[6],$blast_out[7],$blast_out[10]\n";
	}
	foreach my $l (@blast_new){
#	print OT1 $l;
	}
exit;
