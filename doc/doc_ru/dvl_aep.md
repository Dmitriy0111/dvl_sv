# dvl_aep (analysis export)

Данный файл содержит описание класса порта, необходимого для одностороннего обмена между верификационными компонентами совместно с классом dvl_ap (analysis port). Класс наследуется от dvl_bp и является передатчиком данных. Переменная для обмена может иметь системный или пользовательский тип.

Заголовок:
```Verilog
class dvl_aep #(type item_type = int) extends dvl_bp #(item_type);
```

## Параметры класса:

| Поле      | Описание                  |
| --------- | ------------------------- |
| item_type | Тип переменной для обмена |

## Поля и функции/задачи класса

Данный класс наследует поля и функции/задачи из базового класса порта [dvl_bp.md](dvl_bp.md).

#### Значение некоторых полей:

| Поле      | Значение  |
| --------- | --------- |
| type_name | "dvl_aep" |

### Функции/Задачи:
| Имя       | Описание                              |
| --------- | ------------------------------------- |
| new       | Конструктор класса                    |
| write     | Функция для односторонней пересылки   |

### Описание функций/задач:

#### new
Конструктор класса для создания экземпляра dvl_aep.

Заголовок:
```Verilog
function new(string p_name = "");
```

Аргументы:
| Имя       | Тип       | Описание  |
| --------- | --------- | --------- |
| p_name    | string    | Имя порта |

#### write
Функция последовательно отправляющая информацию всем портам приёмникам содержащимся в bp_list.

Заголовок:
```Verilog
function void write(ref item_type item);
```

Аргументы:
| Имя   | Тип           | Описание              |
| ----- | ------------- | --------------------- |
| item  | ref item_type | Пересылаемые данные   |

## Использование класса

При объявления экземпляра класса необходимо указать тип переменной подлежащей обмену и имя:
```verilog
    // Создание экземпляра класса с системным типом переменной
    dvl_aep     #(int)      item_aep_0;
    // Создание экземпляра класса с пользовательским типом переменной
    dvl_aep     #(user_t)   item_aep_1;
```

Создание экземпляра класса производится вызовом конструктора:
```verilog
    item_aep_0 = new("item_aep_0");
    item_aep_1 = new("item_aep_1");
```

Для добавления порта приёмника (analysis port) необходимо вызвать функцию connect, при этом переменных для обмена должны совпадать. Также к одному экземпляру класса dvl_aep можно подключать несколько dvl_ap:
```verilog
    // Подключение к item_aep_0 нескольких analysis port
    item_aep_0.connect(item_ap_00);
    item_aep_0.connect(item_ap_01);
    item_aep_0.connect(item_ap_02);

    item_aep_1.connect(item_ap_1);
```

Функция write служит для односторонней пересылки данных:
```verilog
    int counter;
    counter = 8'h55;
    item_aep_0.write(counter);
```

Необходимо отметить, что передаваемая переменная имеет модификатор ref, что означает возможность передачи только переменных, передача констант недоступна.

Данный класс чаще всего используется в классах наследуемых от dvl_mon, то есть мониторов интерфейсов, транзакций, сигналов.