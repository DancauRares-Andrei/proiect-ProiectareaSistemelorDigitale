// Code your testbench here
// or browse Examples
module S1();
  reg clkt;
  wire oedatat;
  wire aco,wco;
  reg wci,aci;
  wire[7:0] act,Dataoutt;
  reg[2:0] instrt;
  reg[7:0] DataInt;
  implementare2940 implementare2940_inst(clkt,DataInt,instrt,aci,wci,aco,wco,act,Dataoutt,oedatat);
  initial begin
    //Initializare cr cu 2 si permitere numarare adrese si word
    #0 DataInt<=8'b00000010;instrt<=3'b000; aci<=1'b0; wci<=1'b0;
    //I:000 CR:010
    //Incarcare in registrul de adresa si a numaratorului de adrese valoarea 2
    #10 instrt<=3'b101;
    //I:101 CR:010
    //Enable count la numaratorul de adrese
   #10 instrt<=3'b111;
    //I:111 CR:010
    //Incarcare in registrul de adresa si a numaratorului de adrese valoarea 2
   #30 instrt<=3'b101;
    //I:101 CR:010
    //Incarcare in registrul de cuvinte si in numaratorul de cuvinte valoarea 2
   #10 instrt<=3'b110;
    //I:110 CR:010
    //Copierea in DataOut a`valorii din cr 
   #10 instrt<=3'b001;
    //I:001 CR:010
    //Initializarea lui cr cu 1
   #10 DataInt<=8'b00000001;instrt<=3'b000;
    //I:000 CR:001
    //Enable numarare prin incrementare a numaratoarelor de word si adresa
   #10 instrt<=3'b111;
    //I:111 CR:001
    //Incarcare in cr a valorii 4
   #30 DataInt<=8'b00000100;instrt<=3'b000;
    //I:000 CR:100
    //Enable numarare prin decrementare a numaratoarelor de word si adresa
   #10 instrt<=3'b111;
    //I:111 CR:100
    //Incarcare in cr a valorii 7
   #30 DataInt<=8'b00000111;instrt<=3'b000;
    //I:000 CR:111
    //Enable numarare prin decrementare a numaratorului de adresa si incrementare numarator cuvinte
   #30 instrt<=3'b111;
    //I:111 CR:111
    
   #30 instrt<=3'b011; aci<=1'b1;
    //I:011 CR:111
   #30 instrt<=3'b111; 
    //I:111 CR:111
   #30 instrt<=3'b010; 
    //I:010 CR:111
    #30 instrt<=3'b100;
    //I:100 CR:111
    #30 DataInt<=8'b00000001;instrt<=3'b000;
    //I:000 CR:001
    #30 instrt<=3'b100;
    //I:100 CR:001
    #30 instrt<=3'b110;
    //I:100 CR:111
    #30 DataInt<=8'b00000000;instrt<=3'b000; aci<=1'b0;
    //I:000 CR:000
    #30 instrt<=3'b111; 
    //I:111 CR:000
    #30 DataInt<=8'b00000110;instrt<=3'b000; aci<=1'b0;
    //I:000 CR:110
    #30 instrt<=3'b111;
     //I:111 CR:110
  end
  initial
    #800 $finish;
  initial begin
    #0 clkt=1'b0;
    forever #5 clkt=~clkt;
  end
  initial
 begin
	$dumpfile("testul.vcd");
    $dumpvars(0,implementare2940_inst);
 end
endmodule

/*
Instructiuni testate:
I_CR:
000_xxx
001_xxx
010_xxx
011_xxx
100_x11
100_x01
101_xxx
110_xx0,x11
110_x01
111_000
111_0x1
111_010
111_100
111_110
111_1x1
*/