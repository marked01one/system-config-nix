const path = dv.current().file.path;

try {
  // Extract all headers from the given file
	const headers = (await dv.io.load(path))
		.match(/^(#{2,3}\s.+)$/gm)
		.map(r => ({
			level: r.split(" ")[0].length-1,
			title: r.split(" ").slice(1).join(" ")
		}));
	// Initialize payload and counter
	let payload = [];
	let count = 1, i = 0;
	// Assume 1st header will always be the highest (i.e., level == 1)
	while (i < headers.length) {
		let payload = [[`${count}. [[#${headers[i].title}]]`]];
		let k = 1; i++;
		while (i < headers.length && headers[i].level !== 1) {
			payload.push([`${count}.${k}. [[#${headers[i].title}]]`]);
			i++; k++;
		}
		dv.paragraph(dv.markdownTable(payload[0], payload.slice(1)));
		count++;
  }
}
catch (e) {
	dv.paragraph(`Error loading file '${path}': ${e.message}`);
	console.error(`DataviewJS Error: Could not load file '${path}'`, e);
}
