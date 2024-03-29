const fs = require("fs");
const path = require("path");

const examples = JSON.parse(fs.readFileSync(__dirname + path.sep + "examples.json").toString());
let result = "# API\n\n## Table of contents\n";
const data = fs
	.readFileSync("init.lua")
	.toString()
	.split("\n")
	.map(l => l.trim())
	.filter(l => l.match(/^-{3}|(?:pt|mt):/) || !l)
	.reduce((prev, l) => (prev[prev.length - 1] !== l && prev.push(l), prev), [])
	.reduce((prev, l) => (!l && prev.push([]), prev[prev.length - 1].push(l), prev), [])
	.filter(item => item[item.length - 1].startsWith("function"))
	.map(item => item
		.filter(l => l)
		.map(l => l.replace(/^-+\s+/, ""))
		.reduce((prev, l) => (l.startsWith("function") || l.startsWith("@") || !prev.length ? prev.push(l) : prev[prev.length - 1] = prev[prev.length - 1] + " " + l, prev), [])
	)
	.map(item => ({
		name: item[item.length - 1].match(/^function\s+(?:mt|pt):(\w+)/)[1],
		desc: item[0],
		generics: item.filter(l => l.match(/^@generic/)).map(l => l.match(/^@generic\s+(\w+)\s+(.+)/)?.filter((v, i) => 1 <= i && i <= 2)).filter(item => item),
		params: item.filter(l => l.match(/^@param/)).map(l => l.match(/^@param\s+(\w+\??)\s+(fun\(.+?\)\s*(?::\s*\w+)?|\w+)\s+(.+)/)?.filter((v, i) => 1 <= i && i <= 3)).filter(item => item),
		returns: item.filter(l => l.match(/^@return/)).map(l => l.match(/^@return\s+(\w+\??)\s+(fun\(.+?\)\s*(?::\s*\w+)?|\w+)\s+(.+)/)?.filter((v, i) => 1 <= i && i <= 3)).filter(item => item)
	}))
	.sort((a, b) => a.name < b.name ? -1 : 1);
for (const item of data)
	result += `- [${item.name}](#${item.name})\n`;
for (const item of data) {
	const generics = item.generics.map(generic => `\`${generic[0]}\` - ${generic[1]}`).join("\n\n");
	const params = item.params.map(param => `\`${param[0]}\` \`${param[1]}\` - ${param[2]}`).join("\n\n");
	const returns = item.returns.map(returns => `\`${returns[0]}\` - ${returns[2]}`).join("\n\n");
	result += `\n## ${item.name}\n${item.desc}${generics ? `\n\n**Generics**\n\n${generics}` : ""}${params ? `\n\n**Parameters**\n\n${params}` : ""}${returns ? `\n\n**Returns**\n\n${returns}` : ""}\n\n\`\`\`lua\n${examples[item.name]}\n\`\`\`\n`;
}
fs.writeFileSync(__dirname + path.sep + "api.md", result);
