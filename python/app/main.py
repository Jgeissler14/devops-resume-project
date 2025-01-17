import fastapi
from typing import List
from pydantic import BaseModel

app = fastapi.FastAPI()

class Item(BaseModel):
    name: str
    description: str = None

store = []

@app.get("/items", response_model=List[Item])
def get_items():
    """
    Sample curl request:
    curl -X 'GET' \
      'http://127.0.0.1:8000/items' \
      -H 'accept: application/json'
    """
    return store

@app.post("/items", response_model=Item)
def create_item(item: Item):
    """
    Sample curl request:
    curl -X 'POST' \
      'http://127.0.0.1:8000/items' \
      -H 'accept: application/json' \
      -H 'Content-Type: application/json' \
      -d '{
      "name": "Sample Item",
      "description": "This is a sample item"
    }'
    """
    store.append(item)
    return item

@app.get("/health")
async def root():
    """
    Sample curl request:
    curl -X 'GET' \
      'http://127.0.0.1:8000/health' \
      -H 'accept: application/json'
    """
    return {"status": 200}