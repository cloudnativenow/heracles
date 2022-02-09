function construct(sample, output) {
	if (sample.match(/: .+/)){
		output['message'] = sample.match(/: (.+)/)[1];
	}
}
// Do not write code here