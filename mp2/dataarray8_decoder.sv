import lc3b_types::*;

/* 
 * Input: index, load
 * Output: loads 0-7
 * Description: For the load# that matches the index, load# = load. This is to arbitrate loading the different registers in the dataarray8 module.
 */
module dataarray8_decoder
(
	input index,
	input load,
	output load0,
	output load1,
	output load2,
	output load3,
	output load4,
	output load5,
	output load6,
	output load7
);

always_comb begin
	load0 = 0;
	load1 = 0;
	load2 = 0;
	load3 = 0;
	load4 = 0;
	load5 = 0;
	load6 = 0
	load7 = 0;
	
	case(index)
		3'b000: load0 = load;
		3'b001: load1 = load;
		3'b010: load2 = load;
		3'b011: load3 = load;
		3'b100: load4 = load;
		3'b101: load5 = load;
		3'b110: load6 = load;
		3'b111: load7 = load;		
	endcase

end

endmodule : dataarray8_decoder