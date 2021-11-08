function construct(sample, output) {
	var match = sample.match(/^(\d+\/\d+\/\d+ [\d:]+) \[(\w+)\] (\d+)#(\d+): (?:\*(\d+) )?(.+)/);
	if (match != null && match.length > 0) {
		output['timestamp'] = match[1];
		output['severity'] = match[2];
		output['pid'] = match[3];
		output['tid'] = match[4];
		if (match[5]) output['cid'] = match[5];
		var text = match[6];

		var parts = text.split(/, (\w+): /);
		// before entering the loop, we need to make sure that parts[0] is a key
		if (parts[0] == '') parts.shift();
		else output['message'] = parts.shift();
		while (parts.length > 0) {
		// we assign the key and the value to variables in order to allow further manipulation if needed
			var key = parts.shift(),
				value = parts.shift();
			output[key] = value.trim().replace(/^"|"$/g,'');
		}	
	}
}