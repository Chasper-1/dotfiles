#!/usr/bin/env python3
import subprocess
import sys
import os

# Путь к твоему бинарнику
CMD_GEN = "/home/kasper/.local/bin/image-rofi-rust"

def main():
    row = 0
    while True:
        # 1. Получаем свежий список от твоего бинарника
        try:
            input_data = subprocess.check_output(CMD_GEN, text=True)
        except subprocess.CalledProcessError:
            break

        # 2. Запускаем Rofi
        # -kb-custom-1 (Alt+1) -> Exit Code 10 (Предпросмотр)
        # -kb-custom-2 (Alt+d) -> Exit Code 11 (Удаление выбранного)
        rofi_proc = subprocess.Popen([
            "rofi", "-dmenu",
            "-p", "Копировать.",
            "-selected-row", str(row),
            "-format", "i;s",
            "-kb-custom-1", "Alt+1",
            "-kb-custom-2", "Alt+d", 
            "-theme-str", """
            listview {columns: 1;} window { width: 1400px; height: 772px;} element-text {
                background-color: transparent;
                horizontal-align: 0;
                vertical-align: 0;
                padding: 5px 0px 25px 0px ;
                margin: -32px -12px -10px 12px;
                single-line: false;
                wrap: true;
            } element-icon {
                    horizontal-align: 0.5;
                    vertical-align: 0.5;
                } element {
                        orientation: vertical;
                        padding: 0px;
                    }
            """
        ], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)

        stdout, _ = rofi_proc.communicate(input=input_data)
        exit_code = rofi_proc.returncode

        # Если нажали Esc или закрыли окно
        if exit_code == 1 or not stdout.strip():
            break

        # Разбираем вывод Rofi: "индекс;содержимое_строки"
        parts = stdout.strip().split(';', 1)
        row = int(parts[0])
        selected_content = parts[1]
        
        # ID — это первое "слово" в строке (число)
        clip_id = selected_content.split()[0]

        # --- ЛОГИКА ДЕЙСТВИЙ ---

        if exit_code == 0:
            # КОПИРОВАНИЕ (Enter)
            # Используем shell=True, чтобы прокинуть pipe в wl-copy
            subprocess.run(f"cliphist decode '{clip_id}' | wl-copy", shell=True)
            break

        elif exit_code == 10:
            # ПРЕДПРОСМОТР (Alt+1)
            mime = subprocess.getoutput(f"cliphist decode '{clip_id}' | file -b --mime-type -")
            if "image/" in mime:
                temp_path = "/tmp/rofi_preview.png"
                subprocess.run(f"cliphist decode '{clip_id}' > {temp_path}", shell=True)
                subprocess.run(["swayimg", temp_path])
                if os.path.exists(temp_path):
                    os.remove(temp_path)
            else:
                subprocess.run(["notify-send", "-t", "1000", "Это текст", selected_content])
            # После просмотра возвращаемся в цикл (Rofi откроется снова на той же строке)

        elif exit_code == 11:
            # УДАЛЕНИЕ ВЫБРАННОГО (Alt+d)
            # Передаем выбранную строку целиком в cliphist delete
            subprocess.run(["cliphist", "delete"], input=selected_content, text=True)
            subprocess.run(["notify-send", "-t", "700", "Удалено", f"ID: {clip_id}"])
            # Цикл продолжится, список обновится, ты останешься на той же позиции
            
    return

if __name__ == "__main__":
    main()