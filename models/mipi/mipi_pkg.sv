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
    } mipi_cmd;

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

    typedef struct {
        mipi_header mipi_h;
        int         rec_arr_p;
        byte        rec_arr_v [int];
    } mipi_item;

    typedef enum {
        mipi_dsi = 0,
        mipi_csi2
    } mipi_types;
    /*
        MIPI DSI 
    */
    typedef enum byte {
        vsync_start_dsi     = 8'h01,
        vsync_end_dsi       = 8'h11,
        hsync_start_dsi     = 8'h21,
        hsync_end_dsi       = 8'h31,

        eotp_dsi            = 8'h08,

        shdn_periph_dsi     = 8'h22,
        turn_on_periph_dsi  = 8'h32,

        color_mode_off_dsi  = 8'h02,
        color_mode_on_dsi   = 8'h12,

        rgb565p_dsi         = 8'h0E,
        rgb666p_dsi         = 8'h1E,
        rgb666_dsi          = 8'h2E,
        rgb888_dsi          = 8'h3E,

        null_packet_dsi     = 8'h09,
        blanking_packet_dsi = 8'h19,

        gen_lwrite_dsi      = 8'h29,
        dsc_lwrite_dsi      = 8'h39,

        gen_read0_dsi       = 8'h04,
        gen_read1_dsi       = 8'h14,
        gen_read2_dsi       = 8'h24,

        gen_write0_dsi      = 8'h03,
        gen_write1_dsi      = 8'h13,
        gen_write2_dsi      = 8'h23,
    
        dsc_write0_dsi      = 8'h05,
        dsc_write1_dsi      = 8'h15,
    
        dsc_read0_dsi       = 8'h06,
    
        reserved_0_dsi      = 8'h00,
        reserved_1_dsi      = 8'hff
    } mipi_dsi_e;

    mipi_cmd mipi_dsi_cmds [] = '{
        '{ vsync_start_dsi      , short_pkt , "vsync_start"     },
        '{ vsync_end_dsi        , short_pkt , "vsync_end"       },
        '{ hsync_start_dsi      , short_pkt , "hsync_start"     },
        '{ hsync_end_dsi        , short_pkt , "hsync_end"       },
        
        '{ eotp_dsi             , short_pkt , "eotp"            },
        
        '{ shdn_periph_dsi      , short_pkt , "shdn_periph"     },
        '{ turn_on_periph_dsi   , short_pkt , "turn_on_periph"  },

        '{ color_mode_off_dsi   , short_pkt , "color_mode_off"  },
        '{ color_mode_on_dsi    , short_pkt , "color_mode_on"   },

        '{ rgb565p_dsi          , long_pkt  , "rgb565p"         },
        '{ rgb666p_dsi          , long_pkt  , "rgb666p"         },
        '{ rgb666_dsi           , long_pkt  , "rgb666"          },
        '{ rgb888_dsi           , long_pkt  , "rgb888"          },

        '{ null_packet_dsi      , long_pkt  , "null_packet"     },
        '{ blanking_packet_dsi  , long_pkt  , "blanking_packet" },
        
        '{ gen_lwrite_dsi       , long_pkt  , "gen_lwrite"      },
        '{ dsc_lwrite_dsi       , long_pkt  , "dsc_lwrite"      },
        
        '{ gen_read0_dsi        , short_pkt , "gen_read0"       },
        '{ gen_read1_dsi        , short_pkt , "gen_read1"       },
        '{ gen_read2_dsi        , short_pkt , "gen_read2"       },
        
        '{ gen_write0_dsi       , short_pkt , "gen_write0"      },
        '{ gen_write1_dsi       , short_pkt , "gen_write1"      },
        '{ gen_write2_dsi       , short_pkt , "gen_write2"      },
        
        '{ dsc_write0_dsi       , short_pkt , "dsc_write0"      },
        '{ dsc_write1_dsi       , short_pkt , "dsc_write1"      },
        
        '{ dsc_read0_dsi        , short_pkt , "dsc_read0"       },
        
        '{ reserved_0_dsi       , short_pkt , "reserved_0"      },
        '{ reserved_1_dsi       , short_pkt , "reserved_1"      }
    };
    /*
        MIPI CSI2 
    */
    typedef enum byte {
        // Synchronization Short Packet Data Types [0x00 : 0x07]
        frame_start_csi         = 8'h00,
        frame_end_csi           = 8'h01,
        line_start_csi          = 8'h02,
        line_end_csi            = 8'h03,
        // Generic Short Packet Data Types [0x08 : 0x0F]
        gen_short_pkt1_csi      = 8'h08,
        gen_short_pkt2_csi      = 8'h09,
        gen_short_pkt3_csi      = 8'h0A,
        gen_short_pkt4_csi      = 8'h0B,
        gen_short_pkt5_csi      = 8'h0C,
        gen_short_pkt6_csi      = 8'h0D,
        gen_short_pkt7_csi      = 8'h0E,
        gen_short_pkt8_csi      = 8'h0F,
        // Generic Long Packet Data Types [0x10 : 0x17]
        gen_long_null_csi       = 8'h10,
        gen_long_blank_csi      = 8'h11,
        gen_long_non_img_csi    = 8'h12,
        // YUV data [0x18 : 0x1F]
        YUV_420_8_csi           = 8'h18,
        YUV_420_10_csi          = 8'h19,
        YUV_L410_8_csi          = 8'h1A,
        YUV_C420_8_csi          = 8'h1C,
        YUV_C420_10_csi         = 8'h1D,
        YUV_422_8_csi           = 8'h1E,
        YUV_422_10_csi          = 8'h1F,
        // RGB data [0x20 : 0x27]
        RGB_444_csi             = 8'h20,
        RGB_555_csi             = 8'h21,
        RGB_565_csi             = 8'h22,
        RGB_666_csi             = 8'h23,
        RGB_888_csi             = 8'h24,
        // RAW data [0x28 : 0x2F]
        RAW6_csi                = 8'h28,
        RAW7_csi                = 8'h29,
        RAW8_csi                = 8'h2A,
        RAW10_csi               = 8'h2B,
        RAW12_csi               = 8'h2C,
        RAW14_csi               = 8'h2D,
        // User Defined data [0x30 : 0x37]
        usr_def1_csi            = 8'h30,
        usr_def2_csi            = 8'h31,
        usr_def3_csi            = 8'h32,
        usr_def4_csi            = 8'h33,
        usr_def5_csi            = 8'h34,
        usr_def6_csi            = 8'h35,
        usr_def7_csi            = 8'h36,
        usr_def8_csi            = 8'h37
        // Reserved [0x38 : 0x3F]
    } mipi_csi2_e;

    mipi_cmd mipi_csi2_cmds [] = '{
        // Synchronization Short Packet Data Types [0x00 : 0x07]
        '{ frame_start_csi      , short_pkt , "frame_start"         },
        '{ frame_end_csi        , short_pkt , "frame_end"           },
        '{ line_start_csi       , short_pkt , "line_start"          },
        '{ line_end_csi         , short_pkt , "line_end"            },
        // Generic Short Packet Data Types [0x08 : 0x0F]
        '{ gen_short_pkt1_csi   , short_pkt , "gen_short_pkt1"      },
        '{ gen_short_pkt2_csi   , short_pkt , "gen_short_pkt2"      },
        '{ gen_short_pkt3_csi   , short_pkt , "gen_short_pkt3"      },
        '{ gen_short_pkt4_csi   , short_pkt , "gen_short_pkt4"      },
        '{ gen_short_pkt5_csi   , short_pkt , "gen_short_pkt5"      },
        '{ gen_short_pkt6_csi   , short_pkt , "gen_short_pkt6"      },
        '{ gen_short_pkt7_csi   , short_pkt , "gen_short_pkt7"      },
        '{ gen_short_pkt8_csi   , short_pkt , "gen_short_pkt8"      },
        // Generic Long Packet Data Types [0x10 : 0x17]
        '{ gen_long_null_csi    , long_pkt  , "gen_long_null"       },
        '{ gen_long_blank_csi   , long_pkt  , "gen_long_blank"      },
        '{ gen_long_non_img_csi , long_pkt  , "gen_long_non_img"    },
        // YUV data [0x18 : 0x1F]
        '{ YUV_420_8_csi        , long_pkt  , "YUV_420_8"           },
        '{ YUV_420_10_csi       , long_pkt  , "YUV_420_10"          },
        '{ YUV_L410_8_csi       , long_pkt  , "YUV_L410_8"          },
        '{ YUV_C420_8_csi       , long_pkt  , "YUV_C420_8"          },
        '{ YUV_C420_10_csi      , long_pkt  , "YUV_C420_10"         },
        '{ YUV_422_8_csi        , long_pkt  , "YUV_422_8"           },
        '{ YUV_422_10_csi       , long_pkt  , "YUV_422_10"          },
        // RGB data [0x20 : 0x27]
        '{ RGB_444_csi          , long_pkt  , "RGB_444"             },
        '{ RGB_555_csi          , long_pkt  , "RGB_555"             },
        '{ RGB_565_csi          , long_pkt  , "RGB_565"             },
        '{ RGB_666_csi          , long_pkt  , "RGB_666"             },
        '{ RGB_888_csi          , long_pkt  , "RGB_888"             },
        // RAW data [0x28 : 0x2F]
        '{ RAW6_csi             , long_pkt  , "RAW6"                },
        '{ RAW7_csi             , long_pkt  , "RAW7"                },
        '{ RAW8_csi             , long_pkt  , "RAW8"                },
        '{ RAW10_csi            , long_pkt  , "RAW10"               },
        '{ RAW12_csi            , long_pkt  , "RAW12"               },
        '{ RAW14_csi            , long_pkt  , "RAW14"               },
        // User Defined data [0x30 : 0x37]
        '{ usr_def1_csi         , long_pkt  , "usr_def1"            },
        '{ usr_def2_csi         , long_pkt  , "usr_def2"            },
        '{ usr_def3_csi         , long_pkt  , "usr_def3"            },
        '{ usr_def4_csi         , long_pkt  , "usr_def4"            },
        '{ usr_def5_csi         , long_pkt  , "usr_def5"            },
        '{ usr_def6_csi         , long_pkt  , "usr_def6"            },
        '{ usr_def7_csi         , long_pkt  , "usr_def7"            },
        '{ usr_def8_csi         , long_pkt  , "usr_def8"            }
    };

    import dvl_sv_pkg::*;
    `include "../../dvl_sv/dvl_macro.svh"

    `include "mipi_base_mon.sv"
    `include "mipi_mon.sv"
    `include "mipi_dsi_mon.sv"
    `include "mipi_csi2_mon.sv"
    
endpackage : mipi_pkg
