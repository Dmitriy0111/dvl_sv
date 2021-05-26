# dvl_phases (phases classes (build, connect, run, cleanup, report))
������ ���� �������� �������� ������� ��� ���������� �����.

���������:
```Verilog
class dvl_build_phase extends dvl_phase;
class dvl_connect_phase extends dvl_phase;
class dvl_run_phase extends dvl_phase;
class dvl_clean_up_phase extends dvl_phase;
class dvl_report_phase extends dvl_phase;
```

## ���� � �������/������ ������  

������ ����� ��������� ���� � �������/������ �� �������� ������ ���� [dvl_phase.md](dvl_phase.md).

### ����:
| ���       | ���                               | ��������                          |
| --------- | --------------------------------- | --------------------------------- |
| inst      | local static dvl_build_phase      | ��������� ���� dvl_build_phase    |
| inst      | local static dvl_connect_phase    | ��������� ���� dvl_connect_phase  |
| inst      | local static dvl_run_phase        | ��������� ���� dvl_run_phase      |
| inst      | local static dvl_clean_up_phase   | ��������� ���� dvl_clean_up_phase |
| inst      | local static dvl_report_phase     | ��������� ���� dvl_report_phase   |

#### �������� ��������� �����:

| ����      | ��������              |
| --------- | --------------------- |
| type_name | "dvl_build_phase"     |
| type_name | "dvl_connect_phase"   |
| type_name | "dvl_run_phase"       |
| type_name | "dvl_clean_up_phase"  |
| type_name | "dvl_report_phase"    |

### �������/������:
����� �������� ��������� �������/������:
| ���       | ��������                      |
| --------- | ----------------------------- |
| new       | ����������� ������            |
| create    | ������ ��� �������� ����      |
| exec      | ������ ��� ���������� ����    |

### �������� �������/�����:

#### new
����������� ������ ��� �������� ���������� dvl_build_phase/dvl_connect_phase/dvl_run_phase/dvl_clean_up_phase/dvl_report_phase.

���������:
```Verilog
function new(string name = "", dvl_bc parent = null);
```

���������:
| ���       | ���       | ��������                  |
| --------- | --------- | ------------------------- |
| name      | string    | ��� ����������            |
| parent    | dvl_bc    | ��������� ������ �������� |

#### create
������ ��� �������� ���������� inst dvl_build_phase/dvl_connect_phase/dvl_run_phase/dvl_clean_up_phase/dvl_report_phase.

���������:
```Verilog
function dvl_build_phase::create(string name = "", dvl_bc parent = null);
function dvl_connect_phase::create(string name = "", dvl_bc parent = null);
function dvl_run_phase::create(string name = "", dvl_bc parent = null);
function dvl_clean_up_phase::create(string name = "", dvl_bc parent = null);
function dvl_report_phase::create(string name = "", dvl_bc parent = null);
```

���������:
| ���       | ���       | ��������                  |
| --------- | --------- | ------------------------- |
| name      | string    | ��� ����������            |
| parent    | dvl_bc    | ��������� ������ �������� |

#### exec
������ ��� ���������� ����.

���������:
```Verilog
virtual task exec();
```