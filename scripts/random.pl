#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use File::Compare;
use File::Basename;
use File::Find;

use lib qw( /home/sdasgup3/x86-semantics/scripts/ );
use kutils;

my $file= "";

GetOptions( 
    "file"   => \$file,
    )
  or die("Error in command line arguments\n");

my @corpus64 = (
0, #0d,64,53,11)
9223372036854775808, #-0d, #64,53,11)
-9223372036854775808, #-0d, #64,53,11)
4593671619917905920, #0.125d, #64,53,11)
4598175219545276416, #0.25d, #64,53,11)
4602678819172646912, #0.5d, #64,53,11)
4607182418800017408, #1d, #64,53,11)
4611686018427387904, #2d, #64,53,11)
4616189618054758400, #4d, #64,53,11)
4620693217682128896, #8d, #64,53,11)
4600427019358961664, #0.375d, #64,53,11)
4604930618986332160, #0.75d, #64,53,11)
4609434218613702656, #1.5d, #64,53,11)
4613937818241073152, #3d, #64,53,11)
4618441417868443648, #6d, #64,53,11)
4591870180174331904, #0.10000000149011612d, # 64,53,11)
4596373779801702400, #0.20000000298023224d, #64,53,11)
4600877379429072896, #0.40000000596046448d, #64,53,11)
4605380979056443392, #0.80000001192092896d, #64,53,11)
4786511204606541824, #999999995904d, #64,53,11)
4965913770435018752, #1.0000000138484279e+24d, # 64,53,11)
5145383438148173824, #9.9999996169031625e+35d, #64,53,11)
9218868437227405312, #Infinityd, #64,53,11)
-4503599627370496, #-Infinityd, #64,53,11)
18442240474082181120, #-Infinityd, #64,53,11)
-4611686018427387904, #-2d, #64,53,11)
13835058055282163712, #-2d, #64,53,11)
4627730092099895296, #25d, #64,53,11)
5183643170565550134, #3.402823466E+38d, #64,53,11)
4039728865745034152, #1.17549435E-38d, #64,53,11)
4614256656748876136, #3.1415927410d, #64,53,11)
4599676419421066575, #0.333333333333333d, #64,53,11)
4623156123728347136, #12.375d, #64,53,11)
4634494146896484893, #68.123d, #64,53,11)
4503599627370496,    # 2.2250738585072014E-308d, #64,53,11)
9227875636482146304, #-2.2250738585072014E-308d, #64,53,11)
-9218868437227405312, #-2.2250738585072014E-308d, #64,53,11)
9007199254740991, #4.4501477170144023E-308d, #64,53,11)
9232379236109516799, #-4.4501477170144023E-308d, #64,53,11)
-9214364837600034817, #-4.4501477170144023E-308d, #64,53,11)
9227875636482146303, #-2.225073858507201E-308d, #64,53,11)
-9218868437227405313, #-2.225073858507201E-308d, #64,53,11)
9218868437227405311, #1.7976931348623157E308d, #64,53,11) 
9214364837600034816, #8.98846567431158E307d, #64,53,11)
2251799813685248, #1.1125369292536007E-308d, #64,53,11)
9216616637413720064, #1.348269851146737E308d, #64,53,11)
"9218868437227405311", #max
"-4503599627370497", #-max
"1",
"9223372036854775809", # - min
"9218868437227405312", #inf
"-4503599627370496", #-inf
"18446744073709551615" #NaN
"9209861237972664319" # this will make sd->ss yirld +inf
    );


my @corpus = (
"2147483648",
"1036831949",
"1045220557",
"1053609165",
"1061997773",
"1399379109",
"1733542428",
"2067830734",
"2139095040",
"4286578688",
"4286578688",
"2139095039",
"8388608",
"1078530011",
"1051372203",
"1095106560",
"1116225274",
"3225419776",
"1073741825",
"3221225473",
"4194304",
"2151677953",
"2139095039",
"4286578687",
"8388607",
"2155872255",
"8388608",
"12582912",
"16777215",
"2139095039", #max
"4286578687", #-max
"1",
"2147483649", # - min
"2139095040", #inf
"4286578688", #-inf
"2147483647" #NaN
    );

#movq \$ARG1, %rax
#movq \$ARG2, %rbx
#  movq %rax, %xmm0
#  movq %rbx, %xmm1
#  mulps  %xmm0, %xmm1
my $template = qq(
  movq \$ARG1, %rax
  movq %rax, %xmm0
  cvtsd2ss  %xmm0, %xmm1
  cvtss2sd %xmm1, %xmm0
);

for my $line1 (@corpus64) {

#for my $line2 (@corpus) {

    my $r1 = $template =~ s/ARG1/$line1/gr;
    my $r2  = $r1 =~ s/ARG2/$line1/gr;
    print $r2. "\n";

# }
}

my @corpus2 = (
"0",           #0
"2147483648", #-0
"16777215", # a num
"2139095039", #max
"4286578687", #-max
"1",
"2147483649", # - min
"2139095040", #inf
"4286578688", #-inf
"2147483647" #NaN
    );

#for my $line1 (@corpus2) {
#  for my $line2 (@corpus2) {
#
#    my $r1 = $template =~ s/ARG1/$line1/gr;
#    my $r2  = $r1 =~ s/ARG2/$line2/gr;
#    print $r2. "\n";
#
#}
#}

