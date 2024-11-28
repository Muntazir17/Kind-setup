from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import shutil
from pathlib import Path
from git import Repo  

app = FastAPI()

class GitRepoRequest(BaseModel):
    git_url: str

@app.post("/clone-repo/")
async def clone_git_repo(request: GitRepoRequest):
    """
    Endpoint to clone a Git repository given its URL.
    """
    git_url = request.git_url
    destination_folder = Path("./cloned_repo")

    try:
        # Remove the destination folder if it already exists and is not in use
        if destination_folder.exists():
            shutil.rmtree(destination_folder)
            print("Old repository directory removed.")

        # Clone the repository
        print(f"Cloning repository from {git_url}...")
        Repo.clone_from(git_url, destination_folder)
        print("Repository cloned successfully.")

        return {"message": "Repository cloned successfully."}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error cloning repository: {str(e)}")


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)  
