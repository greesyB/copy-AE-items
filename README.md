# copy-AE-items
An attempt to use OC to copy item data from an AE network to be able to restore it, even on a different server (within reason). Useful if the numerical item ids changed between servers, but mod sub-ids generally remain the same.

## Usage

1. Setup an OC computer with max tier memory and a debug card (only necessary on the item spawning computer)
2. Hook an OC adapter to a ME Controller on your network
3. Download this git repo to the OC computer (wget or a [git downloader script](https://github.com/OpenPrograms/Gopher-Programs/blob/master/gitrepo.lua))
4. On the computer attached to the network being copied, run `getItems`. Creates 1 file for every 300 unique items in the system due to pastebin filesize restrictions
5. Upload each generated file to pastebin (`pastebin put <items0>`, incrementing affix per file). Be sure to save the returned pastebin IDs
6. On the computer attached to the network where items will be spawned, repeat steps 1-3
7. Download the created pastebins with the returned ids to a `/home/copy-AE-items` folder (or change the path in `spawnItems`), save each with a name like `items<number>`
8. Change the x,y,z variables in `spawnItems` to the coords of the inventory to insert (e.g. interface on the network)
9. Run `spawnItems` and wait (a potentially very long time depending on number of items)

Items that fail to insert will do so more-or-less silently, aside from printing that 0 were inserted.

### Known Issues

- Some items will fail to insert, mostly items with a lot of NBT data. Examples I experienced are all AE patterns, and many GT components (but not all)
- Some items are not true copies of the original, and won't stack with them; e.g. I had a Cable Diode 4A EV where the copied version would not stack with the original version.
- Some items with an EU charge level will have 0 charge when inserted, even though the NBT charge tags are copied.
- Some items will insert, but lose all meaningful properties of the original. Notably all ArchitectureCraft blocks such as Roof Tiles lose the block they were crafted from and appear as wood.
