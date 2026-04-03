const regex = /\b\w+\b/g;
const pages = dv.pages();

const WORDCOUNT_ERROR = (file) => `
	Failed to get wordcount for "${file}"!
	Check console (Ctrl + Shift + I) for more details.
`;

const getLastUpdated = (mtime) => {
	let now = new Date();
	const diff = (now-mtime) / (1000);
	if (diff <= 60) return `${Math.round(diff)} seconds ago`;
	if (diff <= 3600) return `${Math.round(diff/60)} minutes ago`;
	if (diff <= 86400) return `${Math.round(diff/3600)} hours ago`;
	return `${Math.round(diff/86400)} days ago`;
}


let wordCount = new Map();

for (let i = 0; i < pages.length; i++) {
	const name = pages[i].file.name;
	if (name === dv.current().file.name) continue;
	const text = await dv.io.load(pages[i].file.path);

	try {
		const pageWordCount = text.match(regex).length;
		wordCount.set(name, pageWordCount);
	}
	catch (e) {
		// Case where the DataView query fails to get wordcount for specific page
		if (e.name === "TypeError") {
			console.log(e);
			throw new Error(WORDCOUNT_ERROR(pages[i].file.path));
		}
		throw e;
	}
}

const table = dv.markdownTable(["Links", "Last Updated", "Word Count", "Size"],
  pages
    .sort(f => wordCount.get(f.file.name), 'desc')
    .filter(f => f.file.name !== dv.current().file.name)
    .map(f => [
	  `[[${f.file.path}|${f.file.frontmatter.title}]]`,
	  getLastUpdated(f.file.mtime),
	  wordCount.get(f.file.name),
	  f.file.size >= 1000 ?
	    `${(f.file.size / 1000).toFixed(1)} KiB` : `${f.file.size} B`
	])
);

dv.paragraph(table);
