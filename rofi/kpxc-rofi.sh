#!/bin/bash

KDBX_FILE=~/Документы/Secrets/Сейф.kdbx
KDBX_KEY=~/Документы/Secrets/Файл-ключ
CLIP_TIMEOUT=30 

# 1. ЗАПРОС ПАРОЛЯ БЕЗ БЛОКИРОВОК
# Убрал -password. Будешь видеть символы, но зато проверим, идет ли ввод вообще.
MASTER_PASSWORD=$(rofi -password -dmenu -p "🔓 Ввод:" -theme-str 'window { width: 600px; height: 77px;}')

[ -z "$MASTER_PASSWORD" ] && exit 1

# 2. ПРОКИДЫВАЕМ В БАЗУ
ENTRIES=$(echo "$MASTER_PASSWORD" | keepassxc-cli ls -R $KDBX_FILE -k $KDBX_KEY)

if [ -z "$ENTRIES" ]; then
    # Если зашел сюда — либо пароль не тот, либо путь к базе кривой.
    notify-send "KeepassXC" "❌ Ошибка. Проверь пароль."
    exit 1
fi

# 3. ВЫБОР ИЗ СПИСКА
SELECTED_ENTRY=$(echo -e "$ENTRIES" | rofi -dmenu -p "🔑 Запись:" -theme-str 'window { width: 400px; height: 600px;}')

# 4. КОПИРОВАНИЕ
if [ -n "$SELECTED_ENTRY" ]; then
    echo "$MASTER_PASSWORD" | keepassxc-cli clip $KDBX_FILE -k $KDBX_KEY $SELECTED_ENTRY 0 && sleep 0.01 | ~/Документы/code/скрипты/timedead.sh
    notify-send "KeepassXC" "✅ Пароль скопирован"
fi

unset MASTER_PASSWORD