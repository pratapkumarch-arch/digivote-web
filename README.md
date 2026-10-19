# digivote-web

Firebase Hosting for DigiVote (project `digivote-prod`, site `digivoteindia`).

## URL map

| URL | What people get |
|-----|-----------------|
| `https://digivoteindia.firebaseapp.com/` | DigiVote **web portal** (Flutter web) |
| `https://digivoteindia.firebaseapp.com/get/` | Marketing / download (store badges, videos) |
| `https://digivoteindia.firebaseapp.com/i/<code>` | Invite landing page |
| `https://digivoteindia.firebaseapp.com/app/` | **301 → `/get/`** (legacy; do not use) |

Also: `https://digivoteindia.web.app` (same site).  
Legacy `https://digivote-prod.web.app` 301-redirects to `digivoteindia.web.app`.

Portal UI source: `../digivote-ui`. API: `../digivote-backend` (Cloud Run in prod, local Flask for laptop).

## Local web (digivote local API)

1. Start the local API: `cd ../digivote-backend && .venv/bin/python main.py`
2. Run Flutter web: `cd ../digivote-ui && ./scripts/run_web_local.sh`  
   - API: `http://127.0.0.1:8000`  
   - Firebase Auth: digivote-prod / `digivoteindia.firebaseapp.com`

## Deploy portal to digivoteindia

```bash
./scripts/deploy_hosting.sh
```

Or assemble only (no deploy):

```bash
./scripts/assemble_public.sh
```

Uses bundled Node/Firebase CLI under `.tools/node/bin` when on `PATH`.
