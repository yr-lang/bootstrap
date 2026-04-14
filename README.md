# Bootstrap

One-command script to set up a fresh Ubuntu environment (WSL or VPS).

---

## Run

1. Install `curl`

```bash
sudo apt update && sudo apt install -y curl
```

2. Execute the script

```bash
curl -fsSL https://raw.githubusercontent.com/yr-lang/bootstrap/main/bootstrap.sh | bash
```

---

## What it does

* Installs required packages
* Sets up tools (e.g. Docker)
* Starts services (e.g. MongoDB)

---

## Notes

* Works on WSL and VPS
* Safe to run on a fresh system
