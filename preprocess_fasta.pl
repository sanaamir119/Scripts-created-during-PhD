use warnings;
my $dir = $ARGV[1];
open(FH,"$dir/$ARGV[0]") || die "Can't open the file $ARGV[0]\n";
while(<FH>)
{
        chomp;
        if(/^>/)
        {
                chomp;
                my $line = $_;
                my @tm = split(/\s+/, $line);
                @tm1 = split(/\|/, $tm[0]);
                my $header = ">".$tm1[-1];
                $header =~ s/>>/>/;
                print ">ORF\n";

        }else
        {
                print "$_\n";
        }

}
exit;
