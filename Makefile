CC = gcc
CFLAGS = -Wall -Wextra -pedantic
CFLAGS_RELEASE = -O2 -s
CFLAGS_DEBUG = -g -O0
LDFLAGS = -lm

BUILD_DIR = build
BIN_DIR = bin
SRC_DIR = src
INSTALL_DIR = /usr/local/bin

SRC = $(SRC_DIR)/calculator.c
TARGET = calculator
TARGET_STATIC = calculator-static
TARGET_RELEASE = calculator-release
TARGET_DEBUG = calculator-debug

.PHONY: help
help:
@echo "========== CALCULATOR MAKEFILE (LINUX) =========="
@echo ""
@echo "Доступные команды:"
@echo "  make build              - Собрать калькулятор (динамический)"
@echo "  make build-static       - Собрать калькулятор (статический, портативный)"
@echo "  make build-release      - Собрать оптимизированную версию"
@echo "  make build-debug        - Собрать версию с отладкой"
@echo "  make run                - Собрать и запустить"
@echo "  make clean              - Удалить файлы сборки"
@echo "  make install            - Установить в систему"
@echo "  make uninstall          - Удалить из системы"
@echo "  make all                - Собрать все версии"
@echo "  make info               - Информация о сборке"
@echo "  make size               - Размеры файлов"
@echo ""
@echo "Компилятор: $(CC)"
@echo "=================================================="

$(BUILD_DIR):
@mkdir -p $(BUILD_DIR)

$(BIN_DIR):
@mkdir -p $(BIN_DIR)

.PHONY: build
build: $(BUILD_DIR) $(BIN_DIR)
@echo "[*] Сборка калькулятора (динамический)..."
$(CC) $(CFLAGS) -o $(BIN_DIR)/$(TARGET) $(SRC) $(LDFLAGS)
@echo "[+] Сборка завершена: $(BIN_DIR)/$(TARGET)"
@ls -lh $(BIN_DIR)/$(TARGET)

.PHONY: build-static
build-static: $(BUILD_DIR) $(BIN_DIR)
@echo "[*] Сборка калькулятора (статический, портативный)..."
$(CC) $(CFLAGS) -static -o $(BIN_DIR)/$(TARGET_STATIC) $(SRC) $(LDFLAGS)
@echo "[+] Сборка завершена: $(BIN_DIR)/$(TARGET_STATIC)"
@ls -lh $(BIN_DIR)/$(TARGET_STATIC)

.PHONY: build-release
build-release: $(BUILD_DIR) $(BIN_DIR)
@echo "[*] Сборка калькулятора (release, оптимизированный)..."
$(CC) $(CFLAGS) $(CFLAGS_RELEASE) -static -o $(BIN_DIR)/$(TARGET_RELEASE) $(SRC) $(LDFLAGS)
@echo "[+] Сборка завершена: $(BIN_DIR)/$(TARGET_RELEASE)"
@ls -lh $(BIN_DIR)/$(TARGET_RELEASE)

.PHONY: build-debug
build-debug: $(BUILD_DIR) $(BIN_DIR)
@echo "[*] Сборка калькулятора (debug)..."
$(CC) $(CFLAGS) $(CFLAGS_DEBUG) -o $(BIN_DIR)/$(TARGET_DEBUG) $(SRC) $(LDFLAGS)
@echo "[+] Сборка завершена: $(BIN_DIR)/$(TARGET_DEBUG)"
@ls -lh $(BIN_DIR)/$(TARGET_DEBUG)

.PHONY: all
all: build build-static build-release build-debug
@echo ""
@echo "[+] Все версии собраны!"
@echo ""
@ls -lh $(BIN_DIR)/

.PHONY: run
run: build
@echo "[*] Запуск калькулятора..."
@echo ""
@$(BIN_DIR)/$(TARGET)

.PHONY: run-static
run-static: build-static
@echo "[*] Запуск калькулятора (статический)..."
@echo ""
@$(BIN_DIR)/$(TARGET_STATIC)

.PHONY: run-debug
run-debug: build-debug
@echo "[*] Запуск калькулятора (debug)..."
@echo ""
@gdb $(BIN_DIR)/$(TARGET_DEBUG)

.PHONY: install
install: build-release
@echo "[] Установка калькулятора в $(INSTALL_DIR)..."
@sudo cp $(BIN_DIR)/$(TARGET_RELEASE) $(INSTALL_DIR)/$(TARGET)
@sudo chmod +x $(INSTALL_DIR)/$(TARGET)
@echo "[+] Установка завершена!"
@echo "[] Запустите: calculator"

.PHONY: uninstall
uninstall:
@echo "[*] Удаление калькулятора..."
@sudo rm -f $(INSTALL_DIR)/$(TARGET)
@echo "[+] Удаление завершено!"

.PHONY: clean
clean:
@echo "[*] Очистка файлов сборки..."
@rm -rf $(BUILD_DIR) $(BIN_DIR)
@echo "[+] Очистка завершена!"

.PHONY: info
info:
@echo "========== ИНФОРМАЦИЯ О СБОРКЕ =========="
@echo "Компилятор: $(CC)"
@echo "CFLAGS: $(CFLAGS)"
@echo "LDFLAGS: $(LDFLAGS)"
@echo "Исходный файл: $(SRC)"
@echo "Директория сборки: $(BUILD_DIR)"
@echo "Директория бинарников: $(BIN_DIR)"
@echo "Директория установки: $(INSTALL_DIR)"
@echo "========================================"

.PHONY: check
check:
@if [ ! -f $(SRC) ]; then 

echo "Ошибка: Файл $(SRC) не найден!"; 

echo "Создайте src/calculator.c"; 

exit 1; 

fi
@echo "[+] Исходный файл найден: $(SRC)"

.PHONY: init
init:
@echo "[*] Создание структуры проекта..."
@mkdir -p $(SRC_DIR)
@mkdir -p $(BUILD_DIR)
@mkdir -p $(BIN_DIR)
@echo "[+] Директории созданы!"

.PHONY: rebuild
rebuild: clean all
@echo "[+] Пересборка завершена!"

.PHONY: size
size: all
@echo "========== РАЗМЕРЫ ФАЙЛОВ =========="
@du -h $(BIN_DIR)/*
@echo "===================================="

.PHONY: strip
strip: build-release
@echo "[*] Удаление отладочной информации..."
@strip $(BIN_DIR)/$(TARGET_RELEASE)
@echo "[+] Готово!"
@ls -lh $(BIN_DIR)/$(TARGET_RELEASE)

.PHONY: format
format:
@echo "[*] Форматирование кода..."
@if command -v clang-format >/dev/null 2>&1; then 

clang-format -i $(SRC); 

echo "[+] Форматирование завершено!"; 

else 

echo "Ошибка: clang-format не установлен!"; 

echo "Установите: sudo apt-get install clang-format"; 

fi

.PHONY: valgrind
valgrind: build-debug
@echo "[*] Проверка утечек памяти..."
@if command -v valgrind >/dev/null 2>&1; then 

valgrind --leak-check=full --show-leak-kinds=all $(BIN_DIR)/$(TARGET_DEBUG); 

else 

echo "Ошибка: valgrind не установлен!"; 

echo "Установите: sudo apt-get install valgrind"; 

fi

.PHONY: gdb
gdb: build-debug
@echo "[*] Запуск отладчика GDB..."
@gdb $(BIN_DIR)/$(TARGET_DEBUG)

.PHONY: archive
archive: clean
@echo "[*] Создание архива..."
@tar -czf calculator.tar.gz src/ Makefile README.md LICENSE 2>/dev/null || tar -czf calculator.tar.gz src/ Makefile
@echo "[+] Архив создан: calculator.tar.gz"
@ls -lh calculator.tar.gz

.PHONY: dist
dist: clean
@echo "[*] Создание дистрибутива..."
@mkdir -p calculator-dist
@cp -r src Makefile README.md LICENSE calculator-dist/ 2>/dev/null || cp -r src Makefile calculator-dist/
@tar -czf calculator-dist.tar.gz calculator-dist/
@rm -rf calculator-dist
@echo "[+] Дистрибутив создан: calculator-dist.tar.gz"
@ls -lh calculator-dist.tar.gz

.PHONY: test
test: build
@echo "[*] Тестирование калькулятора..."
@echo "1" | $(BIN_DIR)/$(TARGET) 2>/dev/null || echo "[!] Тест завершен"

.PHONY: benchmark
benchmark: build-release
@echo "[*] Бенчмарк производительности..."
@time $(BIN_DIR)/$(TARGET_RELEASE) < /dev/null

.PHONY: deps
deps:
@echo "[*] Проверка зависимостей..."
@command -v gcc >/dev/null 2>&1 && echo "[+] gcc установлен" || echo "[-] gcc не установлен"
@command -v make >/dev/null 2>&1 && echo "[+] make установлен" || echo "[-] make не установлен"
@command -v gdb >/dev/null 2>&1 && echo "[+] gdb установлен" || echo "[-] gdb не установлен"
@command -v valgrind >/dev/null 2>&1 && echo "[+] valgrind установлен" || echo "[-] valgrind не установлен"
@command -v clang-format >/dev/null 2>&1 && echo "[+] clang-format установлен" || echo "[-] clang-format не установлен"

.PHONY: install-deps
install-deps:
@echo "[*] Установка зависимостей..."
@sudo apt-get update
@sudo apt-get install -y build-essential gdb valgrind clang-format
@echo "[+] Зависимости установлены!"

.PHONY: version
version:
@echo "Calculator v1.0"
@echo "Compiler: $$($(CC) --version | head -n1)"

.PHONY: clean-all
clean-all: clean
@echo "[*] Полная очистка..."
@rm -f calculator.tar.gz calculator-dist.tar.gz
@echo "[+] Полная очистка завершена!"

.PHONY: help-advanced
help-advanced:
@echo "========== ДОПОЛНИТЕЛЬНЫЕ КОМАНДЫ =========="
@echo ""
@echo "Отладка и тестирование:"
@echo "  make gdb                - Запустить GDB отладчик"
@echo "  make valgrind           - Проверить утечки памяти"
@echo "  make format             - Форматировать код"
@echo "  make test               - Быстрый тест"
@echo "  make benchmark          - Бенчмарк производительности"
@echo ""
@echo "Управление проектом:"
@echo "  make deps               - Проверить зависимости"
@echo "  make install-deps       - Установить зависимости"
@echo "  make archive            - Создать архив"
@echo "  make dist               - Создать дистрибутив"
@echo "  make version            - Показать версию"
@echo "  make clean-all          - Полная очистка"
@echo ""
@echo "==========================================="
