# OpenMW TES3MP in Docker optimized for Unraid
TES3MP is a project adding multiplayer functionality to OpenMW, a free and open source engine recreation of the popular Bethesda Softworks game "The Elder Scrolls III: Morrowind".

Update Notice: Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| DATA_DIR | Main Data folder | /openmw |
| HOME_CONFIG_DIR | Bind mount for configuration files to be copied to the server's `root` user directory on startup. |
| GAME_V | Preferred game version goes here (set to ‘latest’ to download the latest and check on every startup if there is a newer version available) | latest |
| GAME_PARAMS | Extra startup Parameters if needed (leave empty if not needed) | |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| UMASK | Umask value | 0000 |
| DATA_PERM | Data permissions for /openmw folder | 770 |

## Run example
```
docker run --name OpenMW-TES3MP -d \
	-p 25565:25565/tcp \
	-p 25565:25565/udp \
	--env 'GAME_V=latest' \
	--env 'UID=99' \
	--env 'GID=100' \
	--env 'UMASK=0000' \
	--env 'DATA_PERM=770' \
	--volume /mnt/cache/appdata/openmw-tes3mp:/openmw \
	ich777/docker-openmw-tes3mp
```
