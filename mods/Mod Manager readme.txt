Add a mod folder here and put its files inside to make the mod manager recognise it. 
The top level folder of your mod is treated as 'htdocs', so the next level down is usually 'play'. See the example mod for... an example.

When a mod overwrites a file, the vanilla file is saved to htdocs/vanilla_backups/, where it is kept safe even if other mods are also overwriting that file.
This vanilla file is restored when you disable any mod that uses it.

Mods are loaded in the order the user ticks them.

If your mod is not updating ingame, try clearing your browser cache, and then refresh the page.

