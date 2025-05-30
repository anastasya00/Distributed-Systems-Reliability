# Анализ надежности вычислительных систем

Репозиторий содержит программы для расчета показателей надежности распределенных вычислительных систем с избыточностью.

### 1. Анализ времени работы и восстановления (failure_recovery_time/)
- Расчёт Θ (MTBF) и T (MTTR)
- Исследование зависимостей:
  - От интенсивности отказов (λ)
  - От интенсивности восстановления (μ)
  - От количества восстанавливающих устройств (m)
  - От количества рабочих машин (n)

### 2. Функции надёжности (reliability_recovery/)
- Оперативная надёжность R*(t)
- Функция восстановления U*(t)
- Коэффициент готовности S

### 3. Показатели живучести (system_resilience/)
- Вектор времени безотказной работы θ
- Вектор времени восстановления T