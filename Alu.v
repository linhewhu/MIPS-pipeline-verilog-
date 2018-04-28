`include "ctrl_encode_def.v"
module Alu (OpCode,PC,DataIn1, DataIn2, AluCtrl, AluResult, Zero);
           
   input  [31:0] DataIn1, DataIn2,PC,OpCode;
   input  [5:0]  AluCtrl;
   output [31:0] AluResult;
   output        Zero;
   integer i,j;
 
   reg [31:0] AluResult;
    //reg [25:0] tempp;  
     // assign    tempp=OpCode[25:0];
   always @( DataIn1 or DataIn2 or AluCtrl ) 
   begin
      case ( AluCtrl )
         `INSTR_ADD: AluResult = DataIn1 + DataIn2;
         `INSTR_SUB: AluResult = DataIn1 - DataIn2;
         `INSTR_ADDI: AluResult = DataIn1 + DataIn2;
        
         `INSTR_ANDI: AluResult = DataIn1 &DataIn2;
         `INSTR_OR:AluResult = DataIn1 |DataIn2;
         `INSTR_ORI:AluResult = DataIn1 |DataIn2;
	       `INSTR_XOR:AluResult = !(DataIn1 ==DataIn2);
         `INSTR_AND:AluResult = DataIn1 &DataIn2;
         `INSTR_LUI:AluResult =DataIn2;
         
      
               ` INSTR_ADDU:
               AluResult =($unsigned(DataIn1))+ ($unsigned(DataIn2) ) ;
               
               //6'b100001

             ` INSTR_SUBU : AluResult =($unsigned(DataIn1))- ($unsigned(DataIn2) ) ;
              // 6'b100011
         `INSTR_JR:
                    if(OpCode[31:26]==0)
                      
                         AluResult =DataIn1;   
                       else
           //`INSTR_ADDI: 
                     AluResult = DataIn1 + DataIn2;     
         `INSTR_J:      // AluResult=0;
       //  INSTR_SRL    6'b000010
         
         begin
             if(OpCode[31:26]==0)
                begin
                 i=OpCode[10:6];
                 AluResult=0;
                 for(j=i;j<32;j=j+1)
                   AluResult[j-i]= DataIn2[j];
                end
            else
                begin
                       AluResult=0;
                      for(i=0;i<26;i=i+1)
						              AluResult[i+2]=  OpCode[i];
						          for(i=28;i<32;i=i+1)
						              AluResult[i]=  PC[i];
                end
        end

`INSTR_JAL:	
      // INSTR_SRA     6'b000011  
             begin
             if(OpCode[31:26]==0)
                begin
                 i=OpCode[10:6];
                 AluResult=DataIn2[31];
                 for(j=i;j<32;j=j+1)
                   AluResult[j-i]= DataIn2[j];
                end
            else
                begin
                       AluResult=0;
                      for(i=0;i<26;i=i+1)
						              AluResult[i+2]=  OpCode[i];
						          for(i=28;i<32;i=i+1)
						              AluResult[i]=  PC[i];
                end
        end
`INSTR_SLT:
             if(($signed(DataIn1)) < ($signed(DataIn2)))
                              AluResult = 1;
                           else
                               AluResult = 0;


`INSTR_SLL :begin
                 i=OpCode[10:6];
                 AluResult=DataIn2[0];
                 for(j=0;j<32-i;j=j+1)
                   AluResult[i+j]= DataIn2[j];
                end 
// 6'b000000

/*begin
  
  
                    if(DataIn1[31] < DataIn2[31])
                       AluResult = 0;
                    else
                     begin
                           if(DataIn1 < DataIn2)
                              AluResult = 1;
                           else
                               AluResult = 0;
                     end
             end*/
          `INSTR_BEQ: 
                 // begin
                    if(DataIn1 == DataIn2)
                       AluResult = 1;
                    else
                      
                      
                           AluResult = 0;
          `INSTR_BNE: 
                 // begin
                    if(DataIn1 != DataIn2)
                       AluResult = 1;
                    else
                       AluResult = 0;
       

         default:   ;
      endcase
   end // end always;
   
   assign Zero = (DataIn1 == DataIn2) ? 1 : 0;

endmodule
    



