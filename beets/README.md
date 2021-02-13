# Copy titles from one album to another

Useful when replacing MP3s with FLACs.

Database file: `~/.config/beets/library.db` open with `beet-edit-db`.

```sql
UPDATE items AS new
SET title = (SELECT old.title
             FROM items AS old
             WHERE new.disc = old.disc AND
                   new.track = old.track AND
                   old.album_id = __old_album__)
WHERE new.album_id = __new_album__;
```
