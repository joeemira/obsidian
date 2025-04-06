from typing import Optional, Union
from fastapi import FastAPI
from fastapi import Body
from pydantic import BaseModel
from random import randrange
app = FastAPI()

My_Posts=[{"title":"title of post 1","content":"content of post1","id":1 },{"title":"title of post 2","content":"content of post2","id":2 }]

def get_post(id):
    for x in My_Posts:
        if x['id'] == id:
            return x
        
    

@app.get("/login")
async  def read_root():
    return {"Hello": "world"}

@app.get("/posts")
async def get_posts():
    return {"data": My_Posts}

class post(BaseModel): #extends the class  of the pydantic 
    title: str
    content : str
    published:bool =True  #default input iff not passed don't true error 
    rating: Optional[int] = None
    id:Optional[int] 
    

    
@app.post("/posts")
async def submit_data(payload: post  ):  #make the Payload of the incoming 
    
    # print(payload.dict())  #accessing the built in method convert to dict in pydantic 
    post_dict=payload.dict()
    post_dict['id']=randrange(0,1000000)
    My_Posts.append(post_dict) 
    
    return {"received": post_dict}

@app.get("/posts/{id}")
def getpost(id:int): # enforce that the API parameter is int and not any thing else 
    post = get_post(id)
    print(post)  
    return post
