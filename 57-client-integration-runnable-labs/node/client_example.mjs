import pg from 'pg';
const { Client } = pg;
const client = new Client({ connectionString: process.env.DATABASE_URL });
await client.connect();
try {
  await client.query('BEGIN');
  await client.query('CREATE TEMP TABLE client_lab(id integer PRIMARY KEY, name text NOT NULL)');
  await client.query('INSERT INTO client_lab VALUES ($1, $2)', [1, 'alpha']);
  const result = await client.query('SELECT id, name FROM client_lab WHERE id = $1', [1]);
  console.log(result.rows[0]);
  await client.query('COMMIT');
} catch (error) {
  await client.query('ROLLBACK');
  throw error;
} finally {
  await client.end();
}
