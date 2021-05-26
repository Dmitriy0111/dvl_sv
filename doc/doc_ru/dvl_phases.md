# dvl_phases (phases classes (build, connect, run, cleanup, report))
Данный файл содержит описание классов фаз выполнения теста.

Заголовок:
```Verilog
class dvl_build_phase extends dvl_phase;
class dvl_connect_phase extends dvl_phase;
class dvl_run_phase extends dvl_phase;
class dvl_clean_up_phase extends dvl_phase;
class dvl_report_phase extends dvl_phase;
```

## Поля и функции/задачи класса  

Данный класс наследует поля и функции/задачи из базового класса фазы [dvl_phase.md](dvl_phase.md).

### Поля:
| Имя       | Тип                               | Описание                          |
| --------- | --------------------------------- | --------------------------------- |
| inst      | local static dvl_build_phase      | Экземпляр фазы dvl_build_phase    |
| inst      | local static dvl_connect_phase    | Экземпляр фазы dvl_connect_phase  |
| inst      | local static dvl_run_phase        | Экземпляр фазы dvl_run_phase      |
| inst      | local static dvl_clean_up_phase   | Экземпляр фазы dvl_clean_up_phase |
| inst      | local static dvl_report_phase     | Экземпляр фазы dvl_report_phase   |

#### Значение некоторых полей:

| Поле      | Значение              |
| --------- | --------------------- |
| type_name | "dvl_build_phase"     |
| type_name | "dvl_connect_phase"   |
| type_name | "dvl_run_phase"       |
| type_name | "dvl_clean_up_phase"  |
| type_name | "dvl_report_phase"    |

### Функции/Задачи:
Класс содержит следующие функции/задачи:
| Имя       | Описание                      |
| --------- | ----------------------------- |
| new       | Конструктор класса            |
| create    | Задача для создания фазы      |
| exec      | Задача для исполнения фазы    |

### Описание функций/задач:

#### new
Конструктор класса для создания экземпляра dvl_build_phase/dvl_connect_phase/dvl_run_phase/dvl_clean_up_phase/dvl_report_phase.

Заголовок:
```Verilog
function new(string name = "", dvl_bc parent = null);
```

Аргументы:
| Имя       | Тип       | Описание                  |
| --------- | --------- | ------------------------- |
| name      | string    | Имя компонента            |
| parent    | dvl_bc    | Экземпляр класса родителя |

#### create
Задача для создания экземпляра inst dvl_build_phase/dvl_connect_phase/dvl_run_phase/dvl_clean_up_phase/dvl_report_phase.

Заголовок:
```Verilog
function dvl_build_phase::create(string name = "", dvl_bc parent = null);
function dvl_connect_phase::create(string name = "", dvl_bc parent = null);
function dvl_run_phase::create(string name = "", dvl_bc parent = null);
function dvl_clean_up_phase::create(string name = "", dvl_bc parent = null);
function dvl_report_phase::create(string name = "", dvl_bc parent = null);
```

Аргументы:
| Имя       | Тип       | Описание                  |
| --------- | --------- | ------------------------- |
| name      | string    | Имя компонента            |
| parent    | dvl_bc    | Экземпляр класса родителя |

#### exec
Задача для исполнения фазы.

Заголовок:
```Verilog
virtual task exec();
```