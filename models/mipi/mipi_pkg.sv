/*
*  File            : mipi_pkg.sv
*  Autor           : Vlasov D.V.
*  Data            : 13.05.2021
*  Language        : SystemVerilog
*  Description     : This is mipi package
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

package mipi_pkg;
    
    typedef virtual mipi_if mipi_vif;

    typedef struct {
        byte    val;
        bit     pkt_size;
        string  name;
    } mipi_commands;

    typedef struct {
        byte    ptype;
        int     size;
        byte    ecc;
        bit     psize;
    } mipi_header;

    typedef enum bit {
        short_pkt = '0,
        long_pkt = '1
    } mipi_pkt_size;

    parameter       vsync_start_c       = 8'h01;
    parameter       vsync_end_c         = 8'h11;
    parameter       hsync_start_c       = 8'h21;
    parameter       hsync_end_c         = 8'h31;

    parameter       eotp_c              = 8'h08;

    parameter       shdn_periph_c       = 8'h22;
    parameter       turn_on_periph_c    = 8'h32;

    parameter       color_mode_off_c    = 8'h02;
    parameter       color_mode_on_c     = 8'h12;

    parameter       rgb565p_c           = 8'h0E;
    parameter       rgb666p_c           = 8'h1E;
    parameter       rgb666_c            = 8'h2E;
    parameter       rgb888_c            = 8'h3E;

    parameter       null_packet_c       = 8'h09;
    parameter       blanking_packet_c   = 8'h19;

    parameter       gen_lwrite_c        = 8'h29;
    parameter       dsc_lwrite_c        = 8'h39;

    parameter       gen_read0_c         = 8'h04;
    parameter       gen_read1_c         = 8'h14;
    parameter       gen_read2_c         = 8'h24;

    parameter       gen_write0_c        = 8'h03;
    parameter       gen_write1_c        = 8'h13;
    parameter       gen_write2_c        = 8'h23;
    
    parameter       dsc_write0_c        = 8'h05;
    parameter       dsc_write1_c        = 8'h15;
    
    parameter       dsc_read0_c         = 8'h06;
    
    parameter       reserved_0_c        = 8'h00;
    parameter       reserved_1_c        = 8'hff;

    mipi_commands mipi_cmds [] = '{
        '{ vsync_start_c     , short_pkt , "vsync_start"     },
        '{ vsync_end_c       , short_pkt , "vsync_end"       },
        '{ hsync_start_c     , short_pkt , "hsync_start"     },
        '{ hsync_end_c       , short_pkt , "hsync_end"       },
        
        '{ eotp_c            , short_pkt , "eotp"            },
        
        '{ shdn_periph_c     , short_pkt , "shdn_periph"     },
        '{ turn_on_periph_c  , short_pkt , "turn_on_periph"  },

        '{ color_mode_off_c  , short_pkt , "color_mode_off"  },
        '{ color_mode_on_c   , short_pkt , "color_mode_on"   },

        '{ rgb565p_c         , long_pkt  , "rgb565p"         },
        '{ rgb666p_c         , long_pkt  , "rgb666p"         },
        '{ rgb666_c          , long_pkt  , "rgb666"          },
        '{ rgb888_c          , long_pkt  , "rgb888"          },

        '{ null_packet_c     , long_pkt  , "null_packet"     },
        '{ blanking_packet_c , long_pkt  , "blanking_packet" },
        
        '{ gen_lwrite_c      , long_pkt  , "gen_lwrite"      },
        '{ dsc_lwrite_c      , long_pkt  , "dsc_lwrite"      },
        
        '{ gen_read0_c       , short_pkt , "gen_read0"       },
        '{ gen_read1_c       , short_pkt , "gen_read1"       },
        '{ gen_read2_c       , short_pkt , "gen_read2"       },
        
        '{ gen_write0_c      , short_pkt , "gen_write0"      },
        '{ gen_write1_c      , short_pkt , "gen_write1"      },
        '{ gen_write2_c      , short_pkt , "gen_write2"      },
        
        '{ dsc_write0_c      , short_pkt , "dsc_write0"      },
        '{ dsc_write1_c      , short_pkt , "dsc_write1"      },
        
        '{ dsc_read0_c       , short_pkt , "dsc_read0"       },
        
        '{ reserved_0_c      , short_pkt , "reserved_0"      },
        '{ reserved_1_c      , short_pkt , "reserved_1"      }
    };

    import dvv_vm_pkg::*;
    `include "../dvv_vm/dvv_vm/dvv_macro.svh"

    `include "mipi_dsi_mon.sv"
    
endpackage: mipi_pkg
