use Getopt::Long;

$result = GetOptions ("wav=s", \$wavfile, "outfile=s", \$outfile, "help", \&usage);

sub usage {
	print "\n$0 -wav <wav_file> -outfile <out_file> -help

This program reads in the specified wav file.  The sound data is translated
into a 4-bit Atari format that is dasm readible.  Two samples are encoded
into each byte of output.  A comment is placed every 256 bytes to denote
a new page in Atari ROM.

Note that the first of the two samples goes into the lower nibble.  This
works optimally in Atari code.  The first sample can be written directly to
AUDV0, since the register will strip off the higher 4 bits automatically.
Then the second sample can be written to AUDV0 after 4 LSRs.  This prevents
the need for temp variables and saves precious cycles during playback.

The asm data is written to the specified -outfile.  RIFF PCM header
information is written to STDOUT.

Currently only 8-bit PCM wav files are supported.\n";

	exit;
}

#$wavfile = shift;

if ($wavfile eq "") {
	die "ERROR: Must provide input wave file.\n";
}

open (WAV, $wavfile)
	or die "Could not open wavfile '$wavfile'.\n";

# Read ChunkID
read (WAV, $data, 4);
if ($data ne "RIFF") {
	die "ERROR: This doesn't appear to be a RIFF PCM WAV file.\n";
}
print "      ChunkID = $data\n";

# Read ChunkSize
read (WAV, $data, 4);
$data = unpack ("V1", $data);
print "    ChunkSize = $data\n";

# Read Format
read (WAV, $data, 4);
print "       Format = $data\n";
if ($data ne "WAVE") {
	die "ERROR: This is a RIFF file, but it doesn't appear to be a WAVE file.\n";
}

# Read Subchunk1ID
read (WAV, $data, 4);
print "  Subchunk1ID = $data\n";

# Read Subchunk1Size
read (WAV, $data, 4);
$data = unpack ("V1", $data);
print "Subchunk1Size = $data\n";

# Read AudioFormat
read (WAV, $data, 2);
$data = unpack ("v1", $data);
print "  AudioFormat = $data\n";

# Read NumChannels
read (WAV, $data, 2);
$data = unpack ("v1", $data);
print "  NumChannels = $data\n";

# Read SampleRate
read (WAV, $data, 4);
$data = unpack ("V1", $data);
print "   SampleRate = $data\n";

# Read ByteRate
read (WAV, $data, 4);
$data = unpack ("V1", $data);
print "     ByteRate = $data\n";

# Read BlockAlign
read (WAV, $data, 2);
$data = unpack ("v1", $data);
print "   BlockAlign = $data\n";

# Read BitsPerSample
read (WAV, $data, 2);
$data = unpack ("v1", $data);
print "BitsPerSample = $data\n";

# Read Subchunk2ID
read (WAV, $data, 4);
print "  Subchunk2ID = $data\n";

# Read Subchunk2Size
read (WAV, $data, 4);
$data = unpack ("V1", $data);
print "Subchunk2Size = $data\n";

# Read in all the data.

$data_byte_count = 0;
$page_count = 0;
$output = "";
while (read (WAV, $data, 2)) {
	@data = unpack ("C2", $data);

	if ($data_byte_count % 512 == 0) {
		$output .= "; Page $page_count\n";
		$page_count++;
	}

	# If there is an odd number of bytes in the sample, drop the last byte.
	if ($data[1] eq "") {
		print "Warning: last byte of sound data was ignored because this file\n";
		print "contains an odd number of sound bytes.\n";
		$data_byte_count++;
		last;
	}

	# Note, the first of the two bytes goes into the lower nibble.  This works
	# optimally in Atari code.  The first sample can be written directly to
	# AUDV0, since the register will strip off the higher 4 bits automatically.
	# Then the second sample can be written to AUDV0 after 4 LSRs.  This prevents
	# the need for temp variables and saves precious cycles during playback.

	#strip off the lower 4 bits.
	$lownibble = $data[0] >> 4;

	#shift 4 bits to the right, effectively stripping off the lower 4 bits.
	$highnibble = $data[1] & 240;

	$condensedbyte = $highnibble + $lownibble;
	$output .= sprintf ("	.byte #%%%08b\n", $condensedbyte);

	$data_byte_count += 2;
}

print "$data_byte_count bytes of sound data processed.\n";

close WAV;

open (OUTPUT, ">$outfile");
print OUTPUT $output;
close OUTPUT;
