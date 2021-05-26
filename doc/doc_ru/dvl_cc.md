# dvv_cc (class creator)
Данный файл содержит описание класса служащего для создание верификационных компонентов через функцию create_obj.

Заголовок:
```Verilog
class dvv_cc #(type class_t) extends dvv_bo;
```

## Параметры класса:

| Поле      | Описание                              |
| --------- | ------------------------------------- |
| class_t   | Тип класса содержащего данный класс   |

## Поля и функции/задачи класса

Данный класс наследует поля и функции/задачи из базового объекта [dvv_bo.md](dvv_bo.md).

### Поля:
| Имя   | Тип               | Описание                                  |
| ----- | ----------------- | ----------------------------------------- |
| me    | static this_type  | Тип компонента содержащего данный класс   |

#### Значение некоторых полей:

| Поле      | Значение  |
| --------- | --------- |
| type_name | "dvv_cc"  |

### Функции/задачи:
| Имя       | Описание                                          |
| --------- | ------------------------------------------------- |
| new       | Функция служащая для создания компонентов         |
| get       | Функция служащая для получения типа компонента    |

### Описание функций/задач:

#### create_obj
Функция служащая для создания компонентов.

Заголовок:
```Verilog
static function class_t create_obj(string name, dvv_bc parent);
```

Аргументы:
| Имя       | Тип       | Описание                  |
| --------- | --------- | ------------------------- |
| name      | string    | Имя компонента            |
| parent    | dvv_bc    | Экземпляр класса родителя |

#### get
Функция служащая для получения типа компонента, содержащего данный класс.

Заголовок:
```Verilog
static function this_type get();
```

## Использование:

Данный класс должен иметь каждый потомок классов dvv_gen, dvv_scr, dvv_mon, dvv_drv, dvv_scb, dvv_test. Добавление класса производится с использованием макроса OBJ_BEGIN(T), например:

```Verilog
class wb_env extends dvv_env;
    `OBJ_BEGIN( wb_env )

    tr_gen                      gen;
    wb_agt                      agt;
    wb_cov                      cov;

    dvv_sock    #(ctrl_trans)   gen2drv_sock;
    dvv_sock    #(ctrl_trans)   drv2gen_sock;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    extern task connect();
    
endclass : wb_env

function wb_env::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task wb_env::build();
    agt = wb_agt ::create::create_obj("wb_agt", this);

    gen = tr_dgen ::create::create_obj("direct_gen", this);

    cov = wb_cov::create::create_obj("wb_cov", this);

    gen2drv_sock = new();
    if( gen2drv_sock == null )
        $fatal("gen2drv_sock not created!");

    drv2gen_sock = new();
    if( drv2gen_sock == null )
        $fatal("drv2gen_sock not created!");
endtask : build

task wb_env::connect();
    agt.drv.item_sock.connect(gen2drv_sock);
    gen.item_sock.connect(gen2drv_sock);

    agt.drv.resp_sock.connect(drv2gen_sock);
    gen.resp_sock.connect(drv2gen_sock);

    agt.mon.item_aep.connect(cov.item_ap);
endtask : connect
```

Использовании данного макроса приводит к добавлению следующего кода в текст класса:

```Verilog
const static string type_name = "wb_env";

typedef dvv_cc #(wb_env) create;

typedef wb_env this_type;

static this_type me = new();

static function create get_type();
    return create::get();
endfunction

static function create get_type_();
    return create::get();
endfunction

static function int add_type();
    type_names["wb_env"] = get_type();
    type_bc["wb_env"] = me;
    return 1;
endfunction : add_type

static bit registred = add_type();

function wb_env create_obj(string name = "", dvv_bc parent = null);
    wb_env obj;
    obj = new(name, parent);
    return obj;
endfunction : create_obj
```