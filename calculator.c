#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

// Функция для сложения
double add(double a, double b) {
    return a + b;
}

// Функция для вычитания
double subtract(double a, double b) {
    return a - b;
}

// Функция для умножения
double multiply(double a, double b) {
    return a * b;
}

// Функция для деления
double divide(double a, double b) {
    if (b == 0) {
        printf("Ошибка: Деление на ноль!\n");
        return 0;
    }
    return a / b;
}

// Функция для возведения в степень
double power(double a, double b) {
    return pow(a, b);
}

// Функция для квадратного корня
double square_root(double a) {
    if (a < 0) {
        printf("Ошибка: Квадратный корень из отрицательного числа!\n");
        return 0;
    }
    return sqrt(a);
}

// Функция для модуля
double modulo(double a, double b) {
    if (b == 0) {
        printf("Ошибка: Деление на ноль!\n");
        return 0;
    }
    return fmod(a, b);
}

// Функция для факториала
double factorial(double n) {
    if (n < 0) {
        printf("Ошибка: Факториал отрицательного числа!\n");
        return 0;
    }
    if (n == 0 || n == 1) {
        return 1;
    }
    double result = 1;
    for (double i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}

// Функция для синуса
double sine(double a) {
    return sin(a);
}

// Функция для косинуса
double cosine(double a) {
    return cos(a);
}

// Функция для тангенса
double tangent(double a) {
    return tan(a);
}

// Функция для логарифма
double logarithm(double a) {
    if (a <= 0) {
        printf("Ошибка: Логарифм неположительного числа!\n");
        return 0;
    }
    return log10(a);
}

// Функция для натурального логарифма
double natural_log(double a) {
    if (a <= 0) {
        printf("Ошибка: Натуральный логарифм неположительного числа!\n");
        return 0;
    }
    return log(a);
}

// Функция для абсолютного значения
double absolute(double a) {
    return fabs(a);
}

// Функция для вывода меню
void display_menu() {
    printf("\n========== КАЛЬКУЛЯТОР ==========\n");
    printf("1. Сложение (+)\n");
    printf("2. Вычитание (-)\n");
    printf("3. Умножение (*)\n");
    printf("4. Деление (/)\n");
    printf("5. Возведение в степень (^)\n");
    printf("6. Квадратный корень (sqrt)\n");
    printf("7. Модуль (%%)\n");
    printf("8. Факториал (!)\n");
    printf("9. Синус (sin)\n");
    printf("10. Косинус (cos)\n");
    printf("11. Тангенс (tan)\n");
    printf("12. Логарифм (log10)\n");
    printf("13. Натуральный логарифм (ln)\n");
    printf("14. Абсолютное значение (abs)\n");
    printf("0. Выход\n");
    printf("================================\n");
}

// Основная функция
int main() {
    int choice;
    double num1, num2, result;
    
    printf("Добро пожаловать в калькулятор!\n");
    
    while (1) {
        display_menu();
        printf("Выберите операцию (0-14): ");
        scanf("%d", &choice);
        
        if (choice == 0) {
            printf("До свидания!\n");
            break;
        }
        
        if (choice >= 1 && choice <= 7) {
            printf("Введите первое число: ");
            scanf("%lf", &num1);
            printf("Введите второе число: ");
            scanf("%lf", &num2);
            
            switch (choice) {
                case 1:
                    result = add(num1, num2);
                    printf("Результат: %.2f + %.2f = %.2f\n", num1, num2, result);
                    break;
                case 2:
                    result = subtract(num1, num2);
                    printf("Результат: %.2f - %.2f = %.2f\n", num1, num2, result);
                    break;
                case 3:
                    result = multiply(num1, num2);
                    printf("Результат: %.2f * %.2f = %.2f\n", num1, num2, result);
                    break;
                case 4:
                    result = divide(num1, num2);
                    printf("Результат: %.2f / %.2f = %.2f\n", num1, num2, result);
                    break;
                case 5:
                    result = power(num1, num2);
                    printf("Результат: %.2f ^ %.2f = %.2f\n", num1, num2, result);
                    break;
                case 6:
                    result = square_root(num1);
                    printf("Результат: sqrt(%.2f) = %.2f\n", num1, result);
                    break;
                case 7:
                    result = modulo(num1, num2);
                    printf("Результат: %.2f %% %.2f = %.2f\n", num1, num2, result);
                    break;
            }
        }
        else if (choice >= 8 && choice <= 14) {
            if (choice == 8) {
                printf("Введите число: ");
                scanf("%lf", &num1);
                result = factorial(num1);
                printf("Результат: %.0f! = %.0f\n", num1, result);
            }
            else if (choice == 9) {
                printf("Введите число (в радианах): ");
                scanf("%lf", &num1);
                result = sine(num1);
                printf("Результат: sin(%.2f) = %.2f\n", num1, result);
            }
            else if (choice == 10) {
                printf("Введите число (в радианах): ");
                scanf("%lf", &num1);
                result = cosine(num1);
                printf("Результат: cos(%.2f) = %.2f\n", num1, result);
            }
            else if (choice == 11) {
                printf("Введите число (в радианах): ");
                scanf("%lf", &num1);
                result = tangent(num1);
                printf("Результат: tan(%.2f) = %.2f\n", num1, result);
            }
            else if (choice == 12) {
                printf("Введите число: ");
                scanf("%lf", &num1);
                result = logarithm(num1);
                printf("Результат: log10(%.2f) = %.2f\n", num1, result);
            }
            else if (choice == 13) {
                printf("Введите число: ");
                scanf("%lf", &num1);
                result = natural_log(num1);
                printf("Результат: ln(%.2f) = %.2f\n", num1, result);
            }
            else if (choice == 14) {
                printf("Введите число: ");
                scanf("%lf", &num1);
                result = absolute(num1);
                printf("Результат: abs(%.2f) = %.2f\n", num1, result);
            }
        }
        else {
            printf("Ошибка: Неверный выбор!\n");
        }
    }
    
    return 0;
}
