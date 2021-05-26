# dvv_phases (phases classes (build, connect, run, cleanup, report))
Данный файл содержит описание классов фаз выполнения теста.

Заголовок:
```Verilog
class dvv_build_phase extends dvv_phase;
class dvv_connect_phase extends dvv_phase;
class dvv_run_phase extends dvv_phase;
class dvv_clean_up_phase extends dvv_phase;
class dvv_report_phase extends dvv_phase;
```

## Поля и функции/задачи класса  

Данный класс наследует поля и функции/задачи из базового класса фазы [dvv_phase.md](dvv_phase.md).

### Поля:
| Имя       | Тип                               | Описание                          |
| --------- | --------------------------------- | --------------------------------- |
| inst      | local static dvv_build_phase      | Экземпляр фазы dvv_build_phase    |
| inst      | local static dvv_connect_phase    | Экземпляр фазы dvv_connect_phase  |
| inst      | local static dvv_run_phase        | Экземпляр фазы dvv_run_phase      |
| inst      | local static dvv_clean_up_phase   | Экземпляр фазы dvv_clean_up_phase |
| inst      | local static dvv_report_phase     | Экземпляр фазы dvv_report_phase   |

#### Значение некоторых полей:

| Поле      | Значение              |
| --------- | --------------------- |
| type_name | "dvv_build_phase"     |
| type_name | "dvv_connect_phase"   |
| type_name | "dvv_run_phase"       |
| type_name | "dvv_clean_up_phase"  |
| type_name | "dvv_report_phase"    |

### Функции/Задачи:
Класс содержит следующие функции/задачи:
| Имя       | Описание                      |
| --------- | ----------------------------- |
| new       | Конструктор класса            |
| create    | Задача для создания фазы      |
| exec      | Задача для исполнения фазы    |

### Описание функций/задач:

#### new
Конструктор класса для создания экземпляра dvv_build_phase/dvv_connect_phase/dvv_run_phase/dvv_clean_up_phase/dvv_report_phase.

Заголовок:
```Verilog
function new(string name = "", dvv_bc parent = null);
```

Аргументы:
| Имя       | Тип       | Описание                  |
| --------- | --------- | ------------------------- |
| name      | string    | Имя компонента            |
| parent    | dvv_bc    | Экземпляр класса родителя |

#### create
Задача для создания экземпляра inst dvv_build_phase/dvv_connect_phase/dvv_run_phase/dvv_clean_up_phase/dvv_report_phase.

Заголовок:
```Verilog
function dvv_build_phase::create(string name = "", dvv_bc parent = null);
function dvv_connect_phase::create(string name = "", dvv_bc parent = null);
function dvv_run_phase::create(string name = "", dvv_bc parent = null);
function dvv_clean_up_phase::create(string name = "", dvv_bc parent = null);
function dvv_report_phase::create(string name = "", dvv_bc parent = null);
```

Аргументы:
| Имя       | Тип       | Описание                  |
| --------- | --------- | ------------------------- |
| name      | string    | Имя компонента            |
| parent    | dvv_bc    | Экземпляр класса родителя |

#### exec
Задача для исполнения фазы.

Заголовок:
```Verilog
virtual task exec();
```