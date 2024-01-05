use warnings;
use Tie::IxHash;
my $f = $ARGV[0];
my $f1=$ARGV[1];
my $line;
my $line1;
my @array;
my @newarray;
my $v ='';
my %hash;
my %new_id;
my %tt;
open(F,$f) or die "cannot open";
open(OT,">log.txt") or die "cannot write log.txt \n";
@data = <F>;
foreach my $l (@data){
$hash{$l} = 1;
}
close (F);

open (F1,$f1) or die "cannot open $f1\n";
#open (OT,">$f1.result") or die "cannot write\n";
while ($fasta = <F1>){
chomp($fasta);
my @fasta = split(/\t/,$fasta);
push (@array,"$fasta[0]\t$fasta[1]");
push (@phylum , $fasta[0]);
push (@{$tt{$fasta[0]}},$fasta[1]);
}
@uniq_phylum = uniq(@phylum);
#print scalar@aray;
#print @values;
foreach $user (sort keys %tt){
	#print "$user\t ".scalar(@{$tt{$user}}).",\n";
	push (@plot,"$user,");
	my %count;
	foreach my $l (sort @{$tt{$user}}) {
	 $count{$l}++;
	}
	foreach my $keys (sort keys %count){
        push (@plot,"$keys:$count{$keys},");
	}
	push (@plot,"\n");
}
#print @plot;
my $tmp = join("",@plot);
print OT $tmp;
close(F1);

`perl make_column_forbar.pl $f log.txt > plot_new.csv`;


sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}
