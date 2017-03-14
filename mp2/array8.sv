import lc3b_types::*;

/* Parametrized  */
module array8 #(parameter width = 128)
(
    input clk,
	 input [width-1:0] in,
    input lc3b_c_index index,
	 input load,
    output logic [width-1:0] out
);

logic [width-1:0] data [7:0];

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 1'b0;
    end
end

always_ff @(posedge clk)
begin
    if (load == 1)
    begin
        data[index] = in;
    end
end

assign out = data[index];

endmodule : array8