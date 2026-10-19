#!/bin/bash
# Путь к твоим обоям
WALL_DIR="/home/kasper/Изображения/Обои/2024"

ANGLE=$(( RANDOM % 360 + 1 ))
TYPES=("wipe" "wave" "grow" "outer")
SHUFFLED_TYPE=${TYPES[$RANDOM % ${#TYPES[@]}]}
DURATION_MS=$(( RANDOM % 1001 + 500 ))
DURATION=$(echo "scale=1; $DURATION_MS / 1000" | bc -l)

cmd="/home/kasper/.local/bin/image-rofi-rust -w"

# 2. Вызываем rofi
# Скрываем element-text полностью, чтобы не мешался
SELECTED=$($cmd | rofi -dmenu -i -p "Обои" \
    -theme-str '
    window { width: 690px; height: 806px; }
    listview { columns: 3; spacing: 5px; }
    element { padding: -30px 0px -30px 10px; }
    element-icon { size: 200px; horizontal-align: 0.5; }
    element-text { enabled: false; }
    ')

# 3. Применяем обои
if [ -n "$SELECTED" ]; then
    awww img "$SELECTED" --transition-type $SHUFFLED_TYPE --transition-angle $ANGLE --transition-duration $DURATION --transition-fps 165
fi