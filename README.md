
# moonloader-scripts-autoupdater 🌙

Sup, this is **moonloader-scripts-autoupdater**. If you want your scripts to update automatically so users don't have to suffer looking for new versions manually, this library handles it for you.

Just provide a link to a JSON file, and the script will check the version itself. If there's a new update available, it downloads and installs it. Easy.

## Features 🤔
* **Auto-check:** Automatically checks the JSON file for the latest version.
* **Fast download:** Updates immediately if a new version is found.
* **Easy integration:** Requires just a few lines of code.

## Installation 🛠️
Just download `autoupdater.lua` (or whatever the file is named) and drop it into your `moonloader/lib` folder.

Or, if you want to bundle it, include the code directly in your main script file.

## Usage 💻

Here is an example of how to use it in your code:

```lua
if updater_loaded then
    autoupdate_loaded, Update = pcall(Updater)
    if autoupdate_loaded then
        Update.json_url = "Put Raw Link To JSON" .. tostring(os.clock())
        Update.url = "Put Raw Link To Latest Script Version"
    end
end

```

## JSON Structure 📄

You need to host a `version.json` file on GitHub (or elsewhere) that looks like this:

```json
{
  "latest": "Put Same Version In This As In Latest Lua",
  "updateurl": "Put Raw Link To Latest Script Version"
}

```

## License 📜

Open source, feel free to use it.

---

made with ❤️ by **sulovych**
