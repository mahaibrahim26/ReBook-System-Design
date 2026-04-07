from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from database import Base


class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    name = Column(String)
    email = Column(String)
    books = relationship("Book", back_populates="owner")


class Book(Base):
    __tablename__ = "books"
    id = Column(Integer, primary_key=True)
    title = Column(String)
    author = Column(String)
    owner_id = Column(Integer, ForeignKey("users.id"))
    owner = relationship("User", back_populates="books")
    exchange = relationship("Exchange", back_populates="book", uselist=False)


class Exchange(Base):
    __tablename__ = "exchanges"
    id = Column(Integer, primary_key=True)
    book_id = Column(Integer, ForeignKey("books.id"))
    requester_name = Column(String)
    status = Column(String, default="pending")
    book = relationship("Book", back_populates="exchange", uselist=False)