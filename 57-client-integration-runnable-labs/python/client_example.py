import os
import psycopg

with psycopg.connect(os.environ['DATABASE_URL']) as conn:
    with conn.cursor() as cur:
        cur.execute('CREATE TEMP TABLE client_lab(id integer PRIMARY KEY, name text NOT NULL)')
        cur.execute('INSERT INTO client_lab VALUES (%s, %s)', (1, 'alpha'))
        cur.execute('SELECT id, name FROM client_lab WHERE id = %s', (1,))
        print(cur.fetchone())
