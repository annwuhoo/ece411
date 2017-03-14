import lc3b_types::*;

module cccomp #(parameter width = 3)
(
	input [width-1:0] in, // apparently dest[2] = n, dest[1] = z, dest[0] = p
	input lc3b_nzp nzp,
	output logic branch_enable
);

always_comb
begin
	branch_enable = 0;
	case (nzp)
		3'b100 : begin
					if (in[2])
						branch_enable = 1;
				  end
		3'b010 : begin
					if (in[1])
						branch_enable = 1;
				  end
		3'b001 : begin
					if (in[0])
						branch_enable = 1;
				  end
		default: $display("Invalid nzp operand");
	endcase
end

endmodule : cccomp