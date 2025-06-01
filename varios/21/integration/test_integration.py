import pytest
import os
from app import UserDB

@pytest.fixture(scope="session")
def db():
    # Configuramos la conexión para los tests
    db = UserDB(os.getenv('DATABASE_URL', 'postgresql://postgres:postgres@localhost:5432/testdb'))
    db.setup_database()
    return db

def test_user_creation(db):
    # Limpiamos cualquier usuario previo
    db.delete_user("testuser")
    
    # Creamos un nuevo usuario
    user = db.add_user("testuser", "test@example.com")
    
    assert user["username"] == "testuser"
    assert user["email"] == "test@example.com"
    assert "id" in user
    assert "created_at" in user

def test_user_retrieval(db):
    # Primero creamos un usuario
    db.add_user("retrievaltest", "retrieval@test.com")
    
    # Luego lo recuperamos
    user = db.get_user("retrievaltest")
    
    assert user is not None
    assert user["username"] == "retrievaltest"
    assert user["email"] == "retrieval@test.com"

def test_user_deletion(db):
    # Primero creamos un usuario
    db.add_user("deletetest", "delete@test.com")
    
    # Verificamos que existe
    assert db.get_user("deletetest") is not None
    
    # Lo eliminamos
    assert db.delete_user("deletetest") is True
    
    # Verificamos que ya no existe
    assert db.get_user("deletetest") is None 