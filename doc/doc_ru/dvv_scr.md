# dvv_scr (subscriber class)

������ ���� �������� �������� ������ ���������� �� �������.

���������:
```Verilog
virtual class dvv_scr #(type item_type = int) extends dvv_bc;
```

## ��������� ������:

| ����      | ��������                  |
| --------- | ------------------------- |
| item_type | ��� ���������� ��� ������ |

## ���� � �������/������ ������

������ ����� ��������� ���� � �������/������ �� �������� ������ ����������� [dvv_bc.md](dvv_bc.md).

### ����:
| ���          | ���                          | ��������                                                          |
| ------------ | ---------------------------- | ----------------------------------------------------------------- |
| item_ap      | dvv_ap #(item_type,scr_type) | ���� ��� ����� ��������� �� analysis export                      |

#### �������� ��������� �����:

| ����      | ��������  |
| --------- | --------- |
| type_name | "dvv_scr" |

### �������/������:
| ���       | ��������                                |
| --------- | --------------------------------------- |
| new       | ����������� ������                      |
| write     | ������� ���������� ��� ����� ��������� |

### �������� �������/�����:

#### new
����������� ������ ��� �������� ���������� dvv_scr.

���������:
```Verilog
function new(string name = "", dvv_bc parent = null);
```

���������:
| ���       | ���       | ��������                  |
| --------- | --------- | ------------------------- |
| name      | string    | ��� ����������            |
| parent    | dvv_bc    | ��������� ������ �������� |

#### write
������� ���������� ��� ����� ��������� �� analysis port. ������ ���� �������������� � ������ �������.

���������:
```Verilog
pure virtual function void write(ref item_type item);
```

���������:
| ���   | ���           | ��������                  |
| ----- | ------------- | ------------------------- |
| item  | ref item_type | ����������� ����������    |

## �������������

������ ����� ������������ ����� ������������. ��������� ������� ������ ������ ��� ����� ��������� �� ������� ���������� ����� ������� write, ������� ���������� ����������� ��������������. ������������� ������� ������� ������ � ����������� ������� ������ ������ ������ ���������, ��� ��� ������� write ����� ������ ���� ��� ����������. � ������ ������������� ������������� ���������� ������ ����� ������ � ������ ���������� ��������������� ���������.
```Verilog
// Example of using dvv_ap_decl macro:

`ifndef EXAMPLE__SV
`define EXAMPLE__SV

`dvv_ap_decl(_oth_1)
`dvv_ap_decl(_oth_2)

class example extends dvv_scr #(int);
    `OBJ_BEGIN( example )

    typedef example example_t;

    int                                 item_0;
    byte                                item_1;
    string                              item_2;
    
    dvv_ap_oth_1    #(byte,example_t)   ex_ap_1;
    dvv_ap_oth_2    #(string,example_t) ex_ap_2;

    extern function new(string name = "", dvv_bc parent = null);

    extern function void write(int item);

    extern function void write_oth_1(int item);
    extern function void write_oth_2(int item);
    
endclass : example

function example::new(string name = "", dvv_bc parent = null);
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