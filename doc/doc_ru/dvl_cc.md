# dvl_cc (class creator)
������ ���� �������� �������� ������ ��������� ��� �������� ��������������� ����������� ����� ������� create_obj.

���������:
```Verilog
class dvl_cc #(type class_t) extends dvl_bo;
```

## ��������� ������:

| ����      | ��������                              |
| --------- | ------------------------------------- |
| class_t   | ��� ������ ����������� ������ �����   |

## ���� � �������/������ ������

������ ����� ��������� ���� � �������/������ �� �������� ������� [dvl_bo.md](dvl_bo.md).

### ����:
| ���   | ���               | ��������                                  |
| ----- | ----------------- | ----------------------------------------- |
| me    | static this_type  | ��� ���������� ����������� ������ �����   |

#### �������� ��������� �����:

| ����      | ��������  |
| --------- | --------- |
| type_name | "dvl_cc"  |

### �������/������:
| ���       | ��������                                          |
| --------- | ------------------------------------------------- |
| new       | ������� �������� ��� �������� �����������         |
| get       | ������� �������� ��� ��������� ���� ����������    |

### �������� �������/�����:

#### create_obj
������� �������� ��� �������� �����������.

���������:
```Verilog
static function class_t create_obj(string name, dvl_bc parent);
```

���������:
| ���       | ���       | ��������                  |
| --------- | --------- | ------------------------- |
| name      | string    | ��� ����������            |
| parent    | dvl_bc    | ��������� ������ �������� |

#### get
������� �������� ��� ��������� ���� ����������, ����������� ������ �����.

���������:
```Verilog
static function this_type get();
```

## �������������:

������ ����� ������ ����� ������ ������� ������� dvl_gen, dvl_scr, dvl_mon, dvl_drv, dvl_scb, dvl_test. ���������� ������ ������������ � �������������� ������� OBJ_BEGIN(T), ��������:

```Verilog
class wb_env extends dvl_env;
    `OBJ_BEGIN( wb_env )

    tr_gen                      gen;
    wb_agt                      agt;
    wb_cov                      cov;

    dvl_sock    #(ctrl_trans)   gen2drv_sock;
    dvl_sock    #(ctrl_trans)   drv2gen_sock;

    extern function new(string name = "", dvl_bc parent = null);

    extern task build();
    extern task connect();
    
endclass : wb_env

function wb_env::new(string name = "", dvl_bc parent = null);
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

������������� ������� ������� �������� � ���������� ���������� ���� � ����� ������:

```Verilog
const static string type_name = "wb_env";

typedef dvl_cc #(wb_env) create;

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

function wb_env create_obj(string name = "", dvl_bc parent = null);
    wb_env obj;
    obj = new(name, parent);
    return obj;
endfunction : create_obj
```