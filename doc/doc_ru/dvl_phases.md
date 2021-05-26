# dvv_phases (phases classes (build, connect, run, cleanup, report))
������ ���� �������� �������� ������� ��� ���������� �����.

���������:
```Verilog
class dvv_build_phase extends dvv_phase;
class dvv_connect_phase extends dvv_phase;
class dvv_run_phase extends dvv_phase;
class dvv_clean_up_phase extends dvv_phase;
class dvv_report_phase extends dvv_phase;
```

## ���� � �������/������ ������  

������ ����� ��������� ���� � �������/������ �� �������� ������ ���� [dvv_phase.md](dvv_phase.md).

### ����:
| ���       | ���                               | ��������                          |
| --------- | --------------------------------- | --------------------------------- |
| inst      | local static dvv_build_phase      | ��������� ���� dvv_build_phase    |
| inst      | local static dvv_connect_phase    | ��������� ���� dvv_connect_phase  |
| inst      | local static dvv_run_phase        | ��������� ���� dvv_run_phase      |
| inst      | local static dvv_clean_up_phase   | ��������� ���� dvv_clean_up_phase |
| inst      | local static dvv_report_phase     | ��������� ���� dvv_report_phase   |

#### �������� ��������� �����:

| ����      | ��������              |
| --------- | --------------------- |
| type_name | "dvv_build_phase"     |
| type_name | "dvv_connect_phase"   |
| type_name | "dvv_run_phase"       |
| type_name | "dvv_clean_up_phase"  |
| type_name | "dvv_report_phase"    |

### �������/������:
����� �������� ��������� �������/������:
| ���       | ��������                      |
| --------- | ----------------------------- |
| new       | ����������� ������            |
| create    | ������ ��� �������� ����      |
| exec      | ������ ��� ���������� ����    |

### �������� �������/�����:

#### new
����������� ������ ��� �������� ���������� dvv_build_phase/dvv_connect_phase/dvv_run_phase/dvv_clean_up_phase/dvv_report_phase.

���������:
```Verilog
function new(string name = "", dvv_bc parent = null);
```

���������:
| ���       | ���       | ��������                  |
| --------- | --------- | ------------------------- |
| name      | string    | ��� ����������            |
| parent    | dvv_bc    | ��������� ������ �������� |

#### create
������ ��� �������� ���������� inst dvv_build_phase/dvv_connect_phase/dvv_run_phase/dvv_clean_up_phase/dvv_report_phase.

���������:
```Verilog
function dvv_build_phase::create(string name = "", dvv_bc parent = null);
function dvv_connect_phase::create(string name = "", dvv_bc parent = null);
function dvv_run_phase::create(string name = "", dvv_bc parent = null);
function dvv_clean_up_phase::create(string name = "", dvv_bc parent = null);
function dvv_report_phase::create(string name = "", dvv_bc parent = null);
```

���������:
| ���       | ���       | ��������                  |
| --------- | --------- | ------------------------- |
| name      | string    | ��� ����������            |
| parent    | dvv_bc    | ��������� ������ �������� |

#### exec
������ ��� ���������� ����.

���������:
```Verilog
virtual task exec();
```