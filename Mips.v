
module Mips(Clk,Reset);
	
	input Clk;
	input Reset;
	wire [31:0] addressts	;
//PC	
	wire [31:0] pcOut;


//IM	
	wire [4:0]  imAdr;
	wire [31:0] opCode;
	
//GPR
	wire [4:0] gprWeSel,gprReSel1,gprReSel2;
	wire [31:0] gprDataIn;
	
	wire [31:0] gprDataOut1,gprDataOut2;
	
//Extender

	wire [15:0] extDataIn;
	wire [31:0] extDataOut;
	
//DMem

	wire [4:0]  dmDataAdr;
	wire [31:0] dmDataOut;
	
//Ctrl
	
	wire [5:0]		op;
	wire [5:0]		funct;
	wire 		jump;						//指令跳转
	wire 		RegDst;						
	wire 		Branch;						//分支
	wire 		MemR;						//读存储器
	wire 		Mem2R;						//数据存储器到寄存器堆
	wire 		MemW;						//写数据存储器
	wire 		RegW;						//寄存器堆写入数据
	wire		Alusrc;						//运算器操作数选择
	wire 		ExtOp;						//位扩展/符号扩展选择
	wire [5:0]  Aluctrl;						//Alu运算选择

//Alu
	wire [31:0] aluDataIn2;
	wire [31:0]	aluDataOut;
	wire 		zero;
	
	//assign pcSel = ((Branch&&zero)==1)?1:0;
	assign pcSel = (Branch&&aluDataOut==1)?1:0;
	
//PC块实例�
    
   assign addressts=(Branch&&aluDataOut==1)?extDataOut:aluDataOut;
    
   // if((Branch&&aluDataOut)!=0)
    //  assign addressts[31:0]=extDataOut[31:0];
    //if(jump)
    //assign addressts[31:0]=aluDataOut[31:0];
    
    PcUnit U_pcUnit(.OpCode(opCode),.PC(pcOut),.PcReSet(Reset),.PcSel(pcSel),.Clk(Clk),.Adress(addressts),.jump(jump));
	
	assign imAdr = pcOut[6:2];
//指令寄存器实例化	
	IM U_IM(.OpCode(opCode),.ImAdress(imAdr));
	
	assign op = opCode[31:26];
	assign funct = opCode[5:0];
	assign gprReSel1 = opCode[25:21];
	assign gprReSel2 = opCode[20:16];
	
	
	assign gprWeSel = (RegDst==0)?opCode[20:16]:opCode[15:11];//RT RD

	assign extDataIn = opCode[15:0];
	
//寄存器堆实例化
	GPR U_gpr(.PC(pcOut),.OpCode(opCode),.DataOut1(gprDataOut1),.DataOut2(gprDataOut2),.clk(Clk),.WData(gprDataIn)
			  ,.WE(RegW),.WeSel(gprWeSel),.ReSel1(gprReSel1),.ReSel2(gprReSel2));
//控制器实例化	
	Ctrl U_Ctrl(.jump(jump),.RegDst(RegDst),.Branch(Branch),.MemR(MemR),.Mem2R(Mem2R)
				,.MemW(MemW),.RegW(RegW),.Alusrc(Alusrc),.ExtOp(ExtOp),.Aluctrl(Aluctrl)
				,.OpCode(op),.funct(funct));
				
//扩展器实例化	
	Extender U_extend(.ExtOut(extDataOut),.DataIn(extDataIn),.ExtOp(ExtOp));
	
	
	
	assign aluDataIn2 = (Alusrc==1)?extDataOut:gprDataOut2;
	Alu U_Alu(.OpCode(opCode),.PC(pcOut),.AluResult(aluDataOut),.Zero(zero),.DataIn1(gprDataOut1),.DataIn2(aluDataIn2),.AluCtrl(Aluctrl));
	
	
	assign gprDataIn = (Mem2R==1)?dmDataOut:aluDataOut;//gprDataIn ??????
	assign dmDataAdr = aluDataOut[4:0];
	DMem U_Dmem(.DataOut(dmDataOut),.DataAdr(dmDataAdr),.DataIn(gprDataOut2),.DMemW(MemW),.DMemR(MemR),.clk(Clk));
endmodule//dmDataOut ??????











