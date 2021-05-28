# dvl_scr (subscriber class)

Данный файл содержит описание класса подписчика на событие.

Заголовок:
```Verilog
virtual class dvl_scr #(type item_type = int) extends dvl_bc;
```

## Параметры класса:

| Поле      | Описание                  |
| --------- | ------------------------- |
| item_type | Тип переменной для обмена |

## Поля и функции/задачи класса

Данный класс наследует поля и функции/задачи из базового класса компонентов [dvl_bc.md](dvl_bc.md).

### Поля:
| Имя          | Тип                          | Описание                                                          |
| ------------ | ---------------------------- | ----------------------------------------------------------------- |
| item_ap      | dvl_ap #(item_type,scr_type) | Порт для приёма сообщений от analysis export                      |

#### Значение некоторых полей:

| Поле      | Значение  |
| --------- | --------- |
| type_name | "dvl_scr" |

### Функции/задачи:
| Имя       | Описание                                |
| --------- | --------------------------------------- |
| new       | Конструктор класса                      |
| write     | Функция вызываемая при приёме сообщения |

### Описание функций/задач:

#### new
Конструктор класса для создания экземпляра dvl_scr.

Заголовок:
```Verilog
function new(string name = "", dvl_bc parent = null);
```

Аргументы:
| Имя       | Тип       | Описание                  |
| --------- | --------- | ------------------------- |
| name      | string    | Имя компонента            |
| parent    | dvl_bc    | Экземпляр класса родителя |

#### write
Функция вызываемая при приёме сообщения по analysis port. Должна быть переопределена в классе потомке.

Заголовок:
```Verilog
pure virtual function void write(ref item_type item);
```

Аргументы:
| Имя   | Тип           | Описание                  |
| ----- | ------------- | ------------------------- |
| item  | ref item_type | Принимаемая переменная    |

## Использование

Данный класс используется через наследование. Экземпляр потомка класса служит для приёма сообщений от внешних источников через функцию write, которую необходимо обязательно переопределить. Использование потомка данного класса с несколькими разными типами данных портов запрещено, так как функция write имеет только один тип переменной. В случае необходимости использования нескольких разных типов данных у портов необходимо воспользоваться макросами.
```Verilog
// Example of using dvl_ap_decl macro:

`ifndef EXAMPLE__SV
`define EXAMPLE__SV

`dvl_ap_decl(_oth_1)
`dvl_ap_decl(_oth_2)

class example extends dvl_scr #(int);
    `OBJ_BEGIN( example )

    typedef example example_t;

    int                                 item_0;
    byte                                item_1;
    string                              item_2;
    
    dvl_ap_oth_1    #(byte,example_t)   ex_ap_1;
    dvl_ap_oth_2    #(string,example_t) ex_ap_2;

    extern function new(string name = "", dvl_bc parent = null);

    extern function void write(int item);

    extern function void write_oth_1(int item);
    extern function void write_oth_2(int item);
    
endclass : example

function example::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
    item_ap = new(this,"item_ap");
    ex_ap_1 = new(this,"ex_ap_1");
    ex_ap_2 = new(this,"ex_ap_2");
endfunction : new

function void example::write(int item);
    item_0 = item;
    $info("Received item = %h", this.item_0);
endfunction : write

function void example::write_oth_1(byte item);
    item_1 = item;
    $info("Received item = %h", this.item_1);
endfunction : write_oth_1

function void example::write_oth_2(string item);
    item_2 = item;
    $info("Received item = %s", this.item_2);
endfunction : write_oth_2

`endif // EXAMPLE__SV
```