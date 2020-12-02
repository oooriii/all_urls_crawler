#! /usr/bin/perl

use LWP::Simple;

use strict;

our $url = "https://babel.udg.edu/";

our @todo = [];
#our @done = [];
our %done = {};

our $pat = "<a.*href=\"(.*?)\"";


todo($url);


sub todo{
    my $uri = shift;

    print "$uri ->";
    if($uri =~ /^\//){
      $uri = $url.$uri;
    }
    my $c1 = get ($uri);

    my @matches = $c1 =~ /$pat/g;
    my $i = 0;
    foreach my $m (@matches){
      chomp($m);
      #print "$m\n";
      if($i > 0){
        #print "**** $m\n";
        if($m =~ /^https?:\/\/babel.udg.edu|^\//){

          if(! exists_arr($m)){
            $done{$m}=1;
            todo($m);
          }
        }
        if($m =~ /^https?:\/\/www[23]\.udg\.edu/){
          print "\n\t\tEPPPP : $m\";
        }
        if(! exists_arr($m)){
          $done{$m}=1;
        }
        #last;
      }
      $i++;

    }

}

#use Data::Dumper;
#print Dumper(%done);

print "\n\nALL URLS:\n";

foreach my $uu (keys %done){
  print "$uu\n";
}


sub exists_arr{
  my $val = shift;

  if($done{$val}){
    return 1;
  }

  return 0;

}
