const { resolve } = require("path");
const { readdir } = require("fs").promises;
const fs = require("fs");
const path = require("path");
const readline = require("readline");
const { exit } = require("process");

function readUserInput(question) {
  const readlineInterface = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  return new Promise((resolve, _reject) => {
    readlineInterface.question(question, (answer) => {
      resolve(answer);
      readlineInterface.close();
    });
  });
}

async function* getFiles(dir) {
  const dirents = await readdir(dir, { withFileTypes: true });
  for (const dirent of dirents) {
    const res = resolve(dir, dirent.name);
    if (dirent.isDirectory()) {
      yield* getFiles(res);
    } else {
      yield res;
    }
  }
}

(async () => {
  const wpPort = await readUserInput(
    "Enter WordPress Web port number (default 80): "
  );
  const dbPort = await readUserInput(
    "Enter Database port number (default 33060): "
  );

  const projectName = path.basename(path.resolve(__dirname, ".."));
  const databaseName = projectName.replace(/[-\.]/g, "_");

  const replacements = {
    project_name: projectName,
    wordpress_port: wpPort ? wpPort : "80",
    wordpress_port_with_colon: wpPort ? `:${wpPort}` : "",
    database_name: databaseName,
    database_port: dbPort ? dbPort : "33060",
  };

  for await (const f of getFiles(".")) {
    if (f.includes(".wpstemplate")) {
      for (const [placeholder, to] of Object.entries(replacements)) {
        const content = fs.readFileSync(f, "utf8");
        var re = new RegExp(`{{${placeholder}}}`, "g");
        const replaced = content.replace(re, to);
        fs.writeFileSync(f, replaced, "utf8");
      }
      const newFilename = f.replace(".wpstemplate", "");
      fs.renameSync(f, newFilename);

      if (path.basename(newFilename) === ".env.example") {
        const envFilename = path.join(path.dirname(f), ".env");
        fs.copyFileSync(newFilename, envFilename);
      }
    }
  }
})();
