#!/usr/bin/env python3
import os
import subprocess
import sys


def get_full_translate(text):
    if not text.strip():
        return ""
    try:
        # Полный словарный вывод через translate-shell
        res = subprocess.check_output(
            [
                "trans",
                "-no-ansi",
                "-show-translation",
                "n",
                "-show-dictionary",
                "y",
                ":ru",
                text,
            ],
            stderr=subprocess.DEVNULL,
            text=True,
        )
        return res.strip()
    except:
        return "Ошибка: установите translate-shell"


def main():
    # Движок для Rofi (обновление на лету)
    if len(sys.argv) > 1:
        print(get_full_translate(" ".join(sys.argv[1:])))
        sys.exit(0)

    # Запуск самого Rofi
    script_path = os.path.abspath(__file__)

    rofi_cmd = [
        "rofi",
        "-show",
        "translate",
        "-modi",
        f"translate:{script_path}",
        "-theme-str",
        "window { width: 1024px; } listview { columns: 1; lines: 20; } element-text { wrap: true; margin: 12px 0px 12px -36px;} element { orientation: horizontal; padding: 0px;} configuration {sidebar-mode: false;}",
    ]

    proc = subprocess.run(rofi_cmd, capture_output=True, text=True)

    if proc.returncode == 0 and proc.stdout:
        res = proc.stdout.strip()
        copy_cmd = (
            "wl-copy"
            if os.environ.get("WAYLAND_DISPLAY")
            else "xclip -selection clipboard"
        )
        subprocess.run(copy_cmd.split(), input=res.encode())


if __name__ == "__main__":
    main()
