![Banner](https://cdn.discordapp.com/attachments/1046741210909380698/1252755969029574717/SKB6iLmN.jpg?ex=6691092a&is=668fb7aa&hm=93a6ac3904ead4fae59568817c5332bf7c890ace3cd182132ba1ecec52a3c4db&)
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
