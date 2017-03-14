import lc3b_types::*;

// the correct arrays to output loads to is arbitrated by larb and control signals
// For whichever arrays have a control signal load assert, demux will assert load0 and load1 for those array's load signals
module loadarbitrator_demux
(
	input logic load0, load1,
	input logic load_data_valid_dirty, load_tag,
	
	output logic load_data_valid_dirty0, load_data_valid_dirty1,
	output logic load_tag0, load_tag1
);

always_comb begin
	load_data_valid_dirty0 = 0;
	load_data_valid_dirty1 = 0;
	load_tag0 = 0; 
	load_tag1 = 0;
	
	if (load_data_valid_dirty) begin
		load_data_valid_dirty0 = load0;
		load_data_valid_dirty1 = load1;
	end
	
	if (load_tag) begin
		load_tag0 = load0; 
		load_tag1 = load1;
	end
	
end

endmodule : loadarbitrator_demux