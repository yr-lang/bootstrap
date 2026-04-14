# Bootstrap

One-command script to set up a fresh Ubuntu environment (WSL or VPS).

---

## Run

1. Install `curl`

```bash
sudo apt update && sudo apt install -y curl
```

2. Execute the script

2.1 Using `yrkit` as user

```bash
curl -fsSL https://raw.githubusercontent.com/yr-lang/bootstrap/main/bootstrap.sh | bash
```

2.1 Not using `yrkit` as user

```bash
curl -fsSL https://raw.githubusercontent.com/yr-lang/bootstrap/main/bootstrap.sh | bash -s -- --skip-user
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
