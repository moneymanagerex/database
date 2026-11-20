const test = require("node:test");
const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");
const { execFileSync } = require("node:child_process");

test("PocketBase business fields match the SQLite schema", () => {
  const root = path.resolve(__dirname, "..");
  const sql = fs.readFileSync(path.join(root, "tables.sql"), "utf8");
  const schema = JSON.parse(fs.readFileSync(path.join(root, "pocketbase/schema-import.json"), "utf8"));
  const query = `SELECT m.name AS tbl, p.name AS col, p.type AS type
    FROM sqlite_master m, pragma_table_info(m.name) p
    WHERE m.type = 'table' AND m.name NOT LIKE 'sqlite_%';`;
  const rows = JSON.parse(execFileSync("sqlite3", ["-json", ":memory:"], { input: `${sql}\n${query}` }));
  const tables = [...new Set(rows.map(row => row.tbl))].sort();
  const audit = new Set(["created", "updated"]);
  assert.deepEqual(schema.map(collection => collection.name).filter(name => name !== "dbInfo").sort(), tables);
  const auditIds = [];
  for (const collection of schema) {
    const names = collection.fields.map(field => field.name);
    assert.deepEqual(names.filter(name => audit.has(name)).sort(), [...audit].sort(), `${collection.name} audit fields`);
    for (const field of collection.fields.filter(item => audit.has(item.name))) {
      assert.equal(field.type, "autodate", `${collection.name}.${field.name} type`);
      assert.equal(field.system, true, `${collection.name}.${field.name} must be a system field`);
      assert.match(field.id, /^[a-z0-9]{15}$/, `${collection.name}.${field.name} id`);
      auditIds.push(field.id);
    }
  }
  assert.equal(new Set(auditIds).size, auditIds.length, "audit field ids must be unique");
  const byName = new Map(schema.map(collection => [collection.name, collection]));
  for (const name of tables) {
    const created = byName.get(name).fields.find(field => field.name === "created");
    const updated = byName.get(name).fields.find(field => field.name === "updated");
    assert.equal(created.onCreate, true, `${name}.created onCreate`);
    assert.equal(created.onUpdate, false, `${name}.created onUpdate`);
    assert.equal(updated.onCreate, true, `${name}.updated onCreate`);
    assert.equal(updated.onUpdate, true, `${name}.updated onUpdate`);
  }
  for (const name of tables) {
    const fields = schema.find(collection => collection.name === name).fields;
    const columns = rows.filter(row => row.tbl === name);
    assert.deepEqual(fields.map(field => field.name).filter(field => !audit.has(field)).sort(), columns.map(column => column.col).sort(), name);
    for (const column of columns) {
      const field = fields.find(item => item.name === column.col);
      const type = column.type.toUpperCase();
      assert.ok(["TEXT", "INTEGER", "NUMERIC"].includes(type), `${name}.${column.col}: unknown SQLite type ${type}`);
      assert.equal(field.type, type === "TEXT" ? "text" : "number", `${name}.${column.col}`);
      if (type === "INTEGER") assert.equal(field.onlyInt, true, `${name}.${column.col}`);
    }
  }
});
