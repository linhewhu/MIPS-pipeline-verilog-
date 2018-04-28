
module Extender(ExtOut,DataIn,ExtOp);

	input [15:0] DataIn;
	input ExtOp;
	output reg[31:0] ExtOut;
	
	integer it,i;					//逻辑计数
	
	always@(DataIn or ExtOp or it or ExtOut)
	begin
		if(ExtOp == 1)
			begin
				for(it=0;it<32;it=it+1)
				begin
					if(it<16)
					  begin
					    
						ExtOut[it] =0 ;
						end
					else
						ExtOut[it] = DataIn[it-16];
				end	
			end
		else
			begin
				for(it=0;it<32;it=it+1)
				begin
					if(it<16)
						ExtOut[it] = DataIn[it];
					else
						ExtOut[it] = DataIn[15];
				end
			end
	end
endmodule