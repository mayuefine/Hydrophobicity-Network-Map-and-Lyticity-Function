#!/usr/bin/perl -w
use strict;

#my $in = "t.fa";
my $in = $ARGV[0];
open I, "<$in";
my $a;
my $name;
my %h = (
    A => "3.9", X => "29.5", Z => "-1.1", B => "25.6",
    F => "29.9", G => "0.0", C => "8.3", I => "22.4",
    L => "24.2", M => "16.3", P => "9.7", V => "14.4",
);

while(defined($a =<I>)){
    chomp($a);
    $a =~ s/\s//igm;
    if($a=~/>/){
        $a =~ s/>//igm;
        $name = $a.".txt";
    }else{
        my @aa = &gen($a,$name);
        open OUT, ">$name";
        my $len = @aa;
        my $i = 0;
        while($i < $len){
            print OUT $aa[$i],"\n";
            $i++;
        }
        close OUT;
    }
}
close I;

sub ca{
    my @as = @_;
    my $leng = @as;
    my $i = 0;
    my $temp;
    my $lii = 0;
    my $moin = "0";
    my $li_moin = "0";
    while($i < $leng){
        if($h{$as[$i]}){
            my $i3 = $i + 3;
            my $i4 = $i + 4;
            if($i3 < $leng){
                if($h{$as[$i3]}){
                    my $temh = $h{$as[$i]} + $h{$as[$i3]};
                    $lii = $lii + $temh;
                    my $x = $i + 1;
                    my $y = $i3 + 1;
                    $moin = $moin."+($x,$y)";
                    $li_moin = $li_moin.",".$temh;
                }
            }
            if($i4 < $leng){
                if($h{$as[$i4]}){
                    my $temh4 = $h{$as[$i]} + $h{$as[$i4]};
                    $lii = $lii + $temh4;
                    my $x = $i + 1;
                    my $y = $i4 + 1;
                    $moin = $moin."+($x,$y)";
                    $li_moin = $li_moin.",".$temh4;
                }
            }
        }
        $i++;
    }
    $moin =~ s/\A0\+//igm;
    $li_moin  =~ s/\A0\,//igm;
    return $lii, $moin, $li_moin;
}

sub gen{
    my @se = @_;
    my @seq1 = split(//,$se[0]);
    my $leng = @seq1;
    my $i = 0;
    my @re;
    my $mo;
    while($i < $leng){
        my @seq = @seq1;
        my $i4 = $i + 4;
        my $out = $se[1];
        if($i4 < $leng){
            $seq[$i] = "X";
            $seq[$i4] = "X";
            my ($li,$moi,$limo) = &ca(@seq);
            my $seq_out = join("",@seq);
            #$seq_out = $i.",".$seq_out.",".$li.",".$moi;
            $seq_out = $i.",".$seq_out.",".$li;
            $mo = $moi;
            push @re, $seq_out;
            $mo =~ s/\)/\n/igm;
            $mo =~ s/\(//igm;
            $mo =~ s/\+//igm;
            $out =~ s/\.txt/\_$i\.csv/igm;
            open OUT2, ">$out";
            print OUT2 "$mo";
            close OUT2;
            my $o2 = $out;
            $o2 =~ s/\.csv/\.fa\.csv/igm;
            my $seq_out2 = join("\n",@seq);
            open OU,">$o2";
            print OU "$seq_out2\n";
            close OU;
            my $o3 = $out;
            $o3 =~ s/\.csv/\.li\.csv/igm;
            $limo =~ s/,/\n/igm;
            open O,">$o3";
            print O "$limo\n";
            close O;
            system("Rscript hnm.R $out $o2 $o3");
            system("rm $out $o2 $o3");
        }
        $i++;
    }
    return @re;
}
