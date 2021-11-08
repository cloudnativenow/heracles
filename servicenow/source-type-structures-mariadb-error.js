function construct(sample, output) {
	var match = sample.match(/^([\d\-]+ +[\d:]+) (?:\d+ )?\[(\w+)\] (.+)/);
	if (match != null && match.length > 0) {
		output['timestamp'] = match[1].replace('  ',' 0');
		output['severity'] = match[2].replace('Note','Notice');
		output['message'] = match[3];
	}
}