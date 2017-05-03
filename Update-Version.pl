#!perl -w
$config_file_path = "E:\\Jenkins\\Config\\Version.txt";
ParseConfigFile($config_file_path);
sub ParseConfigFile 
{
	local ($config_line);
	($File) = @_;
	if (!open (CONFIG, "$File"))
	{
		print "ERROR: Config file not found : $File";
		exit(0);
	}
	while (<CONFIG>) 
	{
    	$config_line=$_;
	    chomp ($config_line);
		$config_line =~ s/^\s*//;
	    $config_line =~ s/\s*$//;
    	if ( ($config_line !~ /^#/) && ($config_line ne "") )
		{
    		($Baseline) = ($config_line);
		}
	}
	close(CONFIG);
}
if (!$Baseline eq "")
		{
			my @SplitBaseline = split(/\./,$Baseline);
			my $NEXTBUILDLETTER = ++$SplitBaseline[3];
			$NextBuild = "$SplitBaseline[0]\.$SplitBaseline[1]\.$SplitBaseline[2]\.$NEXTBUILDLETTER";	
			print $NextBuild;
			open(INFO, ">$config_file_path") or die "Can't open '$config_file_path': $!";
			print INFO "$NextBuild";
		}	
		else
		{
		print "end of script"
		}
