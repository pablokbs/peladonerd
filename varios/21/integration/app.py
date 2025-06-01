import os
import psycopg2
from psycopg2.extras import RealDictCursor

class UserDB:
    def __init__(self, connection_string=None):
        if connection_string is None:
            connection_string = os.getenv('DATABASE_URL', 'postgresql://postgres:postgres@localhost:5432/testdb')
        self.connection_string = connection_string

    def connect(self):
        return psycopg2.connect(self.connection_string)

    def setup_database(self):
        with self.connect() as conn:
            with conn.cursor() as cur:
                cur.execute("""
                    CREATE TABLE IF NOT EXISTS users (
                        id SERIAL PRIMARY KEY,
                        username VARCHAR(100) UNIQUE NOT NULL,
                        email VARCHAR(255) UNIQUE NOT NULL,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                    )
                """)
                conn.commit()

    def add_user(self, username, email):
        with self.connect() as conn:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                cur.execute("""
                    INSERT INTO users (username, email)
                    VALUES (%s, %s)
                    RETURNING id, username, email, created_at
                """, (username, email))
                conn.commit()
                return cur.fetchone()

    def get_user(self, username):
        with self.connect() as conn:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                cur.execute("SELECT * FROM users WHERE username = %s", (username,))
                return cur.fetchone()

    def delete_user(self, username):
        with self.connect() as conn:
            with conn.cursor() as cur:
                cur.execute("DELETE FROM users WHERE username = %s", (username,))
                conn.commit()
                return cur.rowcount > 0 