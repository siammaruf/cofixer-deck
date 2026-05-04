# CoFixer Ltd - Pitch Deck

Static website version of the CoFixer Ltd pitch deck with password protection.

## Default Credentials

- **Username:** `admin`
- **Password:** `cofixer2024`

To change the password, generate a new `.htpasswd` file:
```bash
htpasswd -c .htpasswd yourusername
```

## Deploy to Dokploy

### Step 1: Push to Git
Push this folder to a Git repository.

### Step 2: Create Service in Dokploy
1. Go to Dokploy dashboard
2. Create a new service from **Git**
3. Select your repository
4. Choose **Dockerfile** as the build method

### Step 3: Configure Ports
In the Dokploy service settings:
- **Port:** Set to `80`
- The Dockerfile exposes port 80 and runs Apache

### Step 4: Configure Health Check (Important!)
Because the site has password protection, Dokploy's default health check on `/` will fail with `401 Unauthorized`.

Set the health check path to:
```
/health.html
```

This endpoint bypasses authentication and returns `200 OK`.

### Step 5: Deploy
Click deploy. The container will build and start Apache on port 80.

## Troubleshooting

### Bad Gateway Error
If you see "Bad Gateway", check:
1. Port is set to `80` in Dokploy service settings
2. Health check path is `/health.html` (not `/`)
3. `.htaccess` and `.htpasswd` files are present in the repo

### Apache Warning: "Could not reliably determine server's fully qualified domain name"
This is a harmless warning. The Dockerfile sets `ServerName localhost` to suppress it.

## Files

| File | Purpose |
|------|---------|
| `index.html` | 21-slide pitch deck |
| `styles.css` | Modern dark UI styling |
| `script.js` | Slide navigation (keyboard, touch) |
| `.htaccess` | Apache password protection + health check bypass |
| `.htpasswd` | Login credentials |
| `health.html` | Health check endpoint (no auth required) |
| `Dockerfile` | Apache container for Dokploy |
| `docker-compose.yml` | Optional Docker Compose config |

## Features

- 21 slides matching the original PPTX content
- Keyboard navigation (Arrow keys, Space)
- Touch/swipe support for mobile
- Progress bar
- Password protected via `.htaccess`
- Health check endpoint for Dokploy compatibility
