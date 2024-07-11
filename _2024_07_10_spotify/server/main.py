from fastapi import FastAPI , Request
from pydantic import BaseModel

app = FastAPI()

class User(BaseModel):
    name: str
    email: str
    password: str

@app.post("/signup")
def signup_user(user: User):
    return user
    