#!/usr/bin/env python3
import subprocess
import sys
import json
import urllib.parse
import urllib.request

# --- Настройки ---
MAX_WIDTH = 90

def wrap_text(text, width):
    lines = []
    for line in text.split('\n'):
        line = line.strip()
        while len(line) > width:
            space_idx = line.rfind(' ', 0, width)
            if space_idx == -1: space_idx = width
            lines.append(line[:space_idx])
            line = line[space_idx:].lstrip()
        if line: lines.append(line)
    return '\n'.join(lines)

def get_clip():
    # Список команд для проверки буферов
    commands = [
        ['wl-paste', '--primary'],  # Выделение мышью (Wayland)
        ['wl-paste'],               # Обычный Ctrl+C (Wayland)
        ['cliphist', 'list'],       # Сначала смотрим историю cliphist
        ['xclip', '-o', '-selection', 'primary'], 
        ['xclip', '-o', '-selection', 'clipboard']
    ]

    for cmd in commands:
        try:
            result = subprocess.check_output(cmd, stderr=subprocess.DEVNULL, text=True)
            if not result.strip():
                continue
            
            # Если это cliphist, берем первую строку и отрезаем ID
            if cmd[0] == 'cliphist':
                first_line = result.splitlines()[0]
                # Разбиваем по табуляции и берем вторую часть (сам текст)
                parts = first_line.split('\t', 1)
                return parts[1] if len(parts) > 1 else parts[0]
            
            return result.strip()
            
        except (subprocess.CalledProcessError, FileNotFoundError):
            continue
            
    return ""
    
    for cmd in commands:
        try:
            # Пытаемся выполнить команду, игнорируем ошибки, если буфер пуст
            result = subprocess.run(cmd, capture_output=True, timeout=0.5)
            text = result.stdout.decode().strip()
            if text:
                return text
        except Exception:
            continue
            
    return ""

def translate(text, target):
    url = f"https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl={target}&dt=t&q={urllib.parse.quote(text)}"
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req, timeout=5) as response:
        data = json.loads(response.read().decode())
        detected_lang = data[2]
        translated_text = "".join([part[0] for part in data[0] if part[0]])
        return detected_lang, translated_text

def main():
    text = get_clip()
    if not text:
        subprocess.run(['notify-send', 'Ошибка', 'Ничего не выделено'])
        sys.exit(1)

    try:
        # Перевод (Auto -> RU, если уже RU -> EN)
        lang, trans_text = translate(text, 'ru')
        target = 'ru'
        if lang == 'ru':
            target = 'en'
            _, trans_text = translate(text, 'en')

        wrapped_orig = wrap_text(text, MAX_WIDTH)
        wrapped_trans = wrap_text(trans_text, MAX_WIDTH)
        final_output = f"--- ИСХОДНИК ({lang}) ---\n{wrapped_orig}\n\n--- ПЕРЕВОД ({target}) ---\n{wrapped_trans}"

        # 1. Если запуск с флагом --copy (сразу копируем без Rofi)
        if len(sys.argv) > 1 and sys.argv[1] == "--copy":
            subprocess.run(['wl-copy'], input=trans_text.encode())
            return

        # 2. ВЫВОД В ROFI (ТВОИ СТИЛИ)
        rofi_cmd = [
            'rofi', '-dmenu', '-i', '-p', f'Перевод ({lang} -> {target})',
            '-theme-str', 'window { width: 1024px; } listview { columns: 1; lines: 20; } element-text { wrap: true; margin: 12px 0px 12px -36px;} element { orientation: horizontal; padding: 0px;}'
        ]
        
        proc = subprocess.run(rofi_cmd, input=final_output.encode(), capture_output=True)
        
        # 3. КОПИРОВАНИЕ ПОСЛЕ ВЫБОРА (Если нажат Enter, код возврата 0)
        if proc.returncode == 0:
            subprocess.run(['wl-copy'], input=trans_text.encode())
            subprocess.run(['notify-send', '-t', '1200', '✅ Скопировано в буфер'])

        # Чистка истории cliphist
        for t in [text, trans_text]:
            subprocess.run(['cliphist', 'delete'], input=t.encode(), stderr=subprocess.DEVNULL)

    except Exception as e:
        subprocess.run(['notify-send', '❌ Ошибка', str(e)])

if __name__ == "__main__":
    main()