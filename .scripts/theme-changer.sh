#!/bin/bash

# Variables
SCHEMA="org.gnome.desktop.interface"
COLOR="color-scheme"
DARK_MODE="'prefer-dark'"

theme_name=""
icon_name=""
cursor_name=""
sway_config_file="$HOME/.config/sway/config"

error_message=""
is_valid_theme=false
is_valid_icon=false
is_valid_cursor=false

# Object-type-membership naming convention
theme_path_user=""
theme_path_system=""
icon_path_user=""
icon_path_system=""
cursor_path_user=""
cursor_path_system=""

# Help func
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Change the GTK theme, icon and cursor"
    echo ""
    echo "Options:"
    echo "  -t, --theme <name>    Set GTK theme"
    echo "  -i, --icon <name>     Set icon theme"
    echo "  -c, --cursor <name>   Set cursor theme"
    echo "  -h, --help            Show help"
    echo ""
}

# Processing args through flags
while getopts ":t:i:c:h" opt; do
    case "${opt}" in
        t)
            theme_name="$OPTARG"
            ;;
        i)
            icon_name="$OPTARG"
            ;;
        c)
            cursor_name="$OPTARG"
            ;;
        h)
            show_help
            exit 0
            ;;
        \?)
            echo "Error: Invalid option -$OPTARG" >&2
            show_help
            exit 1
            ;;
        :)
            echo "Error: The option -$OPTARG requieres a arg" >&2
            show_help
            exit 1
            ;;
    esac
done

shift $((OPTIND -1))

if [ "$#" -eq 0 ] && [ -z "$theme_name" ] && [ -z "$icon_name" ] && [ -z "$cursor_name" ]; then
    show_help
    exit 0
fi

# Func that replaces the cursor theme in sway config file
set_sway_cursor_theme() {
    if [ ! -f "$sway_config_file" ]; then
        echo "Error: Sway config file not found in $sway_config_file" >&2
        return 1
    fi
    sed -i 's/seat \* xcursor_theme.*/seat * xcursor_theme '$cursor_name' 24/g' $sway_config_file
    swaymsg reload
}

# Remove the buttons(minimize, maximize, and close) from the title bar 
gsettings set org.gnome.desktop.wm.preferences button-layout ':'

# Set the color-scheme to dark mode if it is in light mode
current_scheme=$(gsettings get "$SCHEMA" "$COLOR")
if [ "$current_scheme" != "$DARK_MODE" ]; then
    echo "The dark theme is not activated, proceeding to activate it..."
    gsettings set "$SCHEMA" "$COLOR" "$DARK_MODE"
fi

# Validates each arg(gtk theme name, icon and cursor) and updates the control variables
if [ -n "$theme_name" ]; then
    theme_path_user="$HOME/.themes/$theme_name"
    theme_path_system="/usr/share/themes/$theme_name"

    if [ -d "$theme_path_user" ] || [ -d "$theme_path_system" ]; then
        is_valid_theme=true 
    else
        error_message+="Error: GTK theme '$theme_name' not found"$'\n'
    fi
fi

if [ -n "$icon_name" ]; then
    icon_path_user="$HOME/.icons/$icon_name"
    icon_path_system="/usr/share/icons/$icon_name"

    if [ -d "$icon_path_user" ] || [ -d "$icon_path_system" ]; then
        is_valid_icon=true
    else
        error_message+="Error: Icon theme '$icon_name' not found"$'\n'
    fi
fi

if [ -n "$cursor_name" ]; then
    cursor_path_user="$HOME/.icons/$cursor_name"
    cursor_path_system="/usr/share/icons/$cursor_name"

    if [ -d "$cursor_path_user" ] || [ -d "$cursor_path_system" ]; then
        is_valid_cursor=true
    else
        error_message+="Error: Cursor theme '$cursor_name' not found"$'\n'
    fi
fi

# Changes are applied only if the control variables are 'true'
if $is_valid_theme; then
    gtk4_path_user="$theme_path_user/gtk-4.0"
    gtk4_path_system="$theme_path_system/gtk-4.0"
    config_path_dest="$HOME/.config/gtk-4.0"
    assets_path="$HOME"/.config/assets
    theme_prop="gtk-theme"
    source_path=""
    
    gsettings set "$SCHEMA" "$theme_prop" "$theme_name"

    # Checks if the theme has a gtk-4.0 folder to apply
    if [ -d "$gtk4_path_user" ]; then
        source_path="$gtk4_path_user"
    elif [ -d "$gtk4_path_system" ]; then
        source_path="$gtk4_path_system"
    else
        echo "The theme doesn't have a gtk-4.0 folder. Skipping step..."
        rm -rf "$config_path_dest" && rm -f "$assets_path"
    fi

    if [ -n "$source_path" ]; then
        rm -rf "$config_path_dest" && rm -f "$assets_path"
        ln -s "$source_path" "$config_path_dest"
        sleep 1
        ln -s "${source_path%/*}/assets" "$assets_path"
    fi
    echo "GTK theme changed to: $theme_name" 
fi

if $is_valid_icon; then
    icon_prop="icon-theme"    
    gsettings set "$SCHEMA" "$icon_prop" "$icon_name"
    echo "Icon theme changed to: $icon_name"
fi

if $is_valid_cursor; then
    cursor_prop="cursor-theme"    
    gsettings set "$SCHEMA" "$cursor_prop" "$cursor_name"
    set_sway_cursor_theme
    echo "Cursor theme changed to: $cursor_name"
fi

# All values are printed at the end
if [[ -n "$error_message" ]]; then
    echo "¡An attempt was made to complete all required changes, but the following errors were encountered! ⚠️"

    declare -a error_array
    # Reads the entire string and splits by newlines, filling the array
    while read -r line; do
        error_array+=("$line")
    done <<< "$error_message"
    # Iterate through indexes to control formatting
    for i in "${!error_array[@]}"; do
        echo -n "${error_array[$i]}"
        # If it is not the last element, print a line break
        if [[ $i -lt $((${#error_array[@]} - 1)) ]]; then
            echo
        fi
    done

    exit 1
else
    echo "¡All requested changes were successfully applied! ✅"
    exit 0
fi
