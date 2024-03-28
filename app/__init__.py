from fastapi import FastAPI, Request, Response


app = FastAPI()


@app.get("/")
async def root():
    return {
        "message": "Hello World",
        "version": "0.0.8"
    }


@app.get("/health")
async def health():
    return {"health status": "HEALTHY"}
