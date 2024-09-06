![Banner](https://raw.githubusercontent.com/DevInfinix/android-roms-build-scripts/14-derp-bleeding-edge/infinix-andronix-banner-1-landscape.jpg)
<h1 align="center"><strong>Local Manifests Repository</strong></h1>

This repository keeps track of custom repositories you use alongside the default manifest, streamlining your development workflow.

<a href="https://sourceforge.net/projects/rmx3461-bleeding-edge/files/latest/download"><img alt="Download RMX3461 Bleeding Edge ROMs (Realme 9 SE)" src="https://a.fsdn.com/con/app/sf-download-button" width=276 height=48 srcset="https://a.fsdn.com/con/app/sf-download-button?button_size=2x 2x" align="centre"></a>

---

**Benefits:**

- ✨ Manage additional repositories for your project.
-   Simplify `repo sync` to update all repositories.
-   Keep your local customizations organized.

**How it Works:**

The `repo` tool reads manifests (`.xml` files) to determine which repositories to download. This local manifest acts as an extension, allowing you to specify additional repositories without modifying the default manifest.

**Getting Started:**

1. Clone this repository into your local project directory (e.g., `.repo/manifests`).
2. Add entries for your custom repositories using the standard manifest format.
3. Run `repo sync` to download and update all repositories, including your custom ones.

**Note:**

- Ensure proper indentation and formatting for valid manifest files.
- Refer to the `repo` documentation for detailed information on manifest syntax.

**Happy hacking! **
