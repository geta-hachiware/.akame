#!/usr/bin/env bash

wall_dir="${HOME}/Pictures/Wallpapers/"
cache_dir="${HOME}/.cache/thumbnails/wal_selector"
rofi_config_path="${HOME}/.akame/modules/home-manager/rofi/WallpaperSelect/rofi-wallpaper-sel.rasi"
rofi_command="rofi -dmenu -config -theme ${rofi_config_path}"

post_command="${HOME}/.akame/modules/home-manager/rofi/WallpaperSelect/pywal_global_update.sh"

# Create cache dir if not exists
if [ ! -d "${cache_dir}" ] ; then
        mkdir -p "${cache_dir}"
fi

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
	if [ -f "$imagen" ]; then
		filename=$(basename "$imagen")
			if [ ! -f "${cache_dir}/${filename}" ] ; then
				magick convert -strip "$imagen" -thumbnail 500x500^ -gravity center -extent 500x500 "${cache_dir}/${filename}"
			fi
    fi
done

# Select a picture with rofi
wall_selection=$(ls "${wall_dir}" -t | while read -r A ; do  echo -en "$A\x00icon\x1f""${cache_dir}"/"$A\n" ; done | $rofi_command)

[[ -z "$wall_selection" ]] && exit 1

selected_wallpaper="${wall_dir}/${wall_selection}"

echo "Selected wallpaper path: $selected_wallpaper"

swww img "$selected_wallpaper" --transition-type wipe --transition-fps 60

ln -sf "$selected_wallpaper" "$HOME/.current_wallpaper"

echo "Running post command with: $selected_wallpaper"

"$post_command" "$selected_wallpaper"
