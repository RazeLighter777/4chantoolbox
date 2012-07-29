#!/usr/bin/perl -w

## Written by LAMMJohnson
## If something goes wrong, it's your fault so eat shit.

use LWP::Simple;
use strict;

while () {
    my $lasttime = time();
    my $URL = get( $ARGV[0] );

    print "Page $ARGV[0] downloaded. Processing images.\n";
    my @images = ($URL =~ m/\/\/images\.4chan\.org\/[a-zA-Z]\/src\/[0-9]{13}\.(?:jpg|png|gif|jpeg)/ig);

    print $URL;

    for my $image (@images) {

        my $imagename = $image;
        $imagename =~ s/^.*\///;

        if (-e $imagename) {
            print "File \'$imagename\' exists. Skipping.\n";
        }
        else {
            print "Getting $image\n";
            getstore("http:" . $image, $imagename);
        }
    }

    my $looptime = time() - $lasttime;
    $lasttime = time();
    if ($looptime < 10) {
        print "Finished early. Sleeping for " . (10 - $looptime) . " seconds.\n";
        sleep (10 - $looptime);
    }
}
