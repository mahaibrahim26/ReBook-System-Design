from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from database import Base, engine, SessionLocal
import models

app = FastAPI(title="ReBook Mini API")

Base.metadata.create_all(bind=engine)


# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# --- Simple seed data on first run ---
@app.on_event("startup")
def seed_data():
    db = SessionLocal()
    if not db.query(models.User).first():
        # Create two users
        user1 = models.User(name="Jane", email="jane@gmail.com")
        user2 = models.User(name="John", email="john@gmail.com")

        # Create books owned by each
        book1 = models.Book(
            title="Pride and Prejudice",
            author="Jane Austen",
            owner=user1
        )
        book2 = models.Book(
            title="Animal Farm",
            author="George Orwell",
            owner=user2
        )

        db.add_all([user1, user2, book1, book2])
        db.commit()

    db.close()


# --- Endpoints ---

@app.get("/")
def home():
    return {"message": "ReBook API Running"}


@app.get("/books")
def get_books(db: Session = Depends(get_db)):
    """
    Return all books with owner info
    """
    books = db.query(models.Book).all()
    return [
        {
            "id": book.id,
            "title": book.title,
            "author": book.author,
            "owner": {"id": book.owner.id, "name": book.owner.name}
        }
        for book in books
    ]


@app.post("/exchange/request")
def send_request(name: str, db: Session = Depends(get_db)):
    book = db.query(models.Book).first()
    if not book:
        raise HTTPException(status_code=404, detail="No book available")
    exchange = models.Exchange(book=book, requester_name=name)
    db.add(exchange)
    db.commit()
    return {"message": f"Exchange request sent by {name}"}


@app.post("/exchange/accept")
def accept_request(db: Session = Depends(get_db)):
    exchange = db.query(models.Exchange).first()
    if not exchange:
        raise HTTPException(status_code=404, detail="No exchange to accept")
    exchange.status = "accepted"
    db.commit()
    return {"message": "Exchange accepted!"}


@app.get("/profile")
def profile(db: Session = Depends(get_db)):
    """
    Return profile for Jane (the logged-in user)
    """
    user = db.query(models.User).filter_by(name="Jane").first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return {
        "name": user.name,
        "email": user.email,
        "books": [
            {"title": book.title, "author": book.author}
            for book in user.books
        ],
    }
