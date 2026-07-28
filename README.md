# Free Cydia Repo Starter

This template creates a free Cydia/APT repository on GitHub Pages. It is designed for legacy Cydia, including iOS 6-era devices.

## Set it up

1. Create a new **public** GitHub repository, for example `david-repo`.
2. Upload every file and folder from this starter project to the repository.
3. Open **Settings → Pages** in the GitHub repository.
4. Under **Build and deployment**, set **Source** to **GitHub Actions**.
5. Upload your `.deb` packages into the `debs` folder.
6. Wait for the **Deploy Cydia repo to Pages** workflow to finish.
7. Your Cydia source will be:
   `https://YOUR-USERNAME.github.io/YOUR-REPOSITORY/`

Example:
`https://david123.github.io/david-repo/`

## Add or update a package

Upload the new `.deb` into `debs/`. Use a higher version number when updating a package. GitHub Actions automatically regenerates:

- `Packages`
- `Packages.gz`
- `Release`

Then refresh Sources in Cydia.

## Customize

- Replace `CydiaIcon.png` with a square PNG logo.
- Edit `repo-info.conf` to change the repo name, description, and maintainer.
- Edit `index.html` to customize the webpage.

## Important package fields

Each `.deb` needs a valid Debian `control` file. Typical fields:

```
Package: com.example.package
Name: Example Package
Version: 1.0.0
Architecture: iphoneos-arm
Description: Example package for iOS 6
Maintainer: Your Name
Author: Your Name
Section: Tweaks
Depends: mobilesubstrate
```

For a simple utility without MobileSubstrate, remove the `Depends: mobilesubstrate` line.
