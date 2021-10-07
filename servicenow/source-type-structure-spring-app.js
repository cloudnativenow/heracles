function construct(sample, output) {
    var match = sample.match(/ \[(.+?)\] (\S+) +: (.+)([\s\S]*)/);
    if (match != null && match.length > 0) {
        output['thread'] = match[1];
        output['class'] = match[2];
        output['message'] = match[3];
        if (match[4].length > 1) output['stacktrace'] = match[4];
        // extract the actual nested exception/message that was written with Chaos:
        if (output['message'].startsWith('Servlet.service()') && output['message'].match(/threw exception \[.+\] with root cause/)) {
            output['message'] = output['message'].match(/\[Request processing failed; nested exception is (\S+: .+)\] with root cause/)[1];
        } else if (sample.match('nested exception is')) {
            output['message'] = sample.match(/nested exception is (.+)/)[1];
        } else if (sample.match(/threw exception\n+\S+:/)) {
            output['message'] = sample.match(/threw exception\n+(\S+: .+)/)[1];
        }
    }
}