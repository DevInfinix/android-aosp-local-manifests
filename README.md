![Banner](https://cdn.discordapp.com/attachments/1046741210909380698/1252758250970153031/HOpN4Bai.jpg?ex=6673618a&is=6672100a&hm=92d0eb1865fa7ba8947324361e8c829902c9cf3482104c3f5a5133a2d14c4701&)
<h1 align="center"><strong>Local Manifests Repository</strong></h1>

This repository keeps track of custom repositories you use alongside the default manifest, streamlining your development workflow.

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
