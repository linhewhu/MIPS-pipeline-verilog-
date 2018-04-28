

module Ctrl(jump,RegDst,Branch,MemR,Mem2R,MemW,RegW,Alusrc,ExtOp,Aluctrl,OpCode,funct);
	
	input [5:0]		OpCode;				//指令操作码字段
	input [5:0]		funct;				//指令功能字段

	output jump;						//指令跳转
	output RegDst;						
	output Branch;						//分支
	output MemR;						//读存储器
	output Mem2R;						//数据存储器到寄存器堆
	output MemW;						//写数据存储器
	output RegW;						//寄存器堆写入数据
	output Alusrc;						//运算器操作数选择
	output ExtOp;						//位扩展/符号扩展选择
	output reg[5:0] Aluctrl;						//Alu运算选择
	
	
	assign jump =(OpCode[1]&&(!OpCode[2])&&(!OpCode[3])&&(!OpCode[4])&&(!OpCode[5]) )||(funct==6'b001000);
	assign RegDst = (!(OpCode[1]||OpCode[2]))&&(OpCode!=6'b001000);
	            
	assign Branch =OpCode[2]&&(!OpCode[1])&&(!OpCode[3])&&(!OpCode[4])&&(!OpCode[5]);
	assign MemR =((OpCode[0]&&OpCode[1]&&(!OpCode[2])&&(!OpCode[3])&&(!OpCode[4])&&OpCode[5]));
	assign Mem2R = MemR;
	assign MemW = OpCode[3]&&OpCode[5];
	assign RegW = (OpCode==6'b001000)||  ((OpCode[0])&&(OpCode[1])&&(!OpCode[2])&&(!OpCode[3])&&(!OpCode[4])&&(!OpCode[5]))||((OpCode[0])&&(OpCode[1])&&(!OpCode[2])&&(!OpCode[3])&&(!OpCode[4])&&(OpCode[5]))|| ( (!OpCode[0])&&(!OpCode[1])&&(!OpCode[2])&&(!OpCode[3])&&(!OpCode[4])&&(!OpCode[5]))||(OpCode[0]&&OpCode[1]&&OpCode[2]&&OpCode[3])||(OpCode[0]&&(!OpCode[1])&&OpCode[2]&&OpCode[3]);
	assign Alusrc = (OpCode[1]&&OpCode[0]&&OpCode[5])||(OpCode[3]&&OpCode[2])||(OpCode==6'b001000);

	assign ExtOp = OpCode[0]&&OpCode[1]&&OpCode[2]&&OpCode[3];
//                ((OpCode[0])&&(OpCode[1])&&(OpCode[2])&&(OpCode[3])&&(OpCode[4])&&(OpCode[5]))
//                ((!OpCode[0])&&(!OpCode[1])&&(!OpCode[2])&&(!OpCode[3])&&(!OpCode[4])&&(!OpCode[5]))
always@(Aluctrl or OpCode[1] or OpCode[2]or funct)
	begin

	    if(OpCode[1]&&OpCode[0]&&OpCode[5])
	       Aluctrl= 6'b100000;
	    else
	      if(((OpCode==6'b000000)&&(funct==6'b000000))==1)
	        Aluctrl=6'b000000;
	        else
	      begin
		        //if((OpCode[1]||OpCode[2])==1)
		        if(OpCode==6'b000000)
		          Aluctrl=funct;
		        else
		          Aluctrl=OpCode;
		     end
	end

  	
endmodule