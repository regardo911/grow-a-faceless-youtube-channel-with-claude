"""upload.py upload.json [--dry-run]
Uploads one video to YouTube with the Data API (videos.insert), then sets its thumbnail.
First run opens a browser to sign in with Google and saves token.json next to this file.
Two changes from my run: a missing "aiLabel" now stops the script instead of quietly sending No,
and the dry run says so when the MP4 isn't there yet instead of crashing.
You are responsible for the AI-use answer and for what you publish."""
import json, sys, pathlib
cfg = json.load(open(sys.argv[1])); dry = "--dry-run" in sys.argv
if "aiLabel" not in cfg:   # the AI-use answer is yours to make (chapter 8), never a default
    sys.exit('upload.json has no "aiLabel". Set it to true or false yourself: the AI-use answer is your call (Chapter 8).')
body = {
    "snippet": {"title": cfg["title"], "description": cfg["description"], "tags": cfg.get("tags", []), "categoryId": "28"},
    "status": {"privacyStatus": "private" if cfg.get("publishAt") else cfg.get("privacy", "public"),
               "selfDeclaredMadeForKids": False, "containsSyntheticMedia": cfg["aiLabel"]},
}
if cfg.get("publishAt"): body["status"]["publishAt"] = cfg["publishAt"]   # scheduled: must be private until then
if dry:
    print(json.dumps(body, indent=1)); f = pathlib.Path(cfg["file"]); print("file:", cfg["file"], f"{f.stat().st_size} bytes" if f.exists() else "(not there yet: point \"file\" at your final MP4)")
    print("quota: 1 call from the 100-a-day upload bucket" + (" + about 50 units for the thumbnail" if cfg.get("thumbnail") else ""))
    sys.exit(0)
from google_auth_oauthlib.flow import InstalledAppFlow
from google.oauth2.credentials import Credentials
from google.auth.transport.requests import Request
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
SCOPES = ["https://www.googleapis.com/auth/youtube.upload"]
tok = pathlib.Path(__file__).with_name("token.json")
creds = Credentials.from_authorized_user_file(tok, SCOPES) if tok.exists() else None
if creds and creds.expired and creds.refresh_token:
    try: creds.refresh(Request())
    except Exception: creds = None          # Testing-mode tokens die after 7 days: sign in again
if not creds or not creds.valid:
    creds = InstalledAppFlow.from_client_secrets_file("client_secret.json", SCOPES).run_local_server(port=0)
    tok.write_text(creds.to_json())
yt = build("youtube", "v3", credentials=creds)
req = yt.videos().insert(part="snippet,status", body=body, media_body=MediaFileUpload(cfg["file"], chunksize=-1, resumable=True))
resp = None
while resp is None: _, resp = req.next_chunk()
print("uploaded:", "https://youtu.be/" + resp["id"])
if cfg.get("thumbnail"):
    yt.thumbnails().set(videoId=resp["id"], media_body=MediaFileUpload(cfg["thumbnail"])).execute()
    print("thumbnail set")
