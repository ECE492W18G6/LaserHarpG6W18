// (C) 2001-2017 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/17.0std/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2017/01/22 $
// $Author: swbranch $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module soc_system_mm_interconnect_0_router_default_decode
  #(
     parameter DEFAULT_CHANNEL = 16,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 14 
   )
  (output [95 - 91 : 0] default_destination_id,
   output [17-1 : 0] default_wr_channel,
   output [17-1 : 0] default_rd_channel,
   output [17-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[95 - 91 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 17'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 17'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 17'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module soc_system_mm_interconnect_0_router
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [120-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [120-1    : 0] src_data,
    output reg [17-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 56;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 95;
    localparam PKT_DEST_ID_L = 91;
    localparam PKT_PROTECTION_H = 110;
    localparam PKT_PROTECTION_L = 108;
    localparam ST_DATA_W = 120;
    localparam ST_CHANNEL_W = 17;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 59;
    localparam PKT_TRANS_READ  = 60;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h10 - 64'h0); 
    localparam PAD1 = log2ceil(64'h108 - 64'h100); 
    localparam PAD2 = log2ceil(64'h202 - 64'h200); 
    localparam PAD3 = log2ceil(64'h310 - 64'h300); 
    localparam PAD4 = log2ceil(64'h410 - 64'h400); 
    localparam PAD5 = log2ceil(64'h510 - 64'h500); 
    localparam PAD6 = log2ceil(64'h610 - 64'h600); 
    localparam PAD7 = log2ceil(64'h1004 - 64'h1000); 
    localparam PAD8 = log2ceil(64'h1104 - 64'h1100); 
    localparam PAD9 = log2ceil(64'h1204 - 64'h1200); 
    localparam PAD10 = log2ceil(64'h1304 - 64'h1300); 
    localparam PAD11 = log2ceil(64'h1404 - 64'h1400); 
    localparam PAD12 = log2ceil(64'h1504 - 64'h1500); 
    localparam PAD13 = log2ceil(64'h1604 - 64'h1600); 
    localparam PAD14 = log2ceil(64'h1704 - 64'h1700); 
    localparam PAD15 = log2ceil(64'h1804 - 64'h1800); 
    localparam PAD16 = log2ceil(64'h2001 - 64'h2000); 
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h2001;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;

    localparam RG = RANGE_ADDR_WIDTH-1;
    localparam REAL_ADDRESS_RANGE = OPTIMIZED_ADDR_H - PKT_ADDR_L;

      reg [PKT_ADDR_W-1 : 0] address;
      always @* begin
        address = {PKT_ADDR_W{1'b0}};
        address [REAL_ADDRESS_RANGE:0] = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];
      end   

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;
    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [17-1 : 0] default_src_channel;




    // -------------------------------------------------------
    // Write and read transaction signals
    // -------------------------------------------------------
    wire read_transaction;
    assign read_transaction  = sink_data[PKT_TRANS_READ];


    soc_system_mm_interconnect_0_router_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_wr_channel   (),
      .default_rd_channel   (),
      .default_src_channel  (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;
        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;

        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

    // ( 0x0 .. 0x10 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 14'h0   ) begin
            src_channel = 17'b10000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0x100 .. 0x108 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 14'h100  && read_transaction  ) begin
            src_channel = 17'b00010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x200 .. 0x202 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 14'h200   ) begin
            src_channel = 17'b00000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0x300 .. 0x310 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 14'h300   ) begin
            src_channel = 17'b00100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x400 .. 0x410 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 14'h400   ) begin
            src_channel = 17'b00000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0x500 .. 0x510 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 14'h500   ) begin
            src_channel = 17'b00000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0x600 .. 0x610 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 14'h600   ) begin
            src_channel = 17'b01000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x1000 .. 0x1004 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 14'h1000   ) begin
            src_channel = 17'b00000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x1100 .. 0x1104 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 14'h1100   ) begin
            src_channel = 17'b00000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x1200 .. 0x1204 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 14'h1200   ) begin
            src_channel = 17'b00000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x1300 .. 0x1304 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 14'h1300   ) begin
            src_channel = 17'b00000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x1400 .. 0x1404 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 14'h1400   ) begin
            src_channel = 17'b00000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x1500 .. 0x1504 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 14'h1500   ) begin
            src_channel = 17'b00000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x1600 .. 0x1604 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 14'h1600   ) begin
            src_channel = 17'b00000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x1700 .. 0x1704 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 14'h1700   ) begin
            src_channel = 17'b00001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x1800 .. 0x1804 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 14'h1800   ) begin
            src_channel = 17'b00000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x2000 .. 0x2001 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 14'h2000  && read_transaction  ) begin
            src_channel = 17'b00000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

end


    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


