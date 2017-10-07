module write_cycle(latch, count, DE, nWE, writing, read, write, reset, clk);

  input wire read, write, reset, clk;
  output reg latch, count, DE, nWE, writing;

  parameter SIZE = 3;
  parameter IDLE = 3'b000, STEP1 = 3'b001, STEP2 = 3'b010, STEP3 = 3'b011,
            STEP4 = 3'b100;

  reg [SIZE-1:0] state;//, next_state;

  always @ (posedge clk)
  begin
    if (reset == 1) begin// high reset?
      latch <= 0;
      count <= 1;
      DE <= 1;
      nWE <= 1;
      writing <= 0;
		state <= IDLE;
      //next_state <= IDLE;
    end
    else begin
      case(state)
        IDLE:   if (read == 0 & write == 1) begin
                  state <= STEP1;
                  writing <= 1;
                end
                else begin
                  state <= IDLE;
                  writing <= 0;
                end

        STEP1: begin
                  latch <= 1;
                  state <= STEP2;
                end

        STEP2: begin
                  count <= 0;
                  latch <= 0;
                  //DE <= 1;
                  state <= STEP3;
                end

        STEP3: begin
                  //DE <= 0;
                  nWE <= 0;
                  state <= STEP4;
                end

        STEP4: begin
						//DE <= 0;
                  count <= 1;
                  nWE <= 1;
                  if (write == 1 & read == 0) begin
                    state <= STEP1;
                  end
                  else begin
                    state <= IDLE;
                    writing <= 0;
                  end
                end

      endcase
    end
  end

endmodule
