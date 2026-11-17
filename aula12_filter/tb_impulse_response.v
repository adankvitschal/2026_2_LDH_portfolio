`timescale 100ns/100ns

module tb_impulse_response;

	integer f;
	reg 						rst, clk;
	reg 	signed [11:0]	x;
	wire 	signed [11:0]	y;
	
	always #5 clk = ~clk; //Clock 1MHz

	bw2_filter dut (
		.rst(rst), .clk(clk),
		.x(x), .y(y)
	);

	always begin
		#10
		$monitor("%d, %d", x, y);
		$fwrite(f,"%d, %d\n",x,y);
	end
	
	//Stimuli
	initial begin
		f = $fopen("output.csv","w");
		clk = 0;
		rst = 1;
		#10; //1 clock cycle
		rst = 0;
		x = 12'sb010000000000;
		#10
		x = 12'sd0;
		#200
		$fclose(f);
		$finish;
	end
	
endmodule
