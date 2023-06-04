// Code your design here
module AddrReg(
      input[7:0] addr,
      input clk,
      input plar,
      output reg[7:0] data
    );
      always @(posedge clk)
        if(plar)
          data<=addr;
    endmodule

module WordReg(
      input[7:0] addr,
      input clk,
      input plwr,
      output reg[7:0] data
    );
      always @(posedge clk)
        if(plwr)
          data<=addr;
    endmodule

module AddrMux(
    input[7:0] di0,
    input[7:0] di1,
    input sela,
    output[7:0] do
      );
      assign do=(sela==0)?di0:di1;
      endmodule
  
module WordMux(
    input[7:0] di0,
    input[7:0] di1,
    input selw,
    output[7:0] do
      );
      assign do=(selw==0)?di0:di1;
        endmodule

module CtrlReg(
  input clk,
  input[2:0] di,
  input plcr,
  output reg[2:0] do
);
  always @(posedge clk)
    if(plcr)
      do<=di;
endmodule

module DataMux(
    input[7:0] di0,
    input[7:0] di1,
    input[7:0] di2,
    input[1:0] seld,
    output reg[7:0] do
    );
    always @(di0 or di1 or di2 or seld)
         casex(seld)
           2'b00:do=di0;
           2'b01:do=di1;
           2'b1x:do=di2;
         endcase
    endmodule
module Numarator(clk,reset,pl,enable,inc,dec,in,CIn,contt,out);
  input clk,reset,pl,enable,inc,dec,CIn;
  input [7:0] in;
  output reg contt;
  output reg[7:0] out;
  //contt<=1;
  always @(out or inc or dec)
  if((out==255 && inc==1)|| (out==0 && dec==1))
    contt<=1'b0;
  else
    contt<=1'b1;
  always @(posedge clk)
    casex({reset,pl,enable,inc,dec,CIn})
		6'b1xxxxx:begin out<=8'b0;
        //  contt<=1'b1;
        end
      	6'b01xxxx:begin
          out<=in;
       //   contt<=1'b1;
        end
      6'b001100:begin
       // if(out==255)
        //  contt<=1'b0;
       // else
       //   contt<=1'b1;
        out<=out+1;
      end
      6'b001010:begin
       // if(out==0)
       //   contt<=1'b0;
       // else
       //   contt<=1'b1;
        out<=out-1;
      end
      default:begin 
        out<=out;
      // contt<=1'b1;
      end
    endcase
endmodule
module done_gen(
  input[7:0] dowc,dowr,doac,
  input[1:0] mode,
  input cinw,
  output reg done
);
  always@(dowc or dowr or doac or cinw or mode)
    casex({mode,cinw})
      3'b00_0:done=(dowc===8'b1);
      3'b00_1:done=~(|dowc);
      3'b01_0:done=(dowc+1===dowr);
      3'b01_1:done=(dowc==dowr);
      3'b10_x:done=(dowc===doac);
      3'b11_x:done=1'b0;
    endcase
endmodule
             
module InstrDec(
  input[2:0] instr,
  input[2:0] cr,
  output reg oedata,
  output reg plar,
  output reg plwr,
  output reg sela,
  output reg selw,
  output reg plcr,
  output reg[1:0] seld,
  output reg plac,
  output reg ena,
  output reg inca,
  output reg deca,
  output reg resw,
  output reg plwc,
  output reg enw,
  output reg incw,
  output reg decw
);
  always@(instr or cr)
    casex({instr,cr})
      6'b000_xxx:begin
        {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_0_0_1_00_0_0_0_0_0_0_0_0_0_0;
      end
      6'b001_xxx:begin      
        {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_0_0_0_10_0_0_0_0_0_0_0_0_0_1;
      end
      6'b010_xxx:begin      
        {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_0_0_0_01_0_0_0_0_0_0_0_0_0_1;
      end
      6'b011_xxx:begin      
        {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_0_0_0_00_0_0_0_0_0_0_0_0_0_1;
      end
      6'b100_xx0,6'b100_x11:begin      
        {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_1_1_0_00_1_0_0_0_0_1_0_0_0_0;
      end
      
      6'b100_x01:begin      
        {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_1_0_0_00_1_0_0_0_1_0_0_0_0_0;
      end
  6'b101_xxx:begin      
    {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b1_0_0_0_0_00_1_0_0_0_0_0_0_0_0_0;
      end
  6'b110_xx0,6'b110_x11:begin      
    {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_1_0_0_0_00_0_0_0_0_0_1_0_0_0_0;
      end
   6'b110_x01:begin      
     {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_1_0_0_0_00_0_0_0_0_1_0_0_0_0_0;
      end
    6'b111_000:begin      
      {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_0_0_0_00_0_1_1_0_0_0_1_0_1_0;
      end
     6'b111_0x1:begin      
       {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_0_0_0_00_0_1_1_0_0_0_1_1_0_0;
      end
     6'b111_010:begin      
       {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_0_0_0_00_0_1_1_0_0_0_0_0_0_0;
     end
     6'b111_100:begin      
       {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_0_0_0_00_0_1_0_1_0_0_1_0_1_0;
      end
     6'b111_1x1:begin      
       {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_0_0_0_00_0_1_0_1_0_0_1_1_0_0;
      end
           6'b111_110:begin      
             {plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata}<=17'b0_0_0_0_0_00_0_1_0_1_0_0_0_0_0_0;
      end
      endcase
endmodule
             
/*
Intrari:datain, clk, i[2:0],ciw,cia,
Iesiri:cout,addr,dataout,oedata*/
module implementare2940(
  input clk,
  input[7:0] DataIn,
  input[2:0] instr,
  input aci,
  input wci,
  output aco,
  output wco,
  output[7:0] ac,
  output[7:0] DataOut,
  output oedata
        );
  wire plar,plwr,sela,selw,plcr,plac,ena,inca,deca,resw,plwc,enw,incw,decw;
  wire[1:0] seld;
  wire[2:0] cr;
  wire[7:0] wc,wcr,ar;
  wire[7:0] muxa,muxw;
  InstrDec InstrDec_inst(instr,cr,oedata,plar,plwr,sela,selw,plcr,seld,plac,ena,inca,deca,resw,plwc,enw,incw,decw);
  CtrlReg CtrlReg_inst(clk,DataIn[2:0],plcr,cr);
  AddrReg AddrReg_inst(DataIn,clk,plar,ar);
  WordReg WordReg_inst(DataIn,clk,plwr,wcr);
  AddrMux AddrMux_inst(DataIn,ar,sela,muxa);
  WordMux WordMux_inst(DataIn,wcr,selw,muxw);
  Numarator AddrCount(clk,0,plac,ena,inca,deca,muxa,aci,aco,ac);
  Numarator WordCount(clk,resw,plwc,enw,incw,decw,muxw,wci,wco,wc);
  DataMux DataMux_inst(ac,wc,{5'b11111,cr},seld,DataOut);
endmodule             