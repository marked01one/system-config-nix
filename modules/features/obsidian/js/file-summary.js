const regex = /\b\w+\b/g;
const pg = dv.current().file;
const size = pg.size;
const text = await dv.io.load(pg.path);

dv.paragraph(dv.markdownTable(["Name", "Word Count", "File Size"], [[
  pg.frontmatter.title,
  text.match(regex).length,
  (size >= 1000) ? `${(size / 1000).toFixed(1)} KiB` : `${size} B`
]]))
