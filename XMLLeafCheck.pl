
#! c:\perl\bin
use warnings;
use diagnostics;
use XML::Parser;
use XML::Simple;
use Data::Dumper;

#  Enter in Version as first argument
	$Version = $ARGV[0];

	if (! $Version)
	{
	printf "\<\n\nUSAGE:  Missing version i.e., 177 178 179...";
	exit;
	}

# Set the leaflet path
$SGML = "\\\\gmfileshare01\\multum-production\\ProdLeaflets\\Leaflets_v$Version\\SGML";

# Set up the path for leaflets
$PATH = "\\\\gmfileshare01\\multum-production\\ProdLeaflets\\Leaflets_v$Version\\SGML\\";

# Open up the XML directory and read into an array
opendir DIR, $SGML;
@refArray = readdir DIR;
shift @refArray; #remove "."
shift @refArray; #remove ".."

foreach my $filename (@refArray) {

my $parser = XML::Parser->new(ErrorContext => 2 );
eval { $parser->parsefile($PATH.$filename); };

	if( $@ ) {
    		$@ =~ s/at \/.*?$//s;               # remove module line number
		print "\nERROR in '$filename':\n$@\n";
    		#print STDERR "\nERROR in '$filename':\n$@\n";
	} else {
    		#print STDERR "'$filename' is well-formed\n";
		#print "'$filename' is well-formed:\n$@\n";
		print "'$filename' is well-formed:\n$@";
	}


} # end foreach

close(DIR);
